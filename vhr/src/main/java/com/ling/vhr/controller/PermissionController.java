package com.ling.vhr.controller;

import com.ling.vhr.mapper.PermissionMapper;
import com.ling.vhr.model.PermissionDO;
import com.ling.vhr.service.PermissionService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

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
    public List<PermissionDO> selectPermissions(String code, String url) {
        return permissionService.selectPermissions(code, url);
    }

    /**
     * 刷新权限表
     */
    @PostMapping("/fresh")
    public void fresh() {
        permissionService.fresh();
    }

    @GetMapping("/test")
    public void testProxy(){
        permissionService.testProxy();
    }


}
