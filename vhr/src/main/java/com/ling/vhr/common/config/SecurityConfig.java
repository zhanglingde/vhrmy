package com.ling.vhr.common.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ling.vhr.common.utils.CommonResult;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.*;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationEntryPointFailureHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * @author zhangling 2021/4/16 10:57
 */
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .usernameParameter("username")
                .passwordParameter("password")
                .loginProcessingUrl("/doLogin")         // 登录接口
                .loginPage("/login")                    // 登录页面接口（未登录，通过该接口跳转到登录页面）
                .successHandler(new AuthenticationSuccessHandler() {
                    @Override
                    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                        response.setContentType("application/json;charset=UTF-8");
                        PrintWriter out = response.getWriter();
                        CommonResult result = new CommonResult();
                        result.setStatus(200);
                        result.setMsg("登录成功!");
                        result.setData(authentication.getPrincipal());

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
                        result.setData("登录失败!");
                        if (e instanceof LockedException) {
                            result.setMsg("账户被锁定，请联系管理员!");
                        } else if (e instanceof CredentialsExpiredException) {
                            result.setMsg("密码过期，请联系管理员!");
                        } else if (e instanceof AccountExpiredException) {
                            result.setMsg("账户过期，请联系管理员!");
                        } else if (e instanceof DisabledException) {
                            result.setMsg("账户被禁用，请联系管理员!");
                        } else if (e instanceof BadCredentialsException) {
                            result.setMsg("用户名或密码输入错误，请重新输入!");
                        } else {
                            result.setMsg("登录失败!");
                        }
                        out.write(new ObjectMapper().writeValueAsString(result)); // 登录成功返回一个json结果}
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
                        result.setMsg("注销登录成功！");

                        out.write(new ObjectMapper().writeValueAsString(result)); // 登录成功返回一个json结果
                        out.flush();
                        out.close();
                    }
                })
                .and()
                .csrf().disable();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.inMemoryAuthentication()
                .withUser("admin").password("$2a$10$jsxzMT/KojtobBNqD3Nc7u9TrbMYndqOtYkPx23LQpz5bRLkIwTCW").roles("admin")
                .and()
                .withUser("ling").password("$2a$10$jsxzMT/KojtobBNqD3Nc7u9TrbMYndqOtYkPx23LQpz5bRLkIwTCW").roles("user");


    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
