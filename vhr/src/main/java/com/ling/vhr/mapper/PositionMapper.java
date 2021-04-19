package com.ling.vhr.mapper;

import com.ling.vhr.modules.system.model.Position;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * 职位管理表(Position)Mapper持久层
 *
 * @author zhangling 2021-04-19 17:36:41
 */
@Repository
public interface PositionMapper {


    /**
     * 查询所有职位
     * @return
     */
    List<Position> list();

    /**
     * 添加职位
     * @param position
     * @return
     */
    int insert(Position position);

    /**
     * 更新职位
     * @param position
     * @return
     */
    int updateByPrimaryKeySelective(Position position);

    /**
     * 删除
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