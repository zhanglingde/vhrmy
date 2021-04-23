package com.ling.vhr.modules.system.basic.service;

import com.ling.vhr.mapper.RoleMapper;
import com.ling.vhr.modules.system.basic.model.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author zhangling  2021/4/20 21:41
 */
@Service
public class RoleService {

    @Autowired
    RoleMapper roleMapper;

    public List<Role> selectAllRoles() {
        return roleMapper.selectAllRoles();
    }

    public int addRole(Role role) {
        if(!role.getName().startsWith("ROLE_")){
            role.setName("ROLE_"+role.getName());
        }
        return roleMapper.insert(role);
    }

    public int deleteRole(Integer id) {
        return roleMapper.deleteByPrimaryKey(id);
    }
}
