package com.ling.vhr.modules.emp.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

import lombok.*;


/**
 * 政治面貌
 *
 * @author zhangling 2021-04-24 12:43:57
 */
@Data
@ApiModel("政治面貌")
public class PoliticsStatus implements Serializable {

    private static final long serialVersionUID = 208977427950367882L;

    private Integer id;

    private String name;

}