package com.ling.vhr.modules.system.basic.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.basic.model.Position;
import com.ling.vhr.modules.system.basic.service.PositionService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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


    @GetMapping(name = "职位列表", value = "/")
    @ApiOperation(value = "职位列表")
    public List<Position> list() {
        List<Position> list = positionService.list();
        return list;
    }

    @PostMapping(name = "添加职位", value = "/")
    @ApiOperation(value = "添加职位")
    public CommonResult addPosition(@RequestBody Position position) {
        if (positionService.addPosition(position) == 1) {
            return CommonResult.success(null, "添加成功");
        }
        return CommonResult.error("添加失败");
    }

    @PutMapping(name = "更新职位", value = "/")
    @ApiOperation(value = "更新职位")
    public CommonResult updatePosition(@RequestBody Position position) {
        if (positionService.updatePosition(position) == 1) {
            return CommonResult.success(null, "更新成功");
        }
        return CommonResult.error("更新失败");
    }

    @DeleteMapping(name = "删除职位", value = "/")
    @ApiOperation(value = "删除职位")
    public CommonResult deletePosition(Integer id) {
        if (positionService.deleteByPrimaryKey(id) == 1) {
            return CommonResult.success(null, "删除成功");
        }
        return CommonResult.error("删除失败");
    }

    @DeleteMapping(name = "批量删除职位", value = "/batch")
    @ApiOperation(value = "批量删除职位")
    public CommonResult batchDelete(Integer[] ids) {
        if (positionService.batchDelete(ids) == ids.length) {
            return CommonResult.success(null, "批量删除成功！");
        }
        return CommonResult.error(null, "批量删除失败!");
    }


}
