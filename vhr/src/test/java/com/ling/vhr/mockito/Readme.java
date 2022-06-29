package com.ling.vhr.mockito;
import com.ling.vhr.mockito.lesson03.MockByRunnerTest;
import com.ling.vhr.mockito.lesson03.MockByAnnotationTest;
import com.ling.vhr.mockito.lesson03.MockByRuleTest;
import com.ling.vhr.mockito.lesson03.DeepMockTest;
import com.ling.vhr.mockito.lesson08.WildcardArgumentMatcherTest;
import com.ling.vhr.mockito.lesson07.ArgumentsMatcherTest;
import com.ling.vhr.mockito.lesson06.SpyingAnnotationTest;
import com.ling.vhr.mockito.lesson04.StubbingTest;

/**
 * @author zhangling
 * @date 2022/1/7 5:51 下午
 */
public class Readme {

    /**
     * 三种 Mock 方式
     * How to mock class by Mockito as below
     * {@link MockByRunnerTest}
     * {@link MockByAnnotationTest}
     * {@link MockByRuleTest}
     */
    public void mock() {

    }

    /**
     * 一次 mock 出多个对象
     *
     * {@link DeepMockTest}
     */
    public void deepMock() {}

    /**
     * 调用真实的方法
     * 迭代方式调用（每次方法返回值不同）
     *
     * {@link StubbingTest}
     */
    public void stubbing(){}

    /**
     * 部分 mock
     * {@link SpyingAnnotationTest}
     */
    public void spy(){}

    /**
     * 方法参数匹配
     * anyInt(),anyDouble(),anyString(),anyList(),anyCollection()
     * isA(Class<T> clazz)、any(Class<T> clazz)、eq（primitive value）
     *
     * {@link ArgumentsMatcherTest}
     *
     * 方法返回值为 void
     * {@link WildcardArgumentMatcherTest#wildcardMethod2()}  }
     */
    public void argumentsMatcher() {}
}
