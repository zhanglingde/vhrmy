package com.ling.vhr.controller;

import com.ling.vhr.common.utils.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author zhangling
 * @date 2022/6/27 4:14 PM
 */
@RestController
@RequestMapping("/redis")
public class RedisController {
    @Autowired
    RedisUtils redisUtil;


    @GetMapping("/test")
    public void rateLimiter(){
        for (int i = 0; i < 10; i++) {
            // System.out.println(redisUtil.isAllowed("ling", "send", 60, 2));
            if (i % 5 == 0) {
                try {
                    Thread.sleep(1000);
                } catch (Exception e) {
                    // e.printStackTrace();
                    throw new NullPointerException("空指针异常");
                }
            }
        }
    }
}
