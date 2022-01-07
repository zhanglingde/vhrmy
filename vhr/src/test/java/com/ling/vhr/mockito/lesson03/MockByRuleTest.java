package com.ling.vhr.mockito.lesson03;

import com.ling.vhr.mockito.common.Account;
import com.ling.vhr.mockito.common.AccountDao;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

import static org.mockito.Mockito.mock;

/**
 * @author zhangling
 * @date 2022/1/7 5:46 下午
 */
public class MockByRuleTest {

    @Rule
    public MockitoRule mockitoRule = MockitoJUnit.rule();

    @Mock
    private AccountDao accountDao;

    @Test
    public void testMock() {
        // AccountDao accountDao = mock(AccountDao.class);
        Account account = accountDao.findAccount("x", "x");
        System.out.println("account = " + account);
    }
}

