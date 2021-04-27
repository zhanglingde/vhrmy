package com.ling.mail.config;

import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


/**
 * @author zhangling 2021/4/27 11:10
 */
@Configuration
public class RabbitMqConfig {

    /**
     * 注入一个Direct队列：点对点通信
     * @return
     */
    @Bean
    Queue directQueue() {
        return new Queue("ling-mail-queue");
    }
}
