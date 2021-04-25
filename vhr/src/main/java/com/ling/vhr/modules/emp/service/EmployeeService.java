package com.ling.vhr.modules.emp.service;

import com.ling.vhr.common.exception.RrException;
import com.ling.vhr.common.utils.CommonParams;
import com.ling.vhr.common.utils.PageUtils;
import com.ling.vhr.mapper.EmployeeMapper;
import com.ling.vhr.modules.emp.model.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 员工基本信息表(Employee)表服务实现类
 *
 * @author zhangling 2021-04-24 11:05:31
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;


    /**
     * 分页查询员工基础信息
     *
     * @param params
     * @return
     */
    public PageUtils<Employee> getEmployeeByPage(String keyword,CommonParams params) {
        if (params.getPage() == null || params.getLimit() == null) {
            throw new RrException("分页参数不能为空！");
        }
        Integer page = (params.getPage() - 1) * params.getLimit();

        List<Employee> list = employeeMapper.selectEmployeeByPage(keyword,page, params.getLimit());
        Long total = employeeMapper.getTotal(keyword);
        PageUtils<Employee> pageUtils = new PageUtils<>(list, total, params.getLimit(), page);
        return pageUtils;
    }

    public Integer addEmployee(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }

    public Integer maxWorkId() {
        return employeeMapper.maxWorkId();
    }

    /**
     * 删除员工
     * @param employeeId
     * @return
     */
    public Integer deleteEmployee(Integer employeeId) {
        return employeeMapper.deleteByPrimaryKey(employeeId);
    }
}