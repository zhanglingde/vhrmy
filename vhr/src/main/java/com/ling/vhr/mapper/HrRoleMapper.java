package com.ling.vhr.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @author zhangling  2021/4/23 20:48
 */
@Repository
public interface HrRoleMapper {


    /**
     * 根据hrId删除关联角色
     * @param hrId
     */
    void deleteByHrId(Integer hrId);

    /**
     * 批量添加角色
     * @param hrId
     * @param roleIds
     */
    void batchInsert(@Param("hrId") Integer hrId, @Param("roleIds") Integer[] roleIds);
}
