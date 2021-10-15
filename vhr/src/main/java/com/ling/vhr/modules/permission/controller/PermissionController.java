package com.ling.vhr.modules.permission.controller;

import com.ling.vhr.common.utils.SpringContextUtils;
import com.ling.vhr.mapper.PermissionMapper;
import com.ling.vhr.modules.permission.model.Permission;
import com.ling.vhr.modules.permission.service.PermissionService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author zhangling
 * @date 2021/10/8 2:51 下午
 */
@RestController
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    PermissionMapper permissionMapper;

    @Autowired
    PermissionService permissionService;


    @ApiOperation(value = "查询权限列表")
    @GetMapping("/")
    public List<Permission> selectPermissions(String code, String url) {
        return permissionService.selectPermissions(code, url);
    }

    /**
     * 刷新权限表
     */
    @PostMapping("/fresh")
    public void fresh() {
        permissionService.fresh();

    }


}
