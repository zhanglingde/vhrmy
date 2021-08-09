package com.ling.vhr.modules.es.controller;

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

    @GetMapping("/error")
    public void hello(){
        logger.error("error 日志");
    }

    @GetMapping("/info")
    public void info(){
        logger.info("info 日志");
    }

    @GetMapping("/warn")
    public void warn(){
        logger.warn("warn 日志");
    }
}
