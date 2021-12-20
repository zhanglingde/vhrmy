package com.ling.vhr.common.config;

import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;
//import sun.net.www.protocol.http.AuthenticationInfo;

import java.util.Collection;

/**
 * 决策管理器
 * @author zhangling  2021/4/18 17:30
 */
@Component
public class CustomUrlAccessDecisionManager implements AccessDecisionManager {

    /**
     * 核心决策方法，在这个方法中判断是否允许当前 URL 或者方法的调用，如果不允许，则会抛出 AccessDeniedException 异常
     *
     * @param authentication    保存当前登录用户信息对象
     * @param o                FilterInvocation 对象，可获得请求相关信息
     * @param collection        CustomFilter 返回值，角色列表，请求 url 可被返回角色列表中的角色访问
     * @throws AccessDeniedException
     * @throws InsufficientAuthenticationException
     */
    @Override
    public void decide(Authentication authentication, Object o, Collection<ConfigAttribute> collection) throws AccessDeniedException, InsufficientAuthenticationException {
        // 1. 遍历可访问请求 url 的角色列表
        for (ConfigAttribute attribute : collection) {
            if ("ROLE_LOGIN".equals(attribute.getAttribute())) {
                if (authentication instanceof AnonymousAuthenticationToken) {
                    throw new AccessDeniedException("非法请求！");
                } else {
                    // 登录成功直接返回
                    return;
                }
            }
            // 2. 当前用户所拥有的角色集合
            Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
            for (GrantedAuthority authority : authorities) {
                // 3. 当前用户拥有的角色可访问请求 url
                if (authority.getAuthority().equals(attribute.getAttribute())) {
                    // 当前用户拥有的角色与请求url需要的角色匹配 直接返回
                    return;
                }
            }
        }
        throw new AccessDeniedException("非法请求！");
    }

    /**
     * 判断是否支持处理 ConfigAttribute 对象
     * @param configAttribute
     * @return
     */
    @Override
    public boolean supports(ConfigAttribute configAttribute) {
        return true;
    }

    /**
     * 判断是否支持当前安全对象
     * @param aClass
     * @return
     */
    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }
}
