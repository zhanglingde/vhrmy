package com.ling.vhr;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ling.vhr.mapper.HrMapper;
import com.ling.vhr.modules.emp.model.Employee;
import com.ling.vhr.service.TransactionService;
import org.junit.jupiter.api.Test;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

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

    @Test
    void test01() {

        // transactionService.test2();
        transactionService.test3();
    }

}
