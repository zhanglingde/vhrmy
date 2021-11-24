package com.ling.vhr.modules.permission.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
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
@TableName("permission")
public class PermissionDO implements Serializable {
    private static final long serialVersionUID = -97840133379807231L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 权限编码
     */
    @TableField(value = "code")
    private String code;
    /**
     * 接口路径
     */
    @TableField(value = "url")
    private String url;
    /**
     * 请求对应 http 方法
     */
    @TableField(value = "method")
    private String method;
    /**
     * 权限描述
     */
    @TableField(value = "description")
    private String description;
    /**
     * 权限对应的方法名
     */
    @TableField(value = "action")
    private String action;
}

