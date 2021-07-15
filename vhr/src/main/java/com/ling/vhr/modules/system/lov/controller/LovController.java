package com.ling.vhr.modules.system.lov.controller;



import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.lov.dto.LovDTO;
import com.ling.vhr.modules.system.lov.dto.LovSearchDTO;
import com.ling.vhr.modules.system.lov.service.LovService;
import com.ling.vhr.modules.system.lov.vo.LovVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * lov表(Lov)表控制层
 *
 * @author zhangling
 * @since 2020-07-27 15:51:48
 */
@RestController
@RequestMapping("/system/lov")
@Api(tags = "[API] LOV值集管理")
public class LovController {

    @Autowired
    private LovService lovService;

    @ApiOperation(value = "值集列表", notes = "值集列表")
    @GetMapping("/")
    public List<LovVO> list(LovSearchDTO lovSearchDTO){
        return lovService.list(lovSearchDTO);
    }

    @ApiOperation(value = "值集详情", notes = "值集详情")
    @GetMapping("/details")
    public CommonResult<LovVO> details(Integer lovId){
        return CommonResult.success(lovService.details(lovId));
    }

    @ApiOperation(value = "新增值集header", notes = "新增值集header")
    @PostMapping("/create")
    public CommonResult createLov(@RequestBody LovDTO lovDTO) {
        lovService.createLov(lovDTO);
        return CommonResult.success(null, "操作成功");
    }

    @ApiOperation(value = "编辑值集header", notes = "编辑值集header")
    @PostMapping("/update")
    public CommonResult updateLov(@RequestBody LovDTO lovDTO){
        lovService.updateLov(lovDTO);
        return CommonResult.success("操作成功");
    }
}