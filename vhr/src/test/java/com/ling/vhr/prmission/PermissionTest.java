package com.ling.vhr.prmission;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ling.vhr.mapper.PermissionMapper;
import com.ling.vhr.modules.permission.model.PermissionDO;
import com.ling.vhr.modules.permission.service.PermissionService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author zhangling
 * @date 2021/10/15 2:28 下午
 */
@SpringBootTest
public class PermissionTest {

    @Autowired
    PermissionMapper permissionMapper;
    @Autowired
    PermissionService permissionService;

    RestTemplate restTemplate = new RestTemplate();
    ObjectMapper objectMapper = new ObjectMapper();

    @Test
    public void scanController() {
        permissionService.scanController();
    }

    @Test
    public void test01() {
        String url = "http://localhost:8081/v3/api-docs";
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class, new Object[0]);
        if (response.getStatusCode() == HttpStatus.OK) {
            String body = response.getBody();
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
                permissions.parallelStream().forEach(permission -> {
                    PermissionDO p = codeMap.get(permission.getCode());
                    if (p == null) {
                        permissionMapper.insert(permission);
                    }else{
                        permission.setId(p.getId());
//                        permissionMapper.update();
                    }
                });

                for (PermissionDO permission : permissions) {
                    System.out.println("permission = " + permission);
                }
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
        }
        System.out.println("end...");
    }

    // 解析方法，并将方法加入权限集合
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

        for (int i = 0; i < tags.size(); ++i) {
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


}
