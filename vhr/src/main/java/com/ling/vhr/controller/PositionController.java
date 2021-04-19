package com.ling.vhr.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.model.Position;
import com.ling.vhr.service.PositionService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author zhangling 2021/4/19 17:38
 */
@Api(tags = "职位管理")
@RestController
@RequestMapping("/system/basic/pos")
public class PositionController {

    @Autowired
    PositionService positionService;

    @GetMapping("/")
    public List<Position> list() {
        List<Position> list =  positionService.list();
        return list;
    }

    @PostMapping("/")
    public CommonResult addPosition(@RequestBody Position position) {
        if (positionService.addPosition(position) == 1) {
            return CommonResult.success("添加成功");
        }
        return CommonResult.error("添加失败");
    }
}
