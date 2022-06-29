package com.ling.vhr.mockito.lesson01;

import com.ling.vhr.mockito.common.Account;
import com.ling.vhr.mockito.common.AccountDao;
import com.ling.vhr.mockito.common.AccountLoginController;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.mockito.runners.MockitoJUnitRunner;

import javax.servlet.http.HttpServletRequest;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.mockito.Matchers.anyString;


/**
 * @author zhangling
 * @date 2022/1/7 4:34 下午
 */
@RunWith(MockitoJUnitRunner.class)
public class AccountLoginControllerTest {

    private AccountDao accountDao;
    private HttpServletRequest request;
    private AccountLoginController accountLoginController;

    @Before
    public void setUp() {
        this.accountDao = Mockito.mock(AccountDao.class);
        this.request = Mockito.mock(HttpServletRequest.class);
        this.accountLoginController = Mockito.mock(AccountLoginController.class);
    }

    @Test
    public void testLoginSuccess() {
        Account account = new Account();
        Mockito.when(request.getParameter("username")).thenReturn("ling");
        Mockito.when(request.getParameter("password")).thenReturn("123456");
        Mockito.when(accountDao.findAccount(anyString(),anyString())).thenReturn(account);

        assertThat(accountLoginController.login(request), equalTo("/index"));
    }
    @Test
    public void testLoginFailture() {
        Account account = new Account();
        Mockito.when(request.getParameter("username")).thenReturn("ling");
        Mockito.when(request.getParameter("password")).thenReturn("1234567");
        Mockito.when(accountDao.findAccount(anyString(),anyString())).thenReturn(null);

        assertThat(accountLoginController.login(request), equalTo("/login"));
    }
    @Test
    public void testLogin505() {
        Account account = new Account();
        Mockito.when(request.getParameter("username")).thenReturn("ling");
        Mockito.when(request.getParameter("password")).thenReturn("1234567");
        Mockito.when(accountDao.findAccount(anyString(),anyString())).thenThrow(UnsupportedOperationException.class);

        assertThat(accountLoginController.login(request), equalTo("/505"));
    }
}
