package com.ling.vhr;

import com.ling.vhr.mapper.HrMapper;
import com.ling.vhr.modules.emp.model.Employee;
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

    @Test
    void contextLoads() {
        Employee employee = new Employee();
        employee.setName("员工名称");
        rabbitTemplate.convertAndSend("ling-direct-exchange","direct",employee);
    }

    @Test
    void test01() {

        System.out.println(-1L);
        System.out.println(Integer.MIN_VALUE);
        System.out.println();
    }

}
