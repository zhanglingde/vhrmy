package com.ling.vhr;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ling.vhr.common.utils.RedisUtils;
import com.ling.vhr.mapper.HrMapper;
import com.ling.vhr.modules.emp.model.Employee;
import com.ling.vhr.service.TransactionService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.runtime.ProcessInstance;
import org.junit.jupiter.api.Test;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@SpringBootTest
class VhrApplicationTests {

    @Autowired
    HrMapper hrMapper;

    @Autowired
    RabbitTemplate rabbitTemplate;

    @Autowired
    TransactionService transactionService;

    @Autowired
    RuntimeService runtimeService;

    @Test
    void contextLoads() {
        Employee employee = new Employee();
        employee.setName("员工名称");
        ObjectMapper om = new ObjectMapper();
        try {
            String json = om.writeValueAsString(employee);
            System.out.println("json = " + json);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

//        rabbitTemplate.convertAndSend("ling-direct-exchange","direct",employee);
    }

    /**
     * 事务
     */
    @Test
    void test01() {

        // transactionService.test2();
        transactionService.test3();
    }

    @Autowired
    RedisTemplate<String, Object> redisTemplate;
    @Autowired
    RedisUtils redisUtils;


    @Test
    public void demo3() {
        //从左边插入一个集合
        List<String> list = new ArrayList<String>();
        list.add("鬼泣5");
        list.add("荒野大镖客2");
        list.add("仙剑奇侠传7");
        redisTemplate.opsForList().leftPushAll("game:list", list);
        redisUtils.listSetArrayList("AA", list);
    }


}
