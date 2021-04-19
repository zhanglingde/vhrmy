package com.ling.vhr.mapper;

import com.ling.vhr.modules.system.model.Hr;
import org.springframework.stereotype.Repository;

/**
 * (Hr)Mapper持久层
 *
 * @author zhangling 2021-04-16 09:58:45
 */
@Repository
public interface HrMapper {

    Hr select(Integer id);


    /**
     * 根据用户名查找用户
     */
    Hr selectByUsername(String username);
}