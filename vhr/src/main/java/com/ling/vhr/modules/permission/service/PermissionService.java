package com.ling.vhr.modules.permission.service;

import com.baomidou.mybatisplus.extension.service.IService;
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

public interface PermissionService extends IService<PermissionDO> {



    /**
     * @param code
     * @param url
     * @return
     */
    List<PermissionDO> selectPermissions(String code, String url);

    /**
     * 刷新权限接口列表
     */
    void fresh();


    /**
     * 扫描所有 Controller
     */
    void scanController();
}
