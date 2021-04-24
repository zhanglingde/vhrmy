package com.ling.vhr.modules.system.basic.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.basic.model.Menu;
import com.ling.vhr.modules.system.hr.model.Role;
import com.ling.vhr.modules.system.basic.service.MenuService;
import com.ling.vhr.modules.system.hr.service.RoleService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @Autowired
    MenuService menuService;

    @GetMapping("/")
    public List<Role> selectAllRoles() {
        return roleService.selectAllRoles();
    }

    /**
     * 查询所有菜单()
     * @return
     */
    @GetMapping("/menus")
    public List<Menu> selectAllMenus() {
        return menuService.getAllMenus();
    }

    /**
     * 根据角色id查询角色拥有的菜单权限
     * @param rid
     * @return
     */
    @GetMapping("/mids/{rid}")
    public List<Integer> getMidsByRid(@PathVariable Integer rid) {
        return menuService.getMidsByRid(rid);
    }

    /**
     * 更新角色所拥有的菜单
     * @param rid
     * @param mids
     * @return
     */
    @PutMapping("/")
    public CommonResult updateMenuRole(Integer rid, Integer[] mids) {
        if (menuService.updateMenuRole(rid, mids)) {
            return CommonResult.success(null,"更新成功！");
        }
        return CommonResult.error("更新失败！");
    }

    // 添加角色
    @PostMapping("/role")
    public CommonResult addRole(@RequestBody Role role) {
        if (roleService.addRole(role) == 1) {
            return CommonResult.success(null,"添加成功！");
        }
        return CommonResult.error("添加失败！");
    }

    @DeleteMapping("/role/{id}")
    public CommonResult deleteRole(@PathVariable Integer id) {
        if (roleService.deleteRole(id) == 1) {
            return CommonResult.success(null,"删除成功！");
        }
        return CommonResult.error("失败失败！");
    }
}