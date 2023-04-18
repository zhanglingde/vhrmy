package com.ling.vhr.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ling.vhr.model.PermissionDO;

import java.util.List;

/**
 * @author zhangling
 * @date 2021/10/8 4:52 下午
 */

public interface PermissionService extends IService<PermissionDO> {


    /**
     * @param code
     * @param url
     * @return
     */
    List<PermissionDO> selectPermissions(String code, String url);

    /**
     * 刷新权限接口列表
     */
    void fresh();


    /**
     * 扫描所有 Controller
     */
    void scanController();

    void testProxy();

    void updateLov();
}
