package com.ling.vhr.modules.system.basic.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

import lombok.*;


/**
 * 实体类
 *
 * @author zhangling 2021-04-16 13:14:49
 */
@Data
@ApiModel("DTO")
public class Role implements Serializable {

    private static final long serialVersionUID = 363192162325801768L;

    private Integer id;

    private String name;

    @ApiModelProperty("角色名称")
    private String nameZh;

}