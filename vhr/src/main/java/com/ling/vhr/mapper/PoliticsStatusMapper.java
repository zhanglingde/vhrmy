package com.ling.vhr.mapper;

import com.ling.vhr.modules.emp.model.PoliticsStatus;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author zhangling 2021/4/25 10:55
 */
@Repository
public interface PoliticsStatusMapper {

    /**
     * 查询所有政治面貌
     * @return
     */
    List<PoliticsStatus> selectAllPoliticsStatus();
}
