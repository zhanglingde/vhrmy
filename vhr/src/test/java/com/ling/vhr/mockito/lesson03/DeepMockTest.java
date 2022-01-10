package com.ling.vhr.mockito.lesson03;

import org.junit.Before;
import org.junit.Test;
import org.mockito.Answers;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.mockito.Mockito.when;

/**
 * @author zhangling
 * @date 2022/1/7 5:51 下午
 */
public class DeepMockTest {

    // 一次 Mock 多个对象
    @Mock(answer = Answers.RETURNS_DEEP_STUBS)
    private Lesson03Service lesson03Service;

    @Mock
    private Lesson03 lesson03;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testDeepMock() {
        // 空指针异常
        // Lesson03 lesson03 = lesson03Service.get();
        // lesson03.foo();

        // Mock 出 lesson03
        // when(lesson03Service.get()).thenReturn(lesson03);
        // Lesson03 les03 = lesson03Service.get();
        // les03.foo();

        // 一次 Mock 出多级的对象 @Mock(answer = Answers.RETURNS_DEEP_STUBS),将 get 的返回值也进行 Mock
        lesson03Service.get().foo();


    }
}
