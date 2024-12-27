package com.ling.vhr.modules.system.basic.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ling.vhr.common.utils.MapstructUtils;
import com.ling.vhr.common.utils.TreeUtil;
import com.ling.vhr.mapper.DepartmentMapper;
import com.ling.vhr.modules.system.basic.domain.Department;
import com.ling.vhr.modules.system.basic.domain.entity.DepartmentEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 
 *
 * @author zhangling 2021-04-22 17:14:00
 */
@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;


    /**
     * 查询所有部门
     * @return 返回树形结构的所有部门
     */
    public List<Department> selectAllDepartment() {
        // List<Department> treeList = departmentMapper.selectAllDepartment(-1);
        LambdaQueryWrapper<DepartmentEntity> queryWrapper = Wrappers.lambdaQuery(DepartmentEntity.class);
        List<DepartmentEntity> departmentEntities = departmentMapper.selectList(queryWrapper);
        List<Department> departments = MapstructUtils.convert(departmentEntities, Department.class);
        // 构建树
        List<Department> treeList = TreeUtil.makeTree(departments, dept -> dept.getParentId() == -1, (parent, child) -> parent.getId().equals(child.getParentId()), Department::setChildren);
        return treeList;
    }

    /**
     * 添加部门
     * @param department
     */
    public void addDept(Department department) {
        department.setEnabled(1);
        departmentMapper.addDept(department);
    }

    /**
     * 删除部门
     * @param department
     */
    public void deleteDept(Department department) {
        departmentMapper.deleteDept(department);
    }

    /**
     * 获取所有部门（非树形结构）
     * @return
     */
    public List<Department> getAllDeptWithOutChildren() {
        return departmentMapper.getAllDeptWithOutChildren();
    }
}