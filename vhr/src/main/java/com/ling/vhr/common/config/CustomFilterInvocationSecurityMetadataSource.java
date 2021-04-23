package com.ling.vhr.common.config;

import com.ling.vhr.modules.system.basic.model.Menu;
import com.ling.vhr.modules.system.basic.model.Role;
import com.ling.vhr.modules.system.basic.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;

import java.util.Collection;
import java.util.List;

/**
 * 处理请求，分析请求地址是否是数据库中配置的地址，
 * 根据请求url判断哪些角色可访问
 * @author zhangling  2021/4/18 16:34
 */
@Component
public class CustomFilterInvocationSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {

    AntPathMatcher pathMatcher = new AntPathMatcher();

    @Autowired
    MenuService menuService;

    /**
     * 根据请求url查询该url哪些角色可以访问
     * @param o  FilterInvocation对象
     * @return
     * @throws IllegalArgumentException
     */
    @Override
    public Collection<ConfigAttribute> getAttributes(Object o) throws IllegalArgumentException {
        String requestUrl = ((FilterInvocation) o).getRequestUrl();
        List<Menu> menus = menuService.selectAllMenus();
        for (Menu menu : menus) {
            if (pathMatcher.match(menu.getUrl(), requestUrl)) {
                // 请求url与数据库中url匹配成功
                List<Role> roles = menu.getRoles();
                String[] rolesStr = new String[roles.size()];
                for (int i = 0; i < roles.size(); i++) {
                    rolesStr[i] = roles.get(i).getName();
                }
                return SecurityConfig.createList(rolesStr);
            }
        }
        // 数据库中路径都为匹配成功，设置登录即可访问
        return SecurityConfig.createList("ROLE_LOGIN");
    }

    @Override
    public Collection<ConfigAttribute> getAllConfigAttributes() {
        return null;
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }
}
