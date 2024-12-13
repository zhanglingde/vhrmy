package com.ling.vhr.common.roecketmq.config;

import com.ling.vhr.common.roecketmq.normal.NormalMessageListener;
import com.ling.vhr.common.roecketmq.order.OrderMessageListener;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.client.consumer.DefaultMQPushConsumer;
import org.apache.rocketmq.client.exception.MQClientException;
import org.apache.rocketmq.common.protocol.heartbeat.MessageModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Configuration
public class ApacheConsumerClient {
    @Autowired
    NormalMessageListener normalMessageListener;
    @Autowired
    private OrderMessageListener orderMessageListener;

    /**
     * 普通消息消费者
     *
     * @return
     */
    @Bean(initMethod = "start", destroyMethod = "shutdown")
    @ConditionalOnProperty(prefix = "mq", name = "type", havingValue = "apache")
    public DefaultMQPushConsumer defaultMQPushConsumer() {
        DefaultMQPushConsumer consumer = new DefaultMQPushConsumer();
        consumer.setConsumerGroup(MqConfig.groupId + "_normal");
        consumer.setNamesrvAddr(MqConfig.nameSrvAddr);
        consumer.setConsumeThreadMax(20);
        try {
            // consumer.subscribe("SRM_INVOICE-BUSINESS-local","*");
            consumer.subscribe("SyncTopic", "*");
            consumer.subscribe("AsyncTopic", "*");
            consumer.subscribe("OnewayTopic", "*");
            consumer.subscribe("AAA", "*");
            consumer.subscribe("normal", "*");
            consumer.subscribe("delay", "*");
            consumer.subscribe("order", "*");
            consumer.setMessageModel(MessageModel.CLUSTERING);
            consumer.setConsumeTimeout(1500);
            // 注册监听器
            consumer.registerMessageListener(normalMessageListener);
            // consumer.start();
        } catch (MQClientException e) {
            throw new RuntimeException(e);
        }
        return consumer;
    }

    /**
     * 顺序消息消费者
     *
     * @return
     */
    @Bean(initMethod = "start", destroyMethod = "shutdown")
    @ConditionalOnProperty(prefix = "mq", name = "type", havingValue = "apache")
    public DefaultMQPushConsumer orderMQPushConsumer() {
        DefaultMQPushConsumer consumer = new DefaultMQPushConsumer();
        consumer.setConsumerGroup(MqConfig.groupId + "_order");
        consumer.setNamesrvAddr(MqConfig.nameSrvAddr);
        consumer.setConsumeThreadMax(20);
        try {
            consumer.subscribe("test_user", "*");
            consumer.setMessageModel(MessageModel.CLUSTERING);
            consumer.setConsumeTimeout(1500);
            // 注册监听器
            consumer.registerMessageListener(orderMessageListener);
            // consumer.start();
        } catch (MQClientException e) {
            throw new RuntimeException(e);
        }
        return consumer;
    }


}
