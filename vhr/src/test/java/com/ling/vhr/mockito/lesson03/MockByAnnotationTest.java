package com.ling.vhr.mockito.lesson03;

import com.ling.vhr.mockito.common.Account;
import com.ling.vhr.mockito.common.AccountDao;
import org.junit.Before;

import org.junit.Test;
import org.mockito.Answers;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

/**
 * @author zhangling
 * @date 2022/1/7 5:33 下午
 */

public class MockByAnnotationTest {
    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }
    // Answers.RETURNS_SMART_NULLS 返回方法字符串调用 accountDao.findAccount("x", "x");
    @Mock(answer = Answers.RETURNS_SMART_NULLS)
    private AccountDao accountDao;

    @Test
    public void testMock() {
        // 未 Mock 会报空指针
        Account account = accountDao.findAccount("x", "x");
        System.out.println("account = " + account);

    }
}
