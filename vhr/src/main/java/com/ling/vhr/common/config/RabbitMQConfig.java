package com.ling.vhr.common.config;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * RabbitMq消息队列配置
 * @author zhangling 2021/4/27 11:17
 */
@Configuration
public class RabbitMQConfig {

    /**
     * 入职欢迎邮件队列
     * @return
     */
    @Bean
    Queue directQueue() {
        return new Queue("ling-mail-queue");
    }

    @Bean
    DirectExchange directExchange() {
        return new DirectExchange("ling-direct-exchange", true, false);
    }

    /**
     * 绑定
     * 将队列 和 交换器绑定在一起
     * @return
     */
    @Bean
    Binding directBinding() {
        return BindingBuilder.bind(directQueue()).to(directExchange()).with("direct");
    }
}
