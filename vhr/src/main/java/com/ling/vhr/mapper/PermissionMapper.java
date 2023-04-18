package com.ling.vhr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ling.vhr.model.PermissionDO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author zhangling
 * @date 2021/10/8 4:30 下午
 */
@Repository
public interface PermissionMapper extends BaseMapper<PermissionDO> {


    /**
     *
     * @param code
     * @param url
     * @return
     */
    List<PermissionDO> selectPermissions(@Param("code") String code, @Param("url") String url);

    List<PermissionDO> selectAllPermission();


    int updateByPrimeryKey(PermissionDO permission);
}
