package com.ling.vhr.mapper;

import com.ling.vhr.modules.permission.model.Permission;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author zhangling
 * @date 2021/10/8 4:30 下午
 */
@Repository
public interface PermissionMapper {

    int insert(Permission permission);

    /**
     *
     * @param code
     * @param url
     * @return
     */
    List<Permission> selectPermissions(@Param("code") String code, @Param("url") String url);

    List<Permission> selectAllPermission();


    int updateByPrimeryKey(Permission permission);
}
