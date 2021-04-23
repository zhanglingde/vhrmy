package com.ling.vhr.modules.system.basic.model;

import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.*;


/**
 * 实体类
 *
 * @author zhangling 2021-04-22 17:13:59
 */
@Data
public class Department implements Serializable {

    private static final long serialVersionUID = 783302399950164104L;

    @ApiModelProperty("主键")
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

    List<Department> children = new ArrayList<>();

    private Integer result;

}