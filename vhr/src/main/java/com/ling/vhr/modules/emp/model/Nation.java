package com.ling.vhr.modules.emp.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

import lombok.*;


/**
 * 民族
 *
 * @author zhangling 2021-04-24 12:42:34
 */
@Data
@ApiModel("民族实体")
public class Nation implements Serializable {

    private static final long serialVersionUID = 827325570394716029L;

    private Integer id;

    private String name;

}