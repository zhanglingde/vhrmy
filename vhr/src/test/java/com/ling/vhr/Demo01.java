package com.ling.vhr;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.temporal.ChronoField;
import java.util.ArrayList;
import java.util.List;

/**
 * @author zhangling 2021/7/5 15:18
 */
public class Demo01 {
    public static void main(String[] args) {
        BigDecimal a = new BigDecimal(1.444);
        System.out.println("a = " + a);
        // 第一个参数表示保留几位小数，第二个参数正数向上取整，负数向下取整（绝对值取大的）
        System.out.println(a.setScale(0, BigDecimal.ROUND_UP));
        // 正数向下取整，负数向上取整（绝对值取小的）
        System.out.println(a.setScale(0, BigDecimal.ROUND_DOWN));
    }

    @Test
    public void test1() {
        LocalDateTime now = LocalDateTime.now();
        System.out.println("now = " + now);
        System.out.println("now.getYear() = " + now.getYear());
        System.out.println("now.getMonthValue() = " + now.getMonthValue());
        System.out.println("now.getDayOfMonth() = " + now.getDayOfMonth());
        System.out.println("now.getHour() = " + now.getHour());
        System.out.println("now.getMinute() = " + now.getMinute());
        System.out.println("now.getSecond() = " + now.getSecond());
        System.out.println("now.getNano() = " + now.getNano());
        System.out.println("now.toString() = " + now.toString());
        System.out.println("now.getLong(ChronoField.NANO_OF_DAY) = " + now.getLong(ChronoField.NANO_OF_DAY));
    }
}
