package com.ling.vhr.modules.system.basic.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.basic.model.Menu;
import com.ling.vhr.modules.system.hr.model.Role;
import com.ling.vhr.modules.system.basic.service.MenuService;
import com.ling.vhr.modules.system.hr.service.RoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 权限组
 *
 * @author zhangling  2021/4/20 21:39
 */
@Api(tags = "权限组")
@RestController
@RequestMapping("/system/basic/permiss")
public class PermissController {

    @Autowired
    RoleService roleService;

    @Autowired
    MenuService menuService;

    @ApiOperation(value = "权限职列表", notes = "权限组列表")
    @GetMapping(name = "权限组列表", value = "/")
    public List<Role> selectAllRoles() {
        return roleService.selectAllRoles();
    }


    @ApiOperation(value = "查询所有菜单", notes = "查询所有菜单")
    @GetMapping(name = "查询所有菜单", value = "/menus")
    public List<Menu> selectAllMenus() {
        return menuService.getAllMenus();
    }


    @ApiOperation(value = "根据角色id查询角色拥有的菜单权限", notes = "根据角色id查询角色拥有的菜单权限")
    @GetMapping(name = "根据角色id查询角色拥有的菜单权限", value = "/mids/{rid}")
    public List<Integer> getMidsByRid(@PathVariable Integer rid) {
        return menuService.getMidsByRid(rid);
    }


    @ApiOperation(value = "更新角色所拥有的菜单", notes = "更新角色所拥有的菜单")
    @PutMapping(name = "更新角色所拥有的菜单", value = "/")
    public CommonResult updateMenuRole(Integer rid, Integer[] mids) {
        if (menuService.updateMenuRole(rid, mids)) {
            return CommonResult.success(null, "更新成功！");
        }
        return CommonResult.error("更新失败！");
    }


    @ApiOperation(value = "添加角色", notes = "添加角色")
    @PostMapping(name = "添加角色", value = "/role")
    public CommonResult addRole(@RequestBody Role role) {
        if (roleService.addRole(role) == 1) {
            return CommonResult.success(null, "添加成功！");
        }
        return CommonResult.error("添加失败！");
    }

    @ApiOperation(value = "删除角色", notes = "删除角色")
    @DeleteMapping(name = "删除角色",value = "/role/{id}")
    public CommonResult deleteRole(@PathVariable Integer id) {
        if (roleService.deleteRole(id) == 1) {
            return CommonResult.success(null, "删除成功！");
        }
        return CommonResult.error("失败失败！");
    }
}
