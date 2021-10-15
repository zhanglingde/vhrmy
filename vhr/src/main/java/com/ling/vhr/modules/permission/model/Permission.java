package com.ling.vhr.modules.permission.model;

import lombok.Data;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * (Permission)实体类
 *
 * @author zhangling
 * @since 2021-10-08 14:49:46
 */
@Data
@ToString
@Accessors(chain = true)
public class Permission implements Serializable {
    private static final long serialVersionUID = -97840133379807231L;
    
    private Integer id;
    /**
     * 权限编码
     */
    private String code;
    /**
     * 接口路径
     */
    private String url;
    /**
     * 请求对应 http 方法
     */
    private String method;
    /**
     * 权限描述
     */
    private String description;
    /**
     * 权限对应的方法名
     */
    private String action;
}

