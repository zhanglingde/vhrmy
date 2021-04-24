package com.ling.vhr.modules.emp.controller;

import com.ling.vhr.common.utils.CommonParams;
import com.ling.vhr.common.utils.PageUtils;
import com.ling.vhr.modules.emp.model.Employee;
import com.ling.vhr.modules.emp.service.EmployeeService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;

/**
 * 员工基本信息表(Employee)表控制层
 *
 * @author zhangling 2021-04-24 11:05:27
 */
@RestController
@RequestMapping("/emp/basic")
@Api(tags = "员工基本信息")
public class EmployeeBasicController {

    @Autowired
    EmployeeService employeeService;

    @GetMapping("/")
    public PageUtils<Employee> getEmployeeByPage(CommonParams params) {
        return employeeService.getEmployeeByPage(params);
    }
    
}