package com.ling.vhr.modules.salary.controller;

import com.ling.vhr.common.exception.RrException;
import com.ling.vhr.common.utils.CommonParams;
import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.common.utils.PageUtils;
import com.ling.vhr.modules.emp.model.Employee;
import com.ling.vhr.modules.emp.service.EmployeeService;
import com.ling.vhr.modules.salary.model.Salary;
import com.ling.vhr.modules.salary.service.SalaryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @Autowired
    SalaryService salaryService;

    @GetMapping(name = "员工资质账套列表", value = "/")
    @ApiOperation(value = "获取员工账套列表")
    public PageUtils<List<Employee>> getEmployeesByPageWithSalary(CommonParams params) {

        return employeeService.getEmployeesByPageWithSalary(params);
    }

    @GetMapping(name = "查询所有工资账套", value = "/salaries")
    @ApiOperation(value = "查询所有工资账套")
    public List<Salary> getAllSalaries() {
        return salaryService.getAllSalaries();
    }

    @PutMapping(name = "更新员工账套", value = "/")
    public CommonResult updateEmployeeSalaryById(Integer employeeId, Integer salaryId) {
        Integer result = employeeService.updateEmployeeSalaryById(employeeId, salaryId);
        if (result == 1 || result == 2) {
            return CommonResult.success(null, "更新员工账套成功！");
        }
        return CommonResult.error("更新员工账套失败！");
    }
}
