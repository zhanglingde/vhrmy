package com.ling.vhr.modules;

import com.ling.vhr.common.utils.CommonResult;
import io.swagger.annotations.Api;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author zhangling 2021/4/16 10:52
 */
@RestController
@Api(tags = "登录")
public class LoginController {

    @GetMapping(name = "登录", value = "/login")
    public CommonResult login() {
        return CommonResult.error("尚未登录,请登录!");
    }
}
