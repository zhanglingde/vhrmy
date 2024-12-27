package com.ling.vhr.modules.system.basic.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ling.vhr.modules.system.basic.domain.Department;
import io.github.linpeilie.annotations.AutoMapper;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.beans.Transient;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


/**
 * 实体类
 *
 * @author zhangling 2021-04-22 17:13:59
 */
@Data
@TableName(value = "department")
@AutoMapper(target = Department.class)
public class DepartmentEntity implements Serializable {

    private static final long serialVersionUID = 783302399950164104L;

    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("部门名称")
    private String departmentName;

    @ApiModelProperty("上级部门id")
    private Integer parentId;

    @ApiModelProperty("部门层级路径")
    private String deptPath;

    @ApiModelProperty("启用状态")
    private Integer enabled;

    @ApiModelProperty("是否是最上级部门")
    private Integer isParent;

    @TableField(exist = false)
    private Integer result;

    public DepartmentEntity() {
    }

    public DepartmentEntity(String departmentName) {
        this.departmentName = departmentName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DepartmentEntity that = (DepartmentEntity) o;
        return Objects.equals(departmentName, that.departmentName);
    }

}