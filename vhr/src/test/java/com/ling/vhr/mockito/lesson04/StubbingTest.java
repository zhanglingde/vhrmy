package com.ling.vhr.mockito.lesson04;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.invocation.InvocationOnMock;
import org.mockito.runners.MockitoJUnitRunner;
import org.mockito.stubbing.Answer;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.junit.jupiter.api.Assertions.fail;
import static org.mockito.Mockito.*;

/**
 * @author zhangling
 * @date 2022/1/10 10:35 上午
 */
@RunWith(MockitoJUnitRunner.class)
public class StubbingTest {
    private List<String> list;

    @Before
    public void init() {
        this.list = mock(ArrayList.class);
    }

    @Test
    public void howToUseStubbing() {
        when(list.get(0)).thenReturn("first");
        assertThat(list.get(0), equalTo("first"));

        when(list.get(anyInt())).thenThrow(new RuntimeException());
        try {
            list.get(0);
            fail();
        } catch (Exception e) {
            assertThat(e, instanceOf(RuntimeException.class));
        }
    }

    /**
     * void 方法返回值
     */
    @Test
    public void howToStubbingVoidMethod() {
        doNothing().when(list).clear();
        list.clear();
        verify(list, times(1)).clear();

        doThrow(RuntimeException.class).when(list).clear();

        try {
            list.clear();
            fail();
        } catch (Exception e) {
            assertThat(e, instanceOf(RuntimeException.class));
        }

    }

    @Test
    public void stubbingDoReturn() {
        when(list.get(0)).thenReturn("first");
        doReturn("second").when(list).get(1);

        assertThat(list.get(0), equalTo("first"));
        assertThat(list.get(1), equalTo("second"));
    }

    @Test
    public void iterateSubbing() {
        // list.size() 方法第一次调用返回1，第二次2，第三次3，第四次4，第5次4
        // when(list.size()).thenReturn(1,2,3,4);
        // 两种写法都行
        when(list.size()).thenReturn(1).thenReturn(2).thenReturn(3).thenReturn(4);
        // when(list.size()).thenReturn(2);
        // when(list.size()).thenReturn(3);
        // when(list.size()).thenReturn(4);

        assertThat(list.size(), equalTo(1));
        assertThat(list.size(), equalTo(2));
        assertThat(list.size(), equalTo(3));
        assertThat(list.size(), equalTo(4));
        assertThat(list.size(), equalTo(4));
    }

    @Test
    public void stubbingWithAnswer() {
        // 如果要返回很多不同的结果
        // when(list.get(anyInt())).thenAnswer(new Answer<String>() {
        //     @Override
        //     public String answer(InvocationOnMock invocationOnMock) throws Throwable {
        //         return null;
        //     }
        // });
        when(list.get(anyInt())).thenAnswer(invocationOnMock -> {
            // 根据索引设置返回值
            Integer index = invocationOnMock.getArgumentAt(0, Integer.class);
            return String.valueOf(index * 10);
        });
        assertThat(list.get(0), equalTo("0"));
        assertThat(list.get(999), equalTo("9990"));

    }

    @Test
    public void stubbingWithRealCall() {
        // cglib 生成代理类
        StubbingService service = mock(StubbingService.class);
        // 调用 getS() 方法返回设定的值
        when(service.getS()).thenReturn("ling");
        assertThat(service.getS(), equalTo("ling"));

        // 调用 getI() 时调用真正的方法
        when(service.getI()).thenCallRealMethod();
        assertThat(service.getI(), equalTo(10));
    }


    @After
    public void destroy() {
        reset(this.list);
    }


}
