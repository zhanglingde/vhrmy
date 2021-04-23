package com.ling.vhr.common.utils;

import com.ling.vhr.modules.system.basic.model.Hr;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * @author zhangling 2021/4/23 16:53
 */
public class HrUtils {

    /**
     * 获得当前登录用户
     * @return
     */
    public static Hr getCurrentHr() {
        return ((Hr) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
    }
}
