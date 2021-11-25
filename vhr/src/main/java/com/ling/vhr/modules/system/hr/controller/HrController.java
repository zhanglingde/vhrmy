package com.ling.vhr.modules.system.hr.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.hr.model.Hr;
import com.ling.vhr.modules.system.hr.model.Role;
import com.ling.vhr.modules.system.hr.service.HrService;
import com.ling.vhr.modules.system.hr.service.RoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.filter.CommonsRequestLoggingFilter;

import java.util.List;

/**
 * @author zhangling 2021/4/23 16:50
 */
@RestController
@RequestMapping("/system/hr")
@Api(tags = "Hr 管理")
public class HrController {

    @Autowired
    HrService hrService;

    @Autowired
    RoleService roleService;

    @ApiOperation(value = "获取所有Hr用户(除自己之外)")
    @GetMapping(name = "获取所有Hr用户(除自己之外)", value = "/")
    public List<Hr> getAllHrs(String keywords) {
        return hrService.getAllHrs(keywords);
    }

    @ApiOperation(value = "更新Hr用户基本信息")
    @PutMapping(name = "更新Hr用户基本信息", value = "/")
    public CommonResult updateHr(@RequestBody Hr hr) {
        if (hrService.updateHr(hr) == 1) {
            return CommonResult.success(null, "修改成功！");
        }
        return CommonResult.error("修改失败！");
    }

    @ApiOperation(value = "获取所有角色")
    @GetMapping(name = "获取所有角色", value = "/roles")
    public List<Role> getAllRoles() {
        return roleService.selectAllRoles();
    }

    /**
     * 更新Hr用户角色关联
     *
     * @return
     */
    @ApiOperation(value = "更新Hr用户角色关联")
    @PutMapping(name = "更新Hr用户角色关联", value = "/hr-role")
    public CommonResult updateHrRole(Integer hrId, Integer[] roleIds) {
        if (hrService.updateHrRole(hrId, roleIds)) {
            return CommonResult.success(null, "更新Hr角色成功！");
        }
        return CommonResult.error("更新失败！");
    }

    @DeleteMapping(name = "删除Hr用户", value = "/{hrId}")
    public CommonResult deleteHr(@PathVariable Integer hrId) {
        if (hrService.deleteHr(hrId) == 1) {
            return CommonResult.success(null, "删除成功！");
        }
        return CommonResult.error("删除失败！");
    }

}
