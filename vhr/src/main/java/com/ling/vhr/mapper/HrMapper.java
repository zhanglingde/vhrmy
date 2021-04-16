package com.ling.vhr.mapper;

import com.ling.vhr.model.Hr;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import org.springframework.stereotype.Repository;

/**
 * (Hr)Mapper持久层
 *
 * @author zhangling 2021-04-16 09:58:45
 */
@Repository
public interface HrMapper {

    Hr select();
    

}