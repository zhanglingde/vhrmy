package com.ling.vhr.mapper;

import com.ling.vhr.modules.system.model.Menu;

import java.util.List;
import org.springframework.stereotype.Repository;

/**
 * (Menu)Mapper持久层
 *
 * @author zhangling 2021-04-16 21:13:10
 */
@Repository
public interface MenuMapper {


    /**
     * 查询登录用户的角色所拥有的菜单
     * @param hrId
     * @return
     */
    List<Menu> selectMenusByHrId(Integer hrId);

    /**
     * 查询所有菜单
     * @return
     */
    List<Menu> selectAllMenus();

    /**
     * 获取所有权限组菜单
     * @return 返回三级目录树菜单
     */
    List<Menu> getAllMenus();

    List<Integer> getMidsByRid(Integer rid);
}