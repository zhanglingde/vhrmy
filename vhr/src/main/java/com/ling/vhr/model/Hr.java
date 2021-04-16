package com.ling.vhr.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

import lombok.*;


/**
 * 实体类
 *
 * @author zhangling 2021-04-16 09:58:45
 */
@Data
@ApiModel("DTO")
public class Hr implements Serializable {

    private static final long serialVersionUID = -44149478272289128L;


    @ApiModelProperty("hrID")
    private Integer id;

    @ApiModelProperty("姓名")
    private String name;

    @ApiModelProperty("手机号码")
    private String phone;

    @ApiModelProperty("住宅电话")
    private String telephone;

    @ApiModelProperty("联系地址")
    private String address;

    private Integer enabled;

    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("密码")
    private String password;

    private String userface;

    private String remark;

}