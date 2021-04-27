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


    Integer deleteByPrimaryKey(Integer id);
}