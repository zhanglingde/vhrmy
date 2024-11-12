package com.ling.vhr;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ReflectUtil;
import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ConcurrentMap;

/**
 * @author zhangling 2021/7/5 15:18
 */
public class Demo01 {
    public static void main(String[] args) {
        // List<Amount> targetList = new ArrayList<>();
        // targetList.add(new Amount("2", "张三"));
        // targetList.add(new Amount("4", "李四"));
        // targetList.add(new Amount("1", "王无"));
        // targetList.add(new Amount("10", "李四"));
        // targetList.add(new Amount("10", "李四2"));
        // targetList.add(new Amount("10", "王无"));
        //
        // ConcurrentMap<String, List<Amount>> collect = targetList.stream().collect(Collectors.groupingByConcurrent(c -> getGroupKey(c, Arrays.asList("name"))));
        // System.out.println("collect = " + collect);

        DateTime startDate = DateUtil.beginOfMonth(new Date());
        DateTime endDate = DateUtil.endOfMonth(new Date());

        String s = startDate.toString();
        String s1 = endDate.toString();

        System.out.println("startDate = " + startDate);
        System.out.println("endDate = " + endDate);
    }

    private static String getGroupKey(Amount c, List<String> list) {
        StringBuilder key = new StringBuilder();
        for (String s : list) {
            Object val = ReflectUtil.getFieldValue(c, s);

            if (StringUtils.isBlank(val.toString())) {
                val = ReflectUtil.getFieldValue(c, s);
            }
            key.append(val);
        }

        return key.toString();
    }

    @Test
    public void test1() {
    }
}
