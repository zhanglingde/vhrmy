package com.ling.vhr.common.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class BInterceptor implements HandlerInterceptor {

    /**
     * 第一个执行，在请求执行之前被调用
     * 前置初始化操作，或是对请求进行预处理
     * @param request
     * @param response
     * @param handler
     * @return 返回false请求将不再继续往下
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("preHandle  B...");
        return true;
    }

    /**
     * Controller执行之后被调用
     * 可以对modelAndView返回视图进行处理
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("postHandle");
    }

    /**
     * preHandle()返回true，该方法才会执行；整个请求结束后该方法才会执行，做一些清理工作
     * @param request
     * @param response
     * @param handler
     * @param ex
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("afterCompletion");
    }
}