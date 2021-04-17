package com.ling.vhr.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.util.List;

import lombok.*;


/**
 * 实体类
 *
 * @author zhangling 2021-04-16 21:13:10
 */
@Data
@ApiModel("菜单")
public class Menu implements Serializable {

    private static final long serialVersionUID = 741090672716702985L;

    private Integer id;

    private String url;

    @ApiModelProperty("路径")
    private String path;

    @ApiModelProperty("组件名称")
    private String component;

    @ApiModelProperty("菜单名称")
    private String name;

    private String iconCls;

    private Integer parentId;

    @ApiModelProperty("启用标识")
    private Integer enabled;

    private Meta meta;

    /**
     * 子菜单
     */
    private List<Menu> children;

}