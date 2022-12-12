package com.ling.vhr.controller;

import com.ling.vhr.common.roecketmq.MqUtils;
import com.ling.vhr.model.Msg;
import com.ling.vhr.modules.emp.model.Employee;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author zhangling
 * @date 2022/8/25 9:41 AM
 */
@RestController
@RequestMapping("/rocketmq")
public class RocketMQController {

    @PostMapping("/normal")
    public boolean normal(@RequestBody Msg msg) {
        boolean normal = MqUtils.normal(msg.getTopic(), msg.getKey(), msg.getBody(), msg.getTag());
        return normal;
    }

    @PostMapping("/test")
    public void test(@RequestBody List<Employee> list) {
        System.out.println("list = " + list);
    }


}
