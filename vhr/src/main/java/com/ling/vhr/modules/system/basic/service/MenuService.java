package com.ling.vhr.modules.system.basic.service;

import com.ling.vhr.common.exception.RrException;
import com.ling.vhr.mapper.MenuMapper;
import com.ling.vhr.mapper.MenuRoleMapper;
import com.ling.vhr.modules.system.basic.model.Hr;
import com.ling.vhr.modules.system.basic.model.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author zhangling  2021/4/17 14:11
 */
@Service
public class MenuService {

    @Autowired
    MenuMapper menuMapper;

    @Autowired
    MenuRoleMapper menuRoleMapper;

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

    /**
     * 获取所有权限组菜单
     * @return 返回三级目录树菜单
     */
    public List<Menu> getAllMenus() {
        return menuMapper.getAllMenus();
    }

    /**
     * 根据角色id查询角色拥有的菜单权限
     * @param rid
     * @return 拥有的菜单权限id，拥有的菜单id默认被选中
     */
    public List<Integer> getMidsByRid(Integer rid) {
        return menuMapper.getMidsByRid(rid);
    }

    @Transactional(rollbackFor = Exception.class)
    public boolean updateMenuRole(Integer rid, Integer[] mids) {
        // 先删除角色拥有的所有菜单，再添加更新后的菜单
        menuRoleMapper.deleteByRoleId(rid);
        Integer result = menuRoleMapper.insertRecord(rid, mids);
        return result == mids.length;
    }
}
