package com.ling.vhr.modules.system.lov.controller;


import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.mapper.LovValueMapper;
import com.ling.vhr.modules.system.lov.dto.LovValueDTO;
import com.ling.vhr.modules.system.lov.service.LovValueService;
import com.ling.vhr.modules.system.lov.vo.LovValueVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.ibatis.cursor.Cursor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author zhangling
 * @since 2020/11/18 9:54
 */
@RestController
@RequestMapping("/api/lov/value")
@Api(tags = "[API] LOV值集管理")
public class LovValueController {

    @Autowired
    LovValueService lovValueService;

    @Autowired
    LovValueMapper lovValueMapper;

    @Autowired
    SqlSessionFactory sqlSessionFactory;

    @Autowired
    PlatformTransactionManager transactionManager;


    @ApiOperation(value = "查询值集value", notes = "查询值集value")
    @GetMapping("/query")
    public CommonResult<List<LovValueVO>> queryLovValue(@ApiParam("值集编码") @RequestParam(required = true) String lovCode) {
        List<LovValueVO> list = lovValueService.queryLovValue(lovCode);
        return CommonResult.success(list);
    }


    @ApiOperation(value = "新增值集value", notes = "新增值集value")
    @PostMapping("/create")
    public CommonResult createLovValue(@RequestBody LovValueDTO lovValueDTO) {

        lovValueService.createLovValue(lovValueDTO);
        return CommonResult.success(null, "创建成功");
    }

    @ApiOperation(value = "编辑值集value", notes = "编辑值集value")
    @PostMapping("/update/value")
    public CommonResult<LovValueDTO> updateLovValue(@RequestBody LovValueDTO lovValueDTO) {

        LovValueDTO value = lovValueService.updateLovValue(lovValueDTO);
        return CommonResult.success(value);
    }

    @ApiOperation(value = "删除值集value", notes = "删除值集value")
    @PostMapping("/value/delete")
    public CommonResult deleteValue(@RequestBody Integer[] lovValueIds) {

        lovValueService.deleteValue(lovValueIds);
        return CommonResult.success(null, "删除成功");
    }

    @ApiOperation("测试mybatis流式查询")
    @GetMapping("/test")
    @Transactional
    public void test() {

        Cursor<LovValueDTO> cursor = lovValueMapper.selectAll();
        cursor.forEach(lovValueDTO -> { System.out.println(lovValueDTO); });

    }

}
