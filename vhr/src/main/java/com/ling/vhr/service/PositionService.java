package com.ling.vhr.service;

/**
 * 职位管理
 * @author zhangling 2021/4/19 17:41
 */

import com.ling.vhr.mapper.PositionMapper;
import com.ling.vhr.model.Position;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class PositionService {

    @Autowired
    PositionMapper positionMapper;

    public List<Position> list() {
        List<Position> list = positionMapper.list();
        return list;
    }

    /**
     * 添加职位
     * @param position
     * @return
     */
    public int addPosition(Position position) {
        position.setEnabled(1);
        position.setCreateDate(new Date());
        return positionMapper.addPosition(position);
    }
}
