package com.ling.vhr.modules.system.service;

import com.ling.vhr.common.exception.RrException;
import com.ling.vhr.mapper.MenuMapper;
import com.ling.vhr.modules.system.model.Hr;
import com.ling.vhr.modules.system.model.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author zhangling  2021/4/17 14:11
 */
@Service
public class MenuService {

    @Autowired
    MenuMapper menuMapper;

    /**
     * 根据用户id查询菜单
     * @return
     */
    public List<Menu> selectMenusByHrId() {
        // 获得登录的对象
        Hr hr = ((Hr) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
        if (hr == null) {
            throw new RrException("用户未登录，请登录！");
        }
        List<Menu> menus = menuMapper.selectMenusByHrId(hr.getId());
        return menus;
    }

    public List<Menu> selectAllMenus() {
        return menuMapper.selectAllMenus();
    }
}
