package com.ling.vhr.modules.system.lov.service.impl;



import com.ling.vhr.common.exception.RrException;
import com.ling.vhr.common.utils.RedisUtils;
import com.ling.vhr.mapper.LovMapper;
import com.ling.vhr.mapper.LovValueMapper;
import com.ling.vhr.modules.system.lov.adapter.LovAdapter;
import com.ling.vhr.modules.system.lov.domain.dto.LovValueDTO;
import com.ling.vhr.modules.system.lov.service.LovValueService;
import com.ling.vhr.modules.system.lov.domain.vo.LovValueVO;
import ma.glasnost.orika.MapperFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;

/**
 * @author zhangling
 * @since 2020/11/18 9:55
 */
@Service
public class LovValueServiceImpl implements LovValueService {

    @Autowired
    private LovMapper lovMapper;

    @Autowired
    private LovValueMapper lovValueMapper;

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private LovAdapter lovAdapter;
    @Autowired
    MapperFactory mapperFactory;


    @Override
    public List<LovValueVO> queryLovValue(String lovCode) {

        //List<LovValueDTO> lovValueDTOList = lovMapper.queryLovValue(lovCode);
        List<LovValueDTO> lovValueDTOList = lovAdapter.queryLovValue(lovCode);
        List<LovValueVO> list = mapperFactory.getMapperFacade().mapAsList(lovValueDTOList, LovValueVO.class);
        return list;
    }

    @Override
    public void createLovValue(LovValueDTO lovValueDTO) {
        this.checkLovValue(lovValueDTO);

        String valueKey = "lov:value:" + lovValueDTO.getLovCode();
        redisUtils.delete(valueKey);


        lovValueMapper.insert(lovValueDTO);
    }


    private void checkLovValue(LovValueDTO lovValueDTO) {
        LovValueDTO temp = new LovValueDTO();
        temp.setValue(lovValueDTO.getValue());
        temp.setLovId(lovValueDTO.getLovId());

        List<LovValueVO> list = lovValueMapper.selectByCondition(temp);
        if(!CollectionUtils.isEmpty(list)){
            throw new RrException("该value已存在");
        }
    }


    @Override
    public void deleteValue(Integer[] lovValueIds) {
        for (Integer lovValueId : lovValueIds) {
            LovValueDTO lovValueDTO = lovValueMapper.selectByPrimary(lovValueId);
            if (lovValueDTO == null) {
                return;
            }

            String valueKey = "lov:value:" + lovValueDTO.getLovCode();
            redisUtils.delete(valueKey);
            lovMapper.deleteById(lovValueId);
        }
    }

    @Override
    public LovValueDTO updateLovValue(LovValueDTO lovValueDTO) {
        LovValueDTO temp = lovValueMapper.selectByPrimary(lovValueDTO.getLovValueId());
        if (temp == null) {
            throw new RrException("值集不存在");
        }
        String valueKey = "lov:value:" + temp.getLovCode();
        redisUtils.delete(valueKey);
        lovValueMapper.updateByPrimaryKey(lovValueDTO);
        return lovValueDTO;
    }
}
