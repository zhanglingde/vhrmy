package com.ling.vhr.modules.system.lov.convert;



import com.ling.vhr.modules.system.lov.dto.LovValueDTO;
import com.ling.vhr.modules.system.lov.vo.LovValueVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mappings;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * lov表(Lov)领域模型转换
 *
 * @author zhangling
 * @since 2020-07-28 15:52:01
 */
 // @Mapper
public interface LovConvert {

    LovConvert INSTANCE = Mappers.getMapper(LovConvert.class);

    LovValueVO convertLovValueVO(LovValueDTO lovValueDTO);

    // @Mappings({})
    // List<LovValueVO> convertLovValueVO(List<LovValueDTO> lovValueDTOList);

}