package com.ling.vhr.modules.system.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.model.Department;
import com.ling.vhr.modules.system.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 部门管理
 * @author zhangling 2021/4/22 17:09
 */
@RestController
@RequestMapping("/system/basic/department")
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    @GetMapping("/")
    public List<Department> selectAllDepartment() {

        return departmentService.selectAllDepartment();
    }

    /**
     * 添加部门
     * @param department
     * @return
     */
    @PostMapping("/")
    public CommonResult addDept(@RequestBody Department department){
        departmentService.addDept(department);
        if (department.getResult() == 1) {
            return CommonResult.success(department,"添加成功！");
        }
        return CommonResult.error("添加失败！");
    }

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
