package com.ling.vhr.mapper;

import com.ling.vhr.modules.system.model.Department;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import org.springframework.stereotype.Repository;

/**
 * (Department)Mapper持久层
 *
 * @author zhangling 2021-04-22 17:13:59
 */
@Repository
public interface DepartmentMapper {


    /**
     * 递归查询所有部门
     * @param parentId
     * @return
     */
    List<Department> selectAllDepartment(Integer parentId);

    /**
     * 使用存储过程添加部门
     * @param department
     */
    void addDept(Department department);

    /**
     * 使用存储过程删除部门
     * @param department
     */
    void deleteDept(Department department);
}