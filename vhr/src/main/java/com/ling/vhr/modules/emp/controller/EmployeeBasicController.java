package com.ling.vhr.modules.emp.controller;

import com.ling.vhr.common.utils.CommonParams;
import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.common.utils.POIUtils;
import com.ling.vhr.common.utils.PageUtils;
import com.ling.vhr.modules.emp.model.Employee;
import com.ling.vhr.modules.emp.model.Nation;
import com.ling.vhr.modules.emp.model.PoliticsStatus;
import com.ling.vhr.modules.emp.service.EmployeeService;
import com.ling.vhr.modules.emp.service.NationService;
import com.ling.vhr.modules.emp.service.PoliticsStatusService;
import com.ling.vhr.modules.system.basic.domain.Department;
import com.ling.vhr.modules.system.basic.model.JobLevel;
import com.ling.vhr.modules.system.basic.model.Position;
import com.ling.vhr.modules.system.basic.service.DepartmentService;
import com.ling.vhr.modules.system.basic.service.JobLevelService;
import com.ling.vhr.modules.system.basic.service.PositionService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

/**
 * 员工基本信息表(Employee)表控制层
 *
 * @author zhangling 2021-04-24 11:05:27
 */
@RestController
@RequestMapping("/employee/basic")
@Api(tags = "员工基本信息")
public class EmployeeBasicController {

    @Autowired
    EmployeeService employeeService;

    @Autowired
    NationService nationService;

    @Autowired
    PoliticsStatusService politicsStatusService;

    @Autowired
    JobLevelService jobLevelService;

    @Autowired
    PositionService positionService;

    @Autowired
    DepartmentService departmentService;

    @ApiOperation(value = "获取员工基本信息")
    @GetMapping(name = "获取员工基本信息", value = "/")
    public PageUtils<Employee> getEmployeeByPage(Employee employee, CommonParams params) {
        return employeeService.getEmployeeByPage(employee, params);
    }

    @ApiOperation(value = "添加员工")
    @PostMapping(name = "添加员工", value = "/")
    public CommonResult addEmployee(@RequestBody Employee employee) {
        if (employeeService.addEmployee(employee) == 1) {
            return CommonResult.success(null, "添加成功!");
        }
        return CommonResult.error("添加失败!");
    }

    @ApiOperation(value = "获取所有民族")
    @GetMapping(name = "获取所有民族", value = "/nations")
    public List<Nation> getAllNations() {
        return nationService.getAllNations();
    }

    @ApiOperation(value = "获取所有政治面貌")
    @GetMapping(name = "获取所有政治面貌", value = "/politicsstatus")
    public List<PoliticsStatus> getAllPoliticsStatus() {
        return politicsStatusService.getAllPoliticsStatus();
    }

    @ApiOperation(value = "获取所有职称")
    @GetMapping(name = "获取所有职称", value = "/joblevels")
    public List<JobLevel> getAllJobLevels() {
        return jobLevelService.list();
    }

    @ApiOperation(value = "获取所有职位")
    @GetMapping(name = "获取所有职位", value = "/positions")
    public List<Position> getAllPositions() {
        return positionService.list();
    }

    @ApiOperation(value = "获取最大工号")
    @GetMapping(name = "获取最大工号", value = "/maxWorkId")
    public CommonResult<String> maxWorkId() {
        Integer maxWorkId = employeeService.maxWorkId();
        // 格式化成8位
        String format = String.format("%08d", maxWorkId + 1);
        return CommonResult.success(format);
    }

    @ApiOperation(value = "获取所有部门")
    @GetMapping(name = "获取所有部门", value = "/departments")
    public List<Department> getAllDepartments() {
        return departmentService.selectAllDepartment();
    }

    @ApiOperation(value = "删除员工")
    @DeleteMapping(name = "删除员工", value = "/{employeeId}")
    public CommonResult deleteEmployee(@PathVariable("employeeId") Integer employeeId) {
        if (employeeService.deleteEmployee(employeeId) == 1) {
            return CommonResult.success(null, "删除成功！");
        }
        return CommonResult.error("删除失败！");
    }


    @PutMapping(name = "更新员工", value = "/")
    public CommonResult updateEmployee(@RequestBody Employee employee) {
        if (employeeService.updateEmployee(employee) == 1) {
            return CommonResult.success(null, "更新成功！");
        }
        return CommonResult.error("更新失败！");
    }

    @ApiOperation(value = "导出数据")
    @GetMapping(name = "导出数据", value = "/export")
    public ResponseEntity<byte[]> exportData() {
        return employeeService.exportData();
    }


    @PostMapping(name = "导入数据", value = "/import")
    @ApiOperation(value = "导入数据")
    public CommonResult importData(MultipartFile file) throws IOException {
        List<Employee> list = POIUtils.excel2Employee(file, nationService.getAllNations(), politicsStatusService.getAllPoliticsStatus(), jobLevelService.list(), positionService.list(), departmentService.getAllDeptWithOutChildren());
        employeeService.batchAddEmployee(list);
        return CommonResult.success();
    }

}