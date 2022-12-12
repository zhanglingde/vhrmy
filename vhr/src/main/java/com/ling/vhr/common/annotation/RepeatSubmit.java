package com.ling.vhr.common.annotation;

import java.lang.annotation.*;

/**
 * Openapi 防止表单重复提交
 *
 * @author zhangling
 * @date 2022/8/29 9:41 AM
 */
@Inherited
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface RepeatSubmit {
    /**
     * 间隔时间(ms)，小于此时间视为重复提交
     */
    int interval() default 5000;

    /**
     * 提示消息
     */
    String message() default "不允许重复提交，请稍候再试";
}