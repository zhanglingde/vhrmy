package com.ling.vhr.mapper;

import com.ling.vhr.modules.emp.model.Employee;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import org.springframework.stereotype.Repository;

/**
 * 员工基本信息表(Employee)Mapper持久层
 *
 * @author zhangling 2021-04-24 11:05:30
 */
@Repository
public interface EmployeeMapper {


    /**
     * 分页查询员工信息
     * @param offset
     * @param limit
     * @return
     */
    List<Employee> selectEmployeeByPage(@Param("keyword") String keyword,
                                        @Param("offset") Integer offset,
                                        @Param("limit") Integer limit);

    /**
     * 查询员工总数
     * @return
     */
    Long getTotal(String keyword);

    /**
     * 添加员工
     * @param employee
     * @return
     */
    Integer insertSelective(Employee employee);

    /**
     * 获取最大工号
     * @return
     */
    Integer maxWorkId();

    /**
     * 删除员工
     * @param employeeId
     * @return
     */
    Integer deleteByPrimaryKey(Integer employeeId);

    /**
     * 更新员工
     * @param employee
     * @return
     */
    Integer updateByPrimaryKeySelective(Employee employee);
}