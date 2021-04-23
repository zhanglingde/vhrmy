package com.ling.vhr.modules.system.hr.service;

import com.ling.vhr.common.utils.HrUtils;
import com.ling.vhr.mapper.HrMapper;
import com.ling.vhr.mapper.RoleMapper;
import com.ling.vhr.modules.system.basic.model.Hr;
import com.ling.vhr.modules.system.basic.model.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author zhangling 2021/4/16 13:18
 */
@Service
public class HrService implements UserDetailsService {

    @Autowired
    HrMapper hrMapper;

    @Autowired
    RoleMapper roleMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Hr hr = hrMapper.selectByUsername(username);
        if(hr == null){
            throw new UsernameNotFoundException("用户不存在!");
        }
        List<Role> roles = roleMapper.selectByHrId(hr.getId());
        hr.setRoles(roles);
        return hr;
    }

    /**
     * 查询除自己之外的所有Hr用户
     * @return
     */
    public List<Hr> getAllHrs() {
        return hrMapper.getAllHrs(HrUtils.getCurrentHr().getId());
    }

    /**
     * 修改Hr用户
     * @param hr
     * @return
     */
    public int updateHr(Hr hr) {
        return hrMapper.updateByPrimaryKeySelective(hr);
    }
}
