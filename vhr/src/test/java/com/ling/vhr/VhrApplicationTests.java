package com.ling.vhr;

import com.ling.vhr.mapper.HrMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@SpringBootTest
class VhrApplicationTests {

    @Autowired
    HrMapper hrMapper;

    @Test
    void contextLoads() {

    }

    @Test
    void test01() {
        String str = "  asdasda1231231423";
        String pattern = "^[A-Za-z0-9]+$";
        Pattern r = Pattern.compile(pattern);
        Matcher m = r.matcher(str);
        System.out.println(m.matches());
    }

}
