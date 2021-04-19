package com.ling.vhr;

import com.ling.vhr.mapper.HrMapper;
import com.ling.vhr.modules.system.model.Hr;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class VhrApplicationTests {

    @Autowired
    HrMapper hrMapper;

    @Test
    void contextLoads() {
        Hr hr = hrMapper.select(3);
        System.out.println("hr = " + hr);

    }

}
