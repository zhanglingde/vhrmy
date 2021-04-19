package com.ling.vhr.controller;

import com.ling.vhr.common.utils.CommonResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author zhangling 2021/4/16 11:29
 */
@RestController
public class HelloController {

    @GetMapping("/hello")
    public CommonResult hello() {
        return CommonResult.success("hello");
    }

    @GetMapping("/employee/basic/hello2")
    public CommonResult hello2() {
        return CommonResult.success("/employee/basic/hello2");
    }

    @GetMapping("/employee/advanced/hello3")
    public CommonResult hello3() {
        return CommonResult.success("/employee/advanced/hello3");
    }




}
