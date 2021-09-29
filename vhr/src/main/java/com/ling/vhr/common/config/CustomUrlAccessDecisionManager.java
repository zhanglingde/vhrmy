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
 * @author zhangling  2021/4/18 17:30
 */
@Component
public class CustomUrlAccessDecisionManager implements AccessDecisionManager {

    /**
     *
     * @param authentication    保存当前登录用户信息对象
     * @param o                FilterInvocation对象
     * @param collection        CustomFilter返回值，可以获取请求url需要哪些角色可以访问
     * @throws AccessDeniedException
     * @throws InsufficientAuthenticationException
     */
    @Override
    public void decide(Authentication authentication, Object o, Collection<ConfigAttribute> collection) throws AccessDeniedException, InsufficientAuthenticationException {
        for (ConfigAttribute attribute : collection) {
            if ("ROLE_LOGIN".equals(attribute.getAttribute())) {
                if (authentication instanceof AnonymousAuthenticationToken) {
                    throw new AccessDeniedException("非法请求！");
                } else {
                    // 登录成功直接返回
                    return;
                }
            }
            // 当前用户所拥有的角色集合
            Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
            for (GrantedAuthority authority : authorities) {
                if (authority.getAuthority().equals(attribute.getAttribute())) {
                    // 当前用户拥有的角色与请求url需要的角色匹配 直接返回
                    return;
                }
            }
        }
        throw new AccessDeniedException("非法请求！");
    }

    @Override
    public boolean supports(ConfigAttribute configAttribute) {
        return true;
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }
}
