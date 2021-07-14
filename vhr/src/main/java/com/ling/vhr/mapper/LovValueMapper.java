package com.ling.vhr.mapper;

import com.ling.vhr.modules.system.lov.dto.LovValueDTO;
import com.ling.vhr.modules.system.lov.vo.LovValueVO;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.cursor.Cursor;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * (LovValue)表数据库访问层
 *
 * @author zhangling
 * @since 2020-09-14 13:41:50
 */
@Repository
public interface LovValueMapper {

    /**
     * 根据lovId查询
     * @param lovId
     * @return
     */
    List<LovValueVO> selectByLovId(Integer lovId);

    /**
     * 根据主键查询lov value
     * @param lovValueId
     * @return
     */
    LovValueDTO selectByPrimary(@Param("lovValueId") Integer lovValueId);

    /**
     * 根据lovCode查询lov value集合
     * @param lovCode
     * @return
     */
    List<LovValueDTO> queryByLovCode(String lovCode);

    /**
     * 新增lov value
     * @param lovValueDTO
     * @return
     */
    int insert(LovValueDTO lovValueDTO);

    /**
     * 编辑lov value
     * @param lovValueDTO
     * @return
     */
    int updateByPrimaryKey(LovValueDTO lovValueDTO);

    /**
     * 根据参数查询
     * @param temp
     * @return
     */
    List<LovValueVO> selectByCondition(LovValueDTO temp);

    /**
     * 测试流式查询
     * @return
     */
    Cursor<LovValueDTO> selectAll();


}