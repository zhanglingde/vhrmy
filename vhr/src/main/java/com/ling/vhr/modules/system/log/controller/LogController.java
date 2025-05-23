package com.ling.vhr.modules.system.log.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.common.utils.PageUtils;
import com.ling.vhr.modules.system.log.domain.dto.LogSearchDto;
import com.ling.vhr.modules.system.log.domain.vo.LogVO;
import com.ling.vhr.modules.system.log.service.LogService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 日志列表
 * @author zhangling  2021/8/10 10:57
 */
@RestController
@RequestMapping("/system/log")
@Api(tags = "日志管理")
public class LogController {

    @Autowired
    LogService logService;

    @GetMapping("/")
    public CommonResult<PageUtils<LogVO>> logList(LogSearchDto logSearchDto){
        return logService.logList(logSearchDto);
    }
}
