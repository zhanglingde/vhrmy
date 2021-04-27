package com.ling.vhr.modules.salary.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.salary.model.Salary;
import com.ling.vhr.modules.salary.service.SalaryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * (Salary)表控制层
 *
 * @author zhangling 2021-04-27 16:05:19
 */
@RestController
@RequestMapping("/salary/sob")
@Api(tags = "工资账套")
public class SalaryController {

    @Autowired
    SalaryService salaryService;

    @GetMapping("/")
    @ApiOperation(value = "工资账套列表")
    public List<Salary> getAllSalaries() {
        return salaryService.getAllSalaries();
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "删除工资账套")
    public CommonResult deleteSalary(@PathVariable Integer id) {
        if (salaryService.deleteSalary(id) == 1) {
            return CommonResult.success(null,"删除工资账套成功！");
        }
        return CommonResult.error("删除工资账套失败！");
    }
}