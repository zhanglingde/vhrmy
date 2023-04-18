package com.ling.vhr.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author zhangling  2021/8/9 20:42
 */
@RestController
public class ESController {

    private static final Logger logger = LoggerFactory.getLogger(ESController.class);

    @GetMapping("/errorlog")
    public String hello(){
        logger.error("error 日志");
        return "error 日志";
    }

    @GetMapping("/infolog")
    public String info(){
        logger.info("info 日志");
        return "info 日志";
    }

    @GetMapping("/warnlog")
    public String warn(){
        logger.warn("warn 日志");
        return "warn 日志";
    }

    @GetMapping("/debug")
    public String debug(){
        logger.debug("debug 日志");
        return "debug 日志";
    }
}
