package com.ling.vhr.mockito.lesson08;

import java.io.Serializable;
import java.util.Collection;

/**
 * @author zhangling
 * @date 2022/1/10 4:03 下午
 */
public class SimpleService {

    public int method1(int i, String s, Collection<?> c, Serializable serializable) {
        throw new RuntimeException();
    }

    public void method2(int i, String s, Collection<?> c, Serializable serializable) {
        throw new RuntimeException();
    }
}
