package com.ling.vhr.modules.system.basic.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

import lombok.*;


/**
 * @author zhangling 2021-04-20 16:35:40
 */
@Data
@ApiModel("职称实体")
public class JobLevel implements Serializable {

    private static final long serialVersionUID = -39686127438539789L;

    private Integer id;

    @ApiModelProperty("职称名称")
    private String name;

    @ApiModelProperty("职称级别")
    private String titleLevel;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Shanghai")
    private Date createDate;

    private Integer enabled;

}