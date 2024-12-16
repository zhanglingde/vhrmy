package com.ling.vhr.modules.system.log.domain.dto;

import lombok.Data;

/**
 * @author zhangling  2021/8/9 15:17
 */
@Data
public class LogSearchDto {
    private String message;
    private String level;
    private Integer page;
    private Integer size;
    // @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    // @JsonFormat(pattern = "",timezone = "Asia/Shanghai")
    private String startTime;
    // @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    // @JsonFormat(pattern = "",timezone = "Asia/Shanghai")
    private String endTime;
    private String day;


}
