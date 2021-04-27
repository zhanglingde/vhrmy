package com.ling.vhr.modules.salary.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

import lombok.*;


/**
 * 工资账套实体
 *
 * @author zhangling 2021-04-27 16:05:21
 */
@Data
@ApiModel("工资账套实体")
public class Salary implements Serializable {

    private static final long serialVersionUID = -82373906785219257L;

    @ApiModelProperty("主键id")
    private Integer id;

    @ApiModelProperty("账套名称")
    private String name;

    @ApiModelProperty("基本工资")
    private Integer basicSalary;

    @ApiModelProperty("奖金")
    private Integer bonus;

    @ApiModelProperty("午餐补助")
    private Integer lunchSalary;

    @ApiModelProperty("交通补助")
    private Integer trafficSalary;

    @ApiModelProperty("应发工资")
    private Integer allSalary;

    @ApiModelProperty("养老金基数")
    private Integer pensionBase;

    @ApiModelProperty("养老金比率")
    private Float pensionPer;

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "Asia/Shanghai")
    @ApiModelProperty("启用时间")
    private Date createDate;

    @ApiModelProperty("医疗基数")
    private Integer medicalBase;

    @ApiModelProperty("医疗保险比率")
    private Float medicalPer;

    @ApiModelProperty("公积金基数")
    private Integer accumulationFundBase;

    @ApiModelProperty("公积金比率")
    private Float accumulationFundPer;



}