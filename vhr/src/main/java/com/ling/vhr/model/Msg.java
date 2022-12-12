package com.ling.vhr.model;

import lombok.Data;

/**
 * @author zhangling
 * @date 2022/8/25 9:42 AM
 */
@Data
public class Msg {

    private String topic;
    private String key;
    private String tag;
    private String body;
}
