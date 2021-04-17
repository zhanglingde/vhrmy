package com.ling.vhr.mapper;

import com.ling.vhr.model.Menu;
import org.apache.ibatis.annotations.Param;
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
}