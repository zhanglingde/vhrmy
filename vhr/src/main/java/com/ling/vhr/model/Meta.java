package com.ling.vhr.model;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author zhangling  2021/4/16 21:18
 */
@Data
public class Meta {

    private Integer keepAlive;

    @ApiModelProperty("是否需要登录")
    private Integer requireAuth;
}
