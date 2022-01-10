package com.ling.vhr.mockito.lesson08;

import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.mockito.Matchers.*;
import static org.mockito.Mockito.*;


/**
 * @author zhangling
 * @date 2022/1/10 4:02 下午
 */
@RunWith(MockitoJUnitRunner.class)
public class WildcardArgumentMatcherTest {

    @Mock
    private SimpleService simpleService;

    @Test
    public void wildcardMethod1() {
        when(simpleService.method1(anyInt(), anyString(), anyCollection(), isA(Serializable.class))).thenReturn(100);
        int result = simpleService.method1(1, "ling", Collections.emptyList(), "Mockito");
        assertThat(result, equalTo(100));
    }

    @Test
    public void wildcardMethod1WithSpec() {
        // eq() 方法匹配多个值
        when(simpleService.method1(anyInt(), eq("ling"), anyCollection(), isA(Serializable.class))).thenReturn(100);
        when(simpleService.method1(anyInt(), eq("zhang"), anyCollection(), isA(Serializable.class))).thenReturn(200);

        int result = simpleService.method1(1, "ling", Collections.emptyList(), "Mockito");
        assertThat(result, equalTo(100));

        result = simpleService.method1(1, "zhang", Collections.emptyList(), "Mockito");
        assertThat(result, equalTo(200));

        result = simpleService.method1(1, "dsdf", Collections.emptyList(), "Mockito");
        assertThat(result, equalTo(0));
    }

    /**
     * 方法返回值为 void 使用 verify 进行校验
     */
    @Test
    public void wildcardMethod2() {
        List<Object> emptyList = Collections.emptyList();
        doNothing().when(simpleService).method2(anyInt(), anyString(), anyCollection(), isA(Serializable.class));
        simpleService.method2(1, "ling", emptyList, "Mockito");
        // void 方法校验
        verify(simpleService, times(1)).method2(1, "ling", emptyList, "Mockito");
        // 通配方式校验
        verify(simpleService, times(1)).method2(anyInt(), eq("ling"), anyCollection(), isA(Serializable.class));
    }

    @After
    public void destroy() {
        reset(simpleService);
    }
}
