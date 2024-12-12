package com.ling.vhr.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ling.vhr.modules.system.lov.domain.dto.LovDTO;
import com.ling.vhr.modules.system.lov.domain.dto.LovSearchDTO;
import com.ling.vhr.modules.system.lov.domain.entity.LovEntity;
import com.ling.vhr.modules.system.lov.domain.vo.LovVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * lov表(Lov)表数据库访问层
 *
 * @author zhangling
 * @since 2020-07-27 10:24:28
 */
@Repository
public interface LovMapper extends BaseMapper<LovEntity> {

    /**
     * 查询列表
     * @param lovSearchDTO
     * @return
     */
    List<LovVO> list(@Param("lovSearch") LovSearchDTO lovSearchDTO);

    /**
     * 查询值集列表
     * @return
     */
    List<LovVO> selectAll();

    /**
     * 添加值集头
     * @param lovDTO
     * @return
     */
    int createLov(LovDTO lovDTO);

    /**
     * 根据主键查询值集头
     * @param lovId
     * @return
     */
    LovVO selectByPrimaryKey(Integer lovId);

    /**
     * 根据主键编辑
     * @param lovDTO
     */
    void updateByPrimaryKey(LovDTO lovDTO);

    /**
     * 根据 lovCode 查询
     * @param lovCode
     * @return
     */
    LovDTO queryLovInfo(String lovCode);

    /**
     * 删除值集header
     * @param lovValueId
     */
    void deleteById(Integer lovValueId);
}