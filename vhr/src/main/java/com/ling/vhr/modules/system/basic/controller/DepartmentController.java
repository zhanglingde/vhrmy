package com.ling.vhr.modules.system.basic.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.basic.model.Department;
import com.ling.vhr.modules.system.basic.service.DepartmentService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 部门管理
 * @author zhangling 2021/4/22 17:09
 */
@RestController
@RequestMapping("/system/basic/department")
@Api(tags = "部门管理")
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    @GetMapping("/")
    public List<Department> selectAllDepartment() {

        return departmentService.selectAllDepartment();
    }


    @ApiOperation(value = "添加部门",notes = "添加部门")
    @PostMapping("/")
    public CommonResult addDept(@RequestBody Department department){
        departmentService.addDept(department);
        if (department.getResult() == 1) {
            return CommonResult.success(department,"添加成功！");
        }
        return CommonResult.error("添加失败！");
    }

    @ApiOperation(value = "删除部门",notes = "删除部门")
    @DeleteMapping("/{departmentId}")
    public CommonResult deleteDept(@PathVariable Integer departmentId) {
        Department department = new Department();
        department.setId(departmentId);
        departmentService.deleteDept(department);
        if (department.getResult() == -2) {
            return CommonResult.error("该部门下有子部门，删除失败！");
        } else if (department.getResult() == -1) {
            return CommonResult.error("该部门下有员工，删除失败！");
        }else if(department.getResult() ==1){
            return CommonResult.success(null, "删除成功！");
        }else{
            return CommonResult.error("删除失败！");
        }
    }
}
