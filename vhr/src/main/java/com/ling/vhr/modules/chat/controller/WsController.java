package com.ling.vhr.modules.chat.controller;

import com.ling.vhr.modules.chat.model.ChatMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.security.Principal;
import java.util.Date;

/**
 * WebSocket的消息处理类
 * @author zhangling 2021/4/29 11:17
 */
@Controller
public class WsController {

    @Autowired
    SimpMessagingTemplate simpMessagingTemplate;

    /**
     * 处理消息接口
     * @param principal 获取当前登录用户（获取消息发送者）
     * @param chatMessage 获取消息信息
     */
    @MessageMapping("/ws/chat")
    public void handleMessage(Principal principal, ChatMessage chatMessage) {
        chatMessage.setFrom(principal.getName());
        chatMessage.setDate(new Date());
        // 前端监听 queue-chat的内容
        simpMessagingTemplate.convertAndSendToUser(chatMessage.getTo(),"/queue/chat",chatMessage.getContent());
    }
}
