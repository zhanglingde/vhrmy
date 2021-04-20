package com.ling.vhr.mapper;

import com.ling.vhr.modules.system.model.JobLevel;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import org.springframework.stereotype.Repository;

/**
 * (JobLevel)Mapper持久层
 *
 * @author zhangling 2021-04-20 16:35:40
 */
@Repository
public interface JobLevelMapper {


    /**
     * 职称列表
     * @return
     */
    List<JobLevel> list();

    /**
     * 添加职称
     * @param jobLevel
     * @return
     */
    int insert(JobLevel jobLevel);

    /**
     * 修改职称
     * @param jobLevel
     * @return
     */
    int updateByPrimaryKeySelective(JobLevel jobLevel);

    /**
     * 删除职称
     * @param id
     * @return
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * 批量删除
     * @param ids
     * @return
     */
    int batchDelete(@Param("ids") Integer[] ids);
}