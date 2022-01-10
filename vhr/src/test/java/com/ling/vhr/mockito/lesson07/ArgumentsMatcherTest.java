package com.ling.vhr.mockito.lesson07;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.nullValue;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

/**
 * @author zhangling
 * @date 2022/1/10 3:07 下午
 */
@RunWith(MockitoJUnitRunner.class)
public class ArgumentsMatcherTest {

    @Test
    public void basicTest() {
        List<Integer> list = mock(ArrayList.class);

        when(list.get(eq(0))).thenReturn(100);
        assertThat(list.get(0), equalTo(100));
        assertThat(list.get(1), nullValue());
    }

    /**
     * isA, any
     */
    @Test
    public void testComplex() {
        Foo foo = mock(Foo.class);
        // Mockito.isA() 匹配 实例
        when(foo.function(Mockito.isA(Parent.class))).thenReturn(100);

        int result = foo.function(new Child1());
        assertThat(result, equalTo(100));

        result = foo.function(new Child2());
        assertThat(result, equalTo(100));

        // reset(foo);
        // Mockito.any  任何对象返回 true
        when(foo.function(Mockito.any(Child1.class))).thenReturn(100);
        result = foo.function(new Child2());
        assertThat(result, equalTo(100));
    }

    static class Foo {
        int function(Parent p) {
            return p.work();
        }
    }

    interface Parent {
        int work();
    }

    class Child1 implements Parent {

        @Override
        public int work() {
            throw new RuntimeException();
        }
    }

    class Child2 implements Parent {

        @Override
        public int work() {
            throw new RuntimeException();
        }
    }
}
