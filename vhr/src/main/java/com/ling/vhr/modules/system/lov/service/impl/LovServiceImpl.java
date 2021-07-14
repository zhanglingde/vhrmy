package com.ling.vhr.modules.system.lov.service.impl;


import com.ling.vhr.common.exception.RrException;
import com.ling.vhr.common.utils.RedisUtils;
import com.ling.vhr.mapper.LovMapper;
import com.ling.vhr.mapper.LovValueMapper;
import com.ling.vhr.modules.system.lov.adapter.LovAdapter;
import com.ling.vhr.modules.system.lov.dto.LovDTO;
import com.ling.vhr.modules.system.lov.dto.LovSearchDTO;
import com.ling.vhr.modules.system.lov.service.LovService;
import com.ling.vhr.modules.system.lov.vo.LovVO;
import com.ling.vhr.modules.system.lov.vo.LovValueVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * lov表(Lov)表服务实现类
 *
 * @author zhangling
 * @since 2020-07-27 15:51:50
 */
@Service("lovService")
public class LovServiceImpl implements LovService {

    @Autowired
    private LovMapper lovMapper;

    @Autowired
    private LovValueMapper lovValueMapper;

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private LovAdapter lovAdapter;


    @Override
    @Transactional(rollbackFor = Exception.class)
    public void createLov(LovDTO lovDTO) {

        this.checkLovCode(lovDTO.getLovCode());
        // 创建值集头
        lovMapper.createLov(lovDTO);

        //if (!CollectionUtils.isEmpty(lovDTO.getLovValueDTOList())) {
        //    lovDTO.getLovValueDTOList().forEach(lovValue -> {
        //        lovValue.setLovId(lovDTO.getLovId());
        //        lovValue.setLovCode(lovDTO.getLovCode());
        //    });
        //    lovMapper.batchInsertLovValue(lovDTO.getLovValueDTOList());
        //}

    }

    /**
     * 校验lovCode是否存在
     * @param lovCode
     */
    private void checkLovCode(String lovCode) {
        LovDTO lovDTO = lovMapper.queryLovInfo(lovCode);
        if (lovDTO != null) {
            throw new RrException("该lovCode已存在！");
        }
    }



    @Override
    public List<LovVO> list(LovSearchDTO lovSearchDTO) {
        List<LovVO> list = lovMapper.list(lovSearchDTO);
        return list;
    }

    @Override
    public LovVO details(Integer lovId) {
        LovVO lovVO = lovMapper.selectByPrimaryKey(lovId);
        List<LovValueVO> list = lovValueMapper.selectByLovId(lovId);
        lovVO.setLovValueList(list);
        return lovVO;
    }



    @Override
    public void updateLov(LovDTO lovDTO) {
        lovMapper.updateByPrimaryKey(lovDTO);
    }
}