package com.ling.vhr.modules.emp.service;

import com.ling.vhr.mapper.PoliticsStatusMapper;
import com.ling.vhr.modules.emp.model.PoliticsStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 政治面貌
 * @author zhangling 2021/4/25 10:53
 */
@Service
public class PoliticsStatusService {

    @Autowired
    PoliticsStatusMapper politicsStatusMapper;

    /**
     * 获取所有政治面貌
     * @return
     */
    public List<PoliticsStatus> getAllPoliticsStatus() {
        return politicsStatusMapper.selectAllPoliticsStatus();
    }
}
