package com.ling.vhr.common.roecketmq.normal;

import cn.hutool.extra.spring.SpringUtil;
import com.aliyun.openservices.ons.api.Action;
import com.aliyun.openservices.ons.api.ConsumeContext;
import com.aliyun.openservices.ons.api.Message;
import com.aliyun.openservices.ons.api.MessageListener;
import com.ling.vhr.common.roecketmq.subscribe.MessageSubject;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.client.consumer.listener.ConsumeConcurrentlyContext;
import org.apache.rocketmq.client.consumer.listener.ConsumeConcurrentlyStatus;
import org.apache.rocketmq.client.consumer.listener.MessageListenerConcurrently;
import org.apache.rocketmq.common.message.MessageExt;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 普通消息
 *
 * @author zhangling
 * @date 2022/7/4 9:03 PM
 */
@Slf4j
@Component
public class NormalMessageListener implements MessageListener, MessageListenerConcurrently {


    @Override
    public Action consume(Message message, ConsumeContext context) {
        try {
            log.info("接收到消息：msgId = {},topic = {},key = {},body = {}", message.getMsgID(), message.getTopic(), message.getKey(), message.getBody());
            MessageSubject messageSubject = new MessageSubject();
            messageSubject.addObserver(SpringUtil.getBean(NormalMessageObserver.class));
            messageSubject.publish(message.getTopic(), message.getTag(), message.getKey(), message.getShardingKey(), message.getMsgID(), new String(message.getBody()));
            return Action.CommitMessage;
        } catch (Exception e) {
            // 消费失败
            log.error("普通消息队列异常", e);
            return Action.ReconsumeLater;
        }
    }

    @Override
    public ConsumeConcurrentlyStatus consumeMessage(List<MessageExt> msgs, ConsumeConcurrentlyContext consumeConcurrentlyContext) {
        // System.out.println("线程：" + Thread.currentThread().getName() + "，消息：" + msgs);
        // for (MessageExt msg : msgs) {
        //     log.info("topic：{},tag：{},key：{},body:{}", msg.getTopic(), msg.getTags(), msg.getKeys(), new String(msg.getBody()));
        // }
        try {
            for (MessageExt message : msgs) {
                log.info("接收到消息：msgId = {},topic = {},key = {},body = {}", message.getMsgId(), message.getTopic(), message.getKeys(), message.getBody());
                MessageSubject messageSubject = new MessageSubject();
                messageSubject.addObserver(SpringUtil.getBean(NormalMessageObserver.class));
                messageSubject.publish(message.getTopic(), message.getTags(), message.getKeys(), message.getKeys(), message.getMsgId(), new String(message.getBody()));
                return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
            }
        } catch (Exception e) {
            // 消费失败
            log.error("普通消息队列异常", e);
            return ConsumeConcurrentlyStatus.RECONSUME_LATER;
        }
        return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
    }
}
