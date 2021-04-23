package com.ling.vhr.mapper;

import com.ling.vhr.modules.system.basic.model.Role;

import java.util.List;
import org.springframework.stereotype.Repository;

/**
 * (Role)Mapper持久层
 *
 * @author zhangling 2021-04-16 13:14:49
 */
@Repository
public interface RoleMapper {


    /**
     * 根据用户id查询用户所有角色
     * @param hrId
     * @return
     */
    List<Role> selectByHrId(Integer hrId);

    /**
     * 查询所有角色
     * @return
     */
    List<Role> selectAllRoles();

    /**
     * 添加角色
     * @param role
     * @return
     */
    int insert(Role role);

    int deleteByPrimaryKey(Integer id);
}