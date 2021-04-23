package com.ling.vhr.modules.system.hr.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.hr.model.Hr;
import com.ling.vhr.modules.system.hr.model.Role;
import com.ling.vhr.modules.system.hr.service.HrService;
import com.ling.vhr.modules.system.hr.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author zhangling 2021/4/23 16:50
 */
@RestController
@RequestMapping("/system/hr")
public class HrController {

    @Autowired
    HrService hrService;

    @Autowired
    RoleService roleService;

    @GetMapping("/")
    public List<Hr> getAllHrs(String keywords) {
        return hrService.getAllHrs(keywords);
    }

    @PutMapping("/")
    public CommonResult updateHr(@RequestBody Hr hr) {
        if (hrService.updateHr(hr) == 1) {
            return CommonResult.success(null,"修改成功！");
        }
        return CommonResult.error("修改失败！");
    }

    @GetMapping("/roles")
    public List<Role> getAllRoles() {
        return roleService.selectAllRoles();
    }

    /**
     * 更新Hr用户角色关联
     * @return
     */
    @PutMapping("/hr-role")
    public CommonResult updateHrRole(Integer hrId,Integer[] roleIds) {
        if (hrService.updateHrRole(hrId, roleIds)) {
            return CommonResult.success(null,"更新Hr角色成功！");
        }
        return CommonResult.error("更新失败！");
    }

}
