package com.ling.vhr.modules.salary.service;

import com.ling.vhr.mapper.SalaryMapper;
import com.ling.vhr.modules.salary.model.Salary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * 
 *
 * @author zhangling 2021-04-27 16:05:23
 */
@Service
public class SalaryService {

    @Autowired
    SalaryMapper salaryMapper;

    /**
     * 获取所有工资账套
     * @return
     */
    public List<Salary> getAllSalaries() {
        return salaryMapper.getAllSalaries();
    }

    /**
     * 删除工资账套
     * @param id
     * @return
     */
    public Integer deleteSalary(Integer id) {
        return salaryMapper.deleteByPrimaryKey(id);
    }

    /**
     * 添加工资账套
     * @param salary
     * @return
     */
    public Integer addSalary(Salary salary) {
        salary.setCreateDate(new Date());
        return salaryMapper.addSalary(salary);
    }

    /**
     * 编辑工资账套
     * @param salary
     * @return
     */
    public Integer updateSalary(Salary salary) {
        return salaryMapper.updateByPrimaryKey(salary);
    }
}