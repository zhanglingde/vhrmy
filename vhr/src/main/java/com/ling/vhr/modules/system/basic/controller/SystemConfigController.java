package com.ling.vhr.modules.system.basic.controller;

import com.ling.vhr.modules.system.basic.model.Menu;
import com.ling.vhr.modules.system.basic.service.MenuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 菜单
 *
 * @author zhangling  2021/4/17 14:08
 */
@RestController
@RequestMapping("/system/config")
@Api(tags = "菜单")
public class SystemConfigController {

    @Autowired
    MenuService menuService;

    @ApiOperation(value = "获取用户菜单", notes = "获取用户菜单")
    @GetMapping(name = "获取用户菜单", value = "/menus")
    public List<Menu> selectMenusByHrId() {
        return menuService.selectMenusByHrId();
    }

}
