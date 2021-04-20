package com.ling.vhr.modules.system.service;

import com.ling.vhr.mapper.RoleMapper;
import com.ling.vhr.modules.system.model.Role;
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
}
