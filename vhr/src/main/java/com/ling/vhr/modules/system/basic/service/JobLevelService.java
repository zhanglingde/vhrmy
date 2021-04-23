package com.ling.vhr.modules.system.basic.service;

import com.ling.vhr.mapper.JobLevelMapper;
import com.ling.vhr.modules.system.basic.model.JobLevel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * 
 *
 * @author zhangling 2021-04-20 16:35:42
 */
@Service
public class JobLevelService {

    @Autowired
    JobLevelMapper jobLevelMapper;


    /**
     * 职称列表
     * @return
     */
    public List<JobLevel> list() {
        return jobLevelMapper.list();
    }

    /**
     * 添加职称
     * @param jobLevel
     * @return
     */
    public int addJobLevel(JobLevel jobLevel) {
        jobLevel.setEnabled(1);
        jobLevel.setCreateDate(new Date());
        return jobLevelMapper.insert(jobLevel);
    }

    /**
     * 修改职称
     * @param jobLevel
     * @return
     */
    public int updateJobLevel(JobLevel jobLevel) {

        return jobLevelMapper.updateByPrimaryKeySelective(jobLevel);
    }

    /**
     * 删除职称
     * @param id
     * @return
     */
    public int deleteJobLevel(Integer id) {
        return jobLevelMapper.deleteByPrimaryKey(id);
    }

    public int batchDelete(Integer[] ids) {
        return jobLevelMapper.batchDelete(ids);

    }
}