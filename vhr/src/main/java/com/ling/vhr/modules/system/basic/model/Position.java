package com.ling.vhr.modules.system.basic.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

import lombok.*;


/**
 * 实体类
 *
 * @author zhangling 2021-04-19 17:36:41
 */
@Data
@ApiModel("职位管理表DTO")
public class Position implements Serializable {

    private static final long serialVersionUID = 295529981431357002L;

    private Integer id;

    @ApiModelProperty("职位")
    private String name;

    @ApiModelProperty("创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "Asia/Shanghai")
    private Date createDate;

    private Integer enabled;

}