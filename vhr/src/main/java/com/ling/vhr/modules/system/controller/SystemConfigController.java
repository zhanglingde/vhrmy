package com.ling.vhr.modules.system.controller;

import com.ling.vhr.modules.system.model.Menu;
import com.ling.vhr.modules.system.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 菜单
 * @author zhangling  2021/4/17 14:08
 */
@RestController
@RequestMapping("/system/config")
public class SystemConfigController {

    @Autowired
    MenuService menuService;

    @GetMapping("/menus")
    public List<Menu> selectMenusByHrId() {
        return menuService.selectMenusByHrId();
    }

}
