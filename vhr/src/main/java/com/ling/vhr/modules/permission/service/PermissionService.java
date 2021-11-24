package com.ling.vhr.modules.permission.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ling.vhr.common.utils.SpringContextUtils;
import com.ling.vhr.mapper.PermissionMapper;
import com.ling.vhr.modules.permission.model.PermissionDO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author zhangling
 * @date 2021/10/8 4:52 下午
 */
@Service
public class PermissionService {

    private static final Logger logger = LoggerFactory.getLogger(PermissionService.class);

    @Autowired
    PermissionMapper permissionMapper;

    RestTemplate restTemplate = new RestTemplate();
    ObjectMapper objectMapper = new ObjectMapper();

    /**
     * @param code
     * @param url
     * @return
     */
    public List<PermissionDO> selectPermissions(String code, String url) {
        return permissionMapper.selectPermissions(code, url);
    }

    public void fresh() {
       scanController();
//         parse();
    }

    private void parse() {

        String json = null;
        try {
            json = fetchFromSwagger();
            JsonNode jsonNode = objectMapper.readTree(json);
            Iterator<Map.Entry<String, JsonNode>> paths = jsonNode.get("paths").fields();
            ArrayList<PermissionDO> permissions = new ArrayList();
            // 遍历接口并将其解析加入 permissions 中
            while (paths.hasNext()) {
                Map.Entry<String, JsonNode> pathNode = paths.next();
                Iterator<Map.Entry<String, JsonNode>> methodIterator = ((JsonNode) pathNode.getValue()).fields();
                perserMethod(methodIterator, pathNode, permissions);
            }

            List<PermissionDO> permissionList = permissionMapper.selectAllPermission();
            Map<String, PermissionDO> codeMap = permissionList.stream().collect(Collectors.toMap(PermissionDO::getCode, p -> p));

            permissions.parallelStream().forEach(permission ->{
                PermissionDO p = codeMap.get(permission.getCode());
                if (p == null) {
                    permissionMapper.insert(permission);
                }else{
                    permission.setId(p.getId());
                    permissionMapper.updateByPrimeryKey(permission);
                }
            });

            // 缓存权限

        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

    }

    /**
     * 解析文档树某个路径的所有方法
     *
     * @param methodIterator 所有方法
     * @param pathNode       路径
     */
    private void perserMethod(Iterator<Map.Entry<String, JsonNode>> methodIterator, Map.Entry<String, JsonNode> pathNode, ArrayList permissions) {
        while (methodIterator.hasNext()) {
            Map.Entry<String, JsonNode> methodNode = methodIterator.next();
            JsonNode tags = ((JsonNode) methodNode.getValue()).get("tags");
            String resourceCode = processResourceCode(tags);
            JsonNode extraDataNode = ((JsonNode) methodNode.getValue()).get("description");
            PermissionDO permission = processPermission((String) pathNode.getKey(), methodNode, resourceCode);
            permissions.add(permission);
        }
    }

    private PermissionDO processPermission(String key, Map.Entry<String, JsonNode> methodNode, String resourceCode) {
        String method = methodNode.getKey();
        String description = ((JsonNode) methodNode.getValue()).get("summary").asText();
        PermissionDO permission = new PermissionDO().setCode(resourceCode)
                .setUrl(key)
                .setMethod(method)
                .setDescription(description)
                .setAction(key);
        return permission;
    }

    private String processResourceCode(JsonNode tags) {
        String resourceCode = null;

        for(int i = 0; i < tags.size(); ++i) {
            String tag = tags.get(i).asText();
            if (tag.endsWith("-controller")) {
                resourceCode = tag.substring(0, tag.length() - "-controller".length());
            } else if (tag.endsWith("-endpoint")) {
                resourceCode = tag.substring(0, tag.length() - "-endpoint".length());
            } else {
                resourceCode = tag.replace(" ", "-").replace("(", "-").replace(")", "").replaceAll("-+", "-").toLowerCase();
            }
        }

        return resourceCode;
    }


    // 拉取 swagger 接口文档数据
    private String fetchFromSwagger() {
        String url = "http://localhost:8081/v3/api-docs";
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class, new Object[0]);
        return response.getStatusCode() == HttpStatus.OK ? response.getBody() : null;
    }

    /**
     * 扫描所有 Controller
     */
    public void scanController() {
        List<PermissionDO> permissions = new ArrayList<>();
        Map<String, Object> map = SpringContextUtils.getBeansWithAnnotation(RestController.class);
        // 遍历所有 Controller
        for (Object controller : map.values()) {
            RequestMapping requestMapping = controller.getClass().getAnnotation(RequestMapping.class);
            Method[] methods = controller.getClass().getDeclaredMethods();
            if (requestMapping != null && requestMapping.value().length != 0) {
                // @RequestMapping 路径前缀
                String[] prefixs = requestMapping.value();
                for (String prefix : prefixs) {
                    // 解析 Controller 下的所有接口
                    for (Method method : methods) {
                        // RequestMapping annotation = AnnotationUtils.getAnnotation(method, RequestMapping.class);
                        GetMapping getMapping = AnnotationUtils.getAnnotation(method, GetMapping.class);
                        // ApiOperation api = method.getAnnotation(ApiOperation.class);
                        if (getMapping != null) {
                            String[] value = getMapping.value();

                            for (String s : value) {
                                PermissionDO permission = new PermissionDO()
                                        .setMethod("get")
                                        .setUrl(prefix + s)
                                        .setAction(method.getName())
                                        .setCode(controller.getClass().getSimpleName() + "." + method.getName());

                                permission.setDescription(getMapping.name());
                                // swagger 注解接口描述
                                // if (api != null) {
                                //     permission.setDescription(api.value());
                                // }
                                // permissions.add(permission);
                                permissionMapper.insert(permission);
                            }
                        }
                        // 是否包含 PostMapping 注解
                        if (method.isAnnotationPresent(PostMapping.class)) {
                            logger.info("有 @PostMapping 注解的方法：{}",method.getName());
                        }
                    }
                }
            }


        }
//        permissions.forEach(p -> System.out.println(permissions));
    }
}
