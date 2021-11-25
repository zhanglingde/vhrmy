package com.ling.vhr.common.delay;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import redis.clients.jedis.Jedis;

import java.time.LocalTime;
import java.util.Set;
import java.util.UUID;

/**
 * @author zhangling
 * @date 2021/11/11 11:15 上午
 */
public class DelayMessageQueue {
    private Jedis jedis;
    private String queue;

    public DelayMessageQueue(Jedis jedis, String queue) {
        this.jedis = jedis;
        this.queue = queue;
    }

    /**
     * 消息入队
     *
     * @param data 要发送的消息
     */
    public void queue(Object data) {
        // 构造一个消息 Message
        Message message = new Message();
        message.setId(UUID.randomUUID().toString());
        message.setData(data);
        // 序列化
        try {
            String s = new ObjectMapper().writeValueAsString(message);
            System.out.println("msg publish:" + LocalTime.now());
            // 消息发送，score 延迟 5 秒
            jedis.zadd(queue, System.currentTimeMillis() + 5000, s);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
    }

    /**
     * 消费消息
     */
    public void loop() {
        // 只要线程没有被打断一直监听，线程被打断就不继续监听了
        while (!Thread.interrupted()) {
            // 读取 score 在 0 到当前时间戳之间的消息（每次只读一条消息）
            Set<String> zrange = jedis.zrangeByScore(queue, 0, System.currentTimeMillis(), 0, 1);
            if (zrange.isEmpty()) {
                // 如果消息是空的，则休息 500 毫秒然后继续
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    break;
                }
                continue;
            }
            // 如果读取到了消息，则直接读取消息出来
            String next = zrange.iterator().next();
            if (jedis.zrem(queue, next) > 0) {
                // 抢到了，接下来处理业务
                try {
                    Message message = new ObjectMapper().readValue(next, Message.class);
                    System.out.println("receive message = " + message);
                } catch (JsonProcessingException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
