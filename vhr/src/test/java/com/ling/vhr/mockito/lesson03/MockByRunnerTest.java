package com.ling.vhr.mockito.lesson03;

import com.ling.vhr.mockito.common.Account;
import com.ling.vhr.mockito.common.AccountDao;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.mockito.runners.MockitoJUnitRunner;

import static org.mockito.Mockito.mock;

/**
 * @author zhangling
 * @date 2022/1/7 5:22 下午
 */
@RunWith(MockitoJUnitRunner.class)
public class MockByRunnerTest {

    @Test
    public void testMock() {
        // Mockito.RETURNS_SMART_NULLS 返回字符串
        AccountDao accountDao = mock(AccountDao.class, Mockito.RETURNS_SMART_NULLS);
        Account account = accountDao.findAccount("x", "x");
        System.out.println("account = " + account);
    }
}
