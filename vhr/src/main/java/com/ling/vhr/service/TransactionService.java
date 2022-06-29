package com.ling.vhr.service;

/**
 * @author zhangling
 * @date 2022/5/7 12:22 下午
 */
public interface TransactionService {

    /**
     * 注解式事务
     */
    void test();

    /**
     * 编程式事务
     */
    void test2();

    void test3();
}
