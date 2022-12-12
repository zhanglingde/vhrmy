package com.ling.vhr.common.roecketmq.delay;


import cn.hutool.core.util.StrUtil;
import com.ling.vhr.common.roecketmq.config.MqConfig;
import com.ling.vhr.common.roecketmq.subscribe.Observer;
import org.springframework.stereotype.Component;

/**
 * 延迟顺序消息 demo
 *
 * @author zhangling
 * @date 2022/7/4 9:02 PM
 */
@Component
public class DelayMessageDemoObserver implements Observer {



    @Override
    public void subscribe(String topic, String tag, String key, String shardingKey, String messageId, String body) {
        // 处理具体业务
        System.out.println("body = " + body);
        if (!MqConfig.rocketMQ_TEST.equals(tag)) {
            return;
        }
        if (StrUtil.isEmpty(body)) {
            throw new RuntimeException("参数为空");
        }
    }

}
