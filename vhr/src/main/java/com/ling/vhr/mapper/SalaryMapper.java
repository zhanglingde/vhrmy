package com.ling.vhr.mapper;

import com.ling.vhr.modules.salary.model.Salary;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import org.springframework.stereotype.Repository;

/**
 * (Salary)Mapper持久层
 *
 * @author zhangling 2021-04-27 16:05:22
 */
@Repository
public interface SalaryMapper {


    /**
     * 获取所有工资账套
     * @return
     */
    List<Salary> getAllSalaries();


    /**
     * 删除工资账套
     * @param id
     * @return
     */
    Integer deleteByPrimaryKey(Integer id);

    /**
     * 添加工资账套
     * @param salary
     * @return
     */
    Integer addSalary(Salary salary);

    /**
     * 编辑工资账套
     * @param salary
     * @return
     */
    Integer updateByPrimaryKey(Salary salary);
}