package com.ling.vhr.controller;

import com.ling.vhr.model.Menu;
import com.ling.vhr.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
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
