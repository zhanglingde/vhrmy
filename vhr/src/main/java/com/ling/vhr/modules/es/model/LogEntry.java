package com.ling.vhr.modules.es.model;

import lombok.Data;

/**
 * @author zhangling  2021/8/9 15:17
 */
@Data
public class LogEntry {
    private Long port;
    private Long levelValue;
    private String level;
    private String threadName;
    private String host;
    private String loggerName;
    private String message;


}
