package com.ling.vhr.modules.system.hr.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.basic.model.Hr;
import com.ling.vhr.modules.system.hr.service.HrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author zhangling 2021/4/23 16:50
 */
@RestController
@RequestMapping("/system/hr")
public class HrController {

    @Autowired
    HrService hrService;

    @GetMapping("/")
    public List<Hr> getAllHrs() {
        return hrService.getAllHrs();
    }

    @PutMapping("/")
    public CommonResult updateHr(@RequestBody Hr hr) {
        if (hrService.updateHr(hr) == 1) {
            return CommonResult.success(null,"修改成功！");
        }
        return CommonResult.error("修改失败！");
    }
}
