package com.ling.vhr.mapper;

import com.ling.vhr.modules.emp.model.Nation;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author zhangling 2021/4/25 10:54
 */
@Repository
public interface NationMapper {

    /**
     * 查询所有民族
     * @return
     */
    List<Nation> selectAllNations();
}
