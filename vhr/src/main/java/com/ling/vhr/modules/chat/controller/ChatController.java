package com.ling.vhr.modules.chat.controller;

import com.ling.vhr.modules.system.hr.model.Hr;
import com.ling.vhr.modules.system.hr.service.HrService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 在线聊天
 *
 * @author zhangling 2021/4/29 10:44
 */
@RestController
@RequestMapping("/chat")
@Api(tags = "在线聊天")
public class ChatController {

    @Autowired
    HrService hrService;

    @GetMapping(name = "获取除自己之外其他用户", value = "/hrs")
    @ApiOperation("/获取除自己之外其他用户")
    public List<Hr> getAllHrs() {
        return hrService.getAllHrsExceptCurrentHr();
    }
}
