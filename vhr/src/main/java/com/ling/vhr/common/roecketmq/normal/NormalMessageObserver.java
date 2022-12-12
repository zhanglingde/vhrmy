package com.ling.vhr.common.roecketmq.normal;


import cn.hutool.core.util.StrUtil;
import com.ling.vhr.common.roecketmq.subscribe.Observer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * 普通消息的订阅 的demo
 *
 * @author zhangling
 * @date 2022/7/4 9:03 PM
 */
@Slf4j
@Component
public class NormalMessageObserver implements Observer {


    @Override
    public void subscribe(String topic, String tag, String key, String shardingKey, String messageId, String body) {
        log.info("消费消息：topic = {},key = {},body = {}", topic, key, body);
        // System.out.println("消费消息 body = " + body);
        if ("tag-invoice-create-finsh".equals(tag)) {
            return;
        }
        if (StrUtil.isEmpty(body)) {
            throw new RuntimeException("参数为空");
        }
        // User user = JSONUtil.toBean(body, User.class);
        // System.out.println("普通消息 demo = " + user);
    }

}
