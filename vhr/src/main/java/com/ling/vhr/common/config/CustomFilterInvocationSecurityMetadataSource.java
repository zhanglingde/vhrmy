package com.ling.vhr.common.config;

import com.ling.vhr.modules.system.basic.model.Menu;
import com.ling.vhr.modules.system.hr.model.Role;
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
 * <p>
 * 安全元数据源，提供受保护对象所需要的权限；例如用户访问一个 URL 地址，该 URL 地址需要哪些权限才能访问，由该类提供
 * 通票器在投票时需要两方面的权限：一是当前用户具备哪些权限；二是当前访问的 URL 或方法需要哪些权限才能访问；投票器是将两种权限进行比较
 * </p>
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
     * 根据请求 url 查询该 url 哪些角色可以访问
     *
     * @param o  FilterInvocation 对象,可获得请求相关信息
     * @throws IllegalArgumentException
     * @return 返回角色列表，请求 url 可被返回角色列表中的角色访问
     */
    @Override
    public Collection<ConfigAttribute> getAttributes(Object o) throws IllegalArgumentException {
        // 1. 获得请求 url
        String requestUrl = ((FilterInvocation) o).getRequestUrl();
        // 2. 获得所有 url
        List<Menu> menus = menuService.selectAllMenus();
        for (Menu menu : menus) {
            if (pathMatcher.match(menu.getUrl(), requestUrl)) {
                // 3. 请求url与数据库中url匹配成功
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

    /**
     * 返回所有的角色/权限，以便验证是否支持。可以返回 null
     * @return
     */
    @Override
    public Collection<ConfigAttribute> getAllConfigAttributes() {
        return null;
    }

    /**
     * 返回当前的 SecurityMetadataSource 是否支持受保护的对象如 FilterInvocation、MethodInvocation
     * @param aClass
     * @return
     */
    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }
}
