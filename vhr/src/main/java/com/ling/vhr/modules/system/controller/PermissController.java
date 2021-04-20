package com.ling.vhr.modules.system.controller;

import com.ling.vhr.modules.system.model.Role;
import com.ling.vhr.modules.system.service.RoleService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 权限组
 * @author zhangling  2021/4/20 21:39
 */
@Api(tags = "权限组")
@RestController
@RequestMapping("/system/basic/permiss")
public class PermissController {

    @Autowired
    RoleService roleService;

    @GetMapping("/")
    public List<Role> selectAllRoles() {
        return roleService.selectAllRoles();
    }
}
