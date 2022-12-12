package com.ling.vhr.common.config;

import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author zhangling
 * @date 2022/12/9 11:42 AM
 */
// @Configuration
public class WebConfig implements WebMvcConfigurer {

    /**
     * 添加拦截器使拦截器生效
     * @param registry
     */
    // @Override
    // public void addInterceptors(InterceptorRegistry registry) {
    //     registry.addInterceptor(new MyInterceptor())
    //             .addPathPatterns("/**")                 // 拦截所有请求
    //             .excludePathPatterns("/hello")          // 过滤/hello不拦截
    //             .order(1);                              // 有很多拦截器时，拦截器的优先级
    // }
}
