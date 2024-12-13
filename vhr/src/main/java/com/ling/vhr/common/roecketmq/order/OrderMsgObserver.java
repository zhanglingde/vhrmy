package com.ling.vhr.common.roecketmq.order;


import com.ling.vhr.common.roecketmq.subscribe.Observer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * 全局顺序消息 demo
 *
 * @author zhangling
 * @date 2022/7/4 9:03 PM
 */
@Slf4j
@Component
public class OrderMsgObserver implements Observer {

    @Override
    public void subscribe(String topic, String tag, String key, String shardingKey, String messageId, String body) {
        log.info("顺序消息，订阅者:[{}], topic:[{}], tag:[{}], key:[{}], messageId:[{}], shardingKey:[{}], body:[{}]", topic, tag, key, messageId, shardingKey, body);
    }

}
