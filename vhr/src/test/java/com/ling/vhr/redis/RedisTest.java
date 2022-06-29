package com.ling.vhr.redis;

import com.ling.vhr.common.utils.RedisUtils;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * @author zhangling
 * @date 2022/6/27 3:47 PM
 */
@Slf4j
@SpringBootTest
public class RedisTest {

    @Autowired
    RedisUtils redisUtil;

    @Test
    public void redisTest(){

        for (int i = 0; i < 10; i++) {
            System.out.println(redisUtil.isAllowed("ling", "send", 60, 2));
            if (i % 5 == 0) {
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
