package com.ling.vhr.modules.system.controller;

import com.ling.vhr.modules.system.model.Department;
import com.ling.vhr.modules.system.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
