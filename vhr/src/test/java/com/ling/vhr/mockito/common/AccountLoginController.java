package com.ling.vhr.mockito.common;

import javax.servlet.http.HttpServletRequest;

/**
 * @author zhangling
 * @date 2022/1/7 4:34 下午
 */
public class AccountLoginController {

    AccountDao accountDao;

    public AccountLoginController(AccountDao accountDao) {
        this.accountDao = accountDao;
    }

    public String login(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try {
            Account account = accountDao.findAccount(username, password);
            if (account == null) {
                return "/login";
            }else {
                return "/index";
            }
        } catch (Exception e) {
            return "/505";
        }
    }
}
