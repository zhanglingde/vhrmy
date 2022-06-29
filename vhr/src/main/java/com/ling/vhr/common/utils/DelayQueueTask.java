package com.ling.vhr.common.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import lombok.ToString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;

import java.util.Iterator;
import java.util.Set;

/**
 * @author zhangling
 * @date 2021/11/10 4:09 下午
 */
@Component
public class DelayQueueTask {

    @Autowired
    RedisUtils redisUtils;

    @Autowired
    RedisTemplate redisTemplate;

    

    private static String DELAY_QUEUE = "DELAY_QUEUE";

    public void queue(Object data) {
        Message message = new Message();
        message.setId("1");
        message.setData(data);
        try {
            String json = new ObjectMapper().writeValueAsString(message);
            Jedis jedis = JedisPoolUtil.getJedis();
            jedis.zadd(DELAY_QUEUE, System.currentTimeMillis() + 5000, json);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

//        redisUtils.zadd(DELAY_QUEUE, json, (double) (System.currentTimeMillis() + 5000));

    }

    public void loop() {
        Jedis jedis = JedisPoolUtil.getJedis();
        while (!Thread.interrupted()) {
//            Set<String> set = redisTemplate.opsForZSet().rangeByScore(DELAY_QUEUE, 0, System.currentTimeMillis(), 0, 1);
            Set<String> set = jedis.zrangeByScore(DELAY_QUEUE, 0, System.currentTimeMillis(), 0, 1);
            if (set.isEmpty()) {
                // 消息为空，暂停 500ms 继续
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    break;
                }
                continue;
            }
            // 如果读取到了消息，则直接读取消息出来
            Iterator<String> iterator = set.iterator();
            String next = iterator.next();

//            if (redisTemplate.opsForZSet().rank(DELAY_QUEUE, next) > 0) {
            if (jedis.zrem(DELAY_QUEUE,next) > 0) {
                try {
                    Message message = new ObjectMapper().readValue(next, Message.class);
                    System.out.println("message = " + message);
                } catch (JsonProcessingException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Data
    @ToString
    class Message {
        private String id;
        private Object data;
    }
}
