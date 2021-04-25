package com.ling.vhr.modules.emp.service;

import com.ling.vhr.mapper.NationMapper;
import com.ling.vhr.modules.emp.model.Nation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 民族
 * @author zhangling 2021/4/25 10:53
 */
@Service
public class NationService {

    @Autowired
    NationMapper nationMapper;

    /**
     * 获取所有民族
     * @return
     */
    public List<Nation> getAllNations() {
        return nationMapper.selectAllNations();
    }
}
