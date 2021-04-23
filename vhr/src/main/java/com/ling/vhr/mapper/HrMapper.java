package com.ling.vhr.mapper;

import com.ling.vhr.modules.system.basic.model.Hr;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * (Hr)Mapper持久层
 *
 * @author zhangling 2021-04-16 09:58:45
 */
@Repository
public interface HrMapper {



    /**
     * 根据用户名查找用户
     */
    Hr selectByUsername(String username);

    /**
     * 查询除自己之外的所有Hr用户
     * @param id
     * @return
     */
    List<Hr> getAllHrs(Integer id);

    /**
     * 根据主键修改Hr
     * @param hr
     * @return
     */
    int updateByPrimaryKeySelective(Hr hr);
}