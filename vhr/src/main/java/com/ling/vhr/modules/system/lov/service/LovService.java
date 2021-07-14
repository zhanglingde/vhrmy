package com.ling.vhr.modules.system.lov.service;




import com.ling.vhr.modules.system.lov.dto.LovDTO;
import com.ling.vhr.modules.system.lov.dto.LovSearchDTO;
import com.ling.vhr.modules.system.lov.vo.LovVO;

import java.util.List;

/**
 * lov表(Lov)表服务接口
 *
 * @author zhangling
 * @since 2020-07-27 15:51:49
 */
public interface LovService {


    /**
     * 创建值集
     * @param lovDTO
     * @return
     */
    void createLov(LovDTO lovDTO);

    /**
     * 值集列表
     * @return
     */
    List<LovVO> list(LovSearchDTO lovSearchDTO);

    /**
     * 值集详情
     * @param lovId
     * @return
     */
    LovVO details(Integer lovId);

    /**
     * 编辑值集header
     * @param lovDTO
     */
    void updateLov(LovDTO lovDTO);
}