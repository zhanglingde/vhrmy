package com.ling.vhr.common.utils;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * Jedis连接池工具类
 */
public class JedisPoolUtil {
    private static JedisPool pool;

    static {
        // 1. 连接池 基本配置信息
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        jedisPoolConfig.setMaxTotal(200);  // 最大连接数
        jedisPoolConfig.setMaxIdle(200);  // 最大空闲数

        // 2. 连接池
        String host = "121.37.185.192";
        int port = 6379;
        pool = new JedisPool(jedisPoolConfig, "121.37.185.192", 6379, 30000, "zhangling03");

    }

    public static Jedis getJedis(){
        Jedis jedis = pool.getResource();
        return jedis;
    }

    public static void close(Jedis jedis){
        jedis.close();
    }
}