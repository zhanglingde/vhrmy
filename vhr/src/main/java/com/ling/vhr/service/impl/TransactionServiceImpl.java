package com.ling.vhr.service.impl;

import com.ling.vhr.mapper.RoleMapper;
import com.ling.vhr.modules.system.hr.model.Role;
import com.ling.vhr.service.TransactionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.transaction.support.TransactionTemplate;

/**
 * @author zhangling
 * @date 2022/5/7 12:22 下午
 */
@Slf4j
@Service
public class TransactionServiceImpl implements TransactionService {

    @Autowired
    RoleMapper roleMapper;
    /**
     * 事务管理器
     */
    @Autowired
    PlatformTransactionManager platformTransactionManager;
    @Autowired
    TransactionTemplate transactionTemplate;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void test() {
        Role role = new Role();
        role.setName("test002");
        role.setNameZh("测试角色002");
        roleMapper.insert(role);

        int i = 1 / 0;
    }

    @Override
    public void test2() {
        DefaultTransactionDefinition definition = new DefaultTransactionDefinition();
        definition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
        TransactionStatus transaction = platformTransactionManager.getTransaction(definition);

        try {
            Role role = new Role();
            role.setName("test003");
            role.setNameZh("测试角色002");
            roleMapper.insert(role);

            int i = 1 / 0;
            platformTransactionManager.commit(transaction);
        } catch (Exception e) {
            log.error("error：{}", e);
            platformTransactionManager.rollback(transaction);
        }finally {
            System.out.println("finally");
        }
    }

    @Override
    public void test3() {
        String execute = transactionTemplate.execute(status -> {
            Role role = new Role();
            role.setName("test003");
            role.setNameZh("测试角色002");
            roleMapper.insert(role);

            // int i = 1 / 0;
            return "false";
        });
        System.out.println("execute = " + execute);
    }
}
