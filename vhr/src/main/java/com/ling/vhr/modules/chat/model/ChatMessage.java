package com.ling.vhr.modules.chat.model;

import lombok.Data;

import java.util.Date;

/**
 * @author zhangling 2021/4/29 11:19
 */
@Data
public class ChatMessage {

    /**
     * 消息发送者
     */
    private String from;
    /**
     * 消息接收者
     */
    private String to;
    /**
     * 消息内容
     */
    private String content;
    /**
     * 消息发送时间
     */
    private Date date;
}
