package com.ling.vhr.common.delay;

import lombok.Data;
import lombok.ToString;

/**
 * @author zhangling
 * @date 2021/11/11 11:16 上午
 */
@Data
@ToString
public class Message {
    private String id;
    private Object data;
}
