package com.ling.vhr.controller;

import com.ling.vhr.common.utils.CommonResult;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author zhangling 2021/4/16 10:52
 */
@RestController
public class LoginController {

    @GetMapping("/login")
    public CommonResult login() {
        return CommonResult.error("尚未登录,请登录!");
    }
}
