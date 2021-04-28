package com.ling.vhr.modules.salary.controller;

import com.ling.vhr.common.exception.RrException;
import com.ling.vhr.common.utils.CommonParams;
import com.ling.vhr.common.utils.PageUtils;
import com.ling.vhr.modules.emp.model.Employee;
import com.ling.vhr.modules.emp.service.EmployeeService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 员工账套设置
 *
 * @author zhangling 2021/4/28 16:50
 */
@RestController
@RequestMapping("/salary/sobcfg")
@Api(tags = "员工账套设置")
public class SobConfigController {

    @Autowired
    EmployeeService employeeService;

    @GetMapping("/")
    @ApiOperation(value = "获取员工账套列表")
    public PageUtils<List<Employee>> getEmployeesByPageWithSalary(CommonParams params) {

        return employeeService.getEmployeesByPageWithSalary(params);
    }
}
