package com.ling.vhr.mapper;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * 菜单角色关联
 */
@Repository
public interface MenuRoleMapper {
    /**
     * 删除角色下的菜单
     * @param rid
     */
    void deleteByRoleId(Integer rid);

    /**
     * 添加角色关联菜单
     * @param rid 角色id
     * @param mids 关联菜单id数组
     * @return
     */
    Integer insertRecord(@Param("rid")Integer rid,@Param("mids") Integer[] mids);

}
