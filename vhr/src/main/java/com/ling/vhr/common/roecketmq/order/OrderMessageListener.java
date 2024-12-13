package com.ling.vhr.common.roecketmq.order;

import cn.hutool.extra.spring.SpringUtil;
import com.aliyun.openservices.ons.api.Action;
import com.aliyun.openservices.ons.api.ConsumeContext;
import com.aliyun.openservices.ons.api.Message;
import com.aliyun.openservices.ons.api.MessageListener;
import com.ling.vhr.common.roecketmq.normal.NormalMessageObserver;
import com.ling.vhr.common.roecketmq.subscribe.MessageSubject;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.client.consumer.listener.ConsumeOrderlyContext;
import org.apache.rocketmq.client.consumer.listener.ConsumeOrderlyStatus;
import org.apache.rocketmq.client.consumer.listener.MessageListenerOrderly;
import org.apache.rocketmq.common.message.MessageExt;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 顺序消息的订阅
 *
 * @author zhangling
 * @date 2022/7/4 9:03 PM
 */
@Slf4j
@Component
public class OrderMessageListener implements MessageListener, MessageListenerOrderly {

    @Override
    public Action consume(Message message, ConsumeContext context) {
        try {
            MessageSubject messageSubject = new MessageSubject();
            messageSubject.addObserver(SpringUtil.getBean(OrderMsgObserver.class));
            messageSubject.publish(message.getTopic(), message.getTag(), message.getKey(), message.getShardingKey(), message.getMsgID(), new String(message.getBody()));
            return Action.CommitMessage;
        } catch (Exception e) {
            log.error("顺序消息的订阅消费异常", e);
            // 消费失败
            return Action.ReconsumeLater;
        }
    }


    @Override
    public ConsumeOrderlyStatus consumeMessage(List<MessageExt> msgs, ConsumeOrderlyContext context) {
        try {
            for (MessageExt message : msgs) {
                log.info("接收到消息：msgId = {},topic = {},key = {},body = {}", message.getMsgId(), message.getTopic(), message.getKeys(), message.getBody());
                MessageSubject messageSubject = new MessageSubject();
                messageSubject.addObserver(SpringUtil.getBean(OrderMsgObserver.class));
                messageSubject.publish(message.getTopic(), message.getTags(), message.getKeys(), message.getKeys(), message.getMsgId(), new String(message.getBody()));
                return ConsumeOrderlyStatus.SUCCESS;
            }
        } catch (Exception e) {
            log.error("顺序消息队列异常",e);
            return ConsumeOrderlyStatus.SUSPEND_CURRENT_QUEUE_A_MOMENT;
        }
        return ConsumeOrderlyStatus.SUCCESS;
    }

}