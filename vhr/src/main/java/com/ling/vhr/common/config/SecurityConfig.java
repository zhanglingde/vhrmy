package com.ling.vhr.common.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.hr.model.Hr;
import com.ling.vhr.modules.system.hr.service.HrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.*;
import org.springframework.security.config.annotation.ObjectPostProcessor;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author zhangling 2021/4/16 10:57
 */
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    HrService hrService;

    @Autowired
    CustomFilterInvocationSecurityMetadataSource customFilter;

    @Autowired
    CustomUrlAccessDecisionManager customUrl;


    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(hrService);
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        // ???????????????????????????
        web.ignoring()
                .antMatchers("/redis/**")
                .antMatchers("/login")
                .antMatchers("/process/**")
                .antMatchers("/permission/**")
                .antMatchers("/v3/api-docs")
                .antMatchers("/css/**")
                .antMatchers("/js/**")
                .antMatchers("/img/**")
                .antMatchers("/fonts/**")
                .antMatchers("/index.html")
                .antMatchers("/favicon.ico")
                .antMatchers("/swagger-ui.html");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .withObjectPostProcessor(new ObjectPostProcessor<FilterSecurityInterceptor>() {
                    @Override
                    public <O extends FilterSecurityInterceptor> O postProcess(O o) {
                        o.setAccessDecisionManager(customUrl);
                        o.setSecurityMetadataSource(customFilter);
                        return o;
                    }
                })
                //.anyRequest().authenticated()
                .and()
                .formLogin()
                .usernameParameter("username")
                .passwordParameter("password")
                .loginProcessingUrl("/doLogin")         // ????????????
                .loginPage("/login")                    // ????????????????????????????????????????????????????????????????????????
                .successHandler(new AuthenticationSuccessHandler() {
                    @Override
                    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                        response.setContentType("application/json;charset=UTF-8");
                        PrintWriter out = response.getWriter();
                        CommonResult result = new CommonResult();
                        result.setStatus(200);
                        result.setMsg("????????????!");
                        Hr hr = (Hr) authentication.getPrincipal();
                        hr.setPassword(null);
                        result.setData(hr);

                        out.write(new ObjectMapper().writeValueAsString(result));
                        out.flush();
                        out.close();

                    }
                })
                .failureHandler(new AuthenticationFailureHandler() {
                    @Override
                    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException e) throws IOException, ServletException {
                        response.setContentType("application/json;charset=utf-8");
                        PrintWriter out = response.getWriter();

                        CommonResult result = new CommonResult();

                        result.setStatus(401);
                        result.setData("????????????!");
                        if (e instanceof LockedException) {
                            result.setMsg("????????????????????????????????????!");
                        } else if (e instanceof CredentialsExpiredException) {
                            result.setMsg("?????????????????????????????????!");
                        } else if (e instanceof AccountExpiredException) {
                            result.setMsg("?????????????????????????????????!");
                        } else if (e instanceof DisabledException) {
                            result.setMsg("????????????????????????????????????!");
                        } else if (e instanceof BadCredentialsException) {
                            result.setMsg("????????????????????????????????????????????????!");
                        } else {
                            result.setMsg("????????????!");
                        }
                        out.write(new ObjectMapper().writeValueAsString(result)); // ????????????????????????json??????}
                        out.flush();
                        out.close();
                    }
                })
                .permitAll()
                .and()
                .logout()
                .logoutUrl("/logout")
                .logoutSuccessHandler(new LogoutSuccessHandler() {
                    @Override
                    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                        response.setContentType("application/json;charset=utf-8");
                        PrintWriter out = response.getWriter();
                        CommonResult result = new CommonResult();
                        result.setStatus(200);
                        result.setMsg("?????????????????????");

                        out.write(new ObjectMapper().writeValueAsString(result)); // ????????????????????????json??????
                        out.flush();
                        out.close();
                    }
                })
                .and()
                // ??????????????????????????????????????????????????????????????????????????????????????????????????????
                .exceptionHandling().authenticationEntryPoint(new AuthenticationEntryPoint() {
                    /**
                     * ??????????????????
                     * @param e
                     * @throws IOException
                     * @throws ServletException
                     */
                    @Override
                    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException e) throws IOException, ServletException {
                        response.setContentType("application/json;charset=utf-8");
                        PrintWriter out = response.getWriter();
                        response.setStatus(401);

                        CommonResult result = new CommonResult();
                        result.setStatus(401);
                        result.setData("????????????!");
                        result.setMsg("????????????!");
                        if (e instanceof InsufficientAuthenticationException) {
                            result.setMsg("?????????????????????????????????!");
                        }
                        out.write(new ObjectMapper().writeValueAsString(result)); // ????????????????????????json??????}
                        out.flush();
                        out.close();
                    }
                })
                .and()
                .csrf().disable();
    }



    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
