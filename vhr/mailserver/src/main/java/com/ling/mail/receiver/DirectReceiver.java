package com.ling.mail.receiver;

import com.ling.mail.utils.MailUtils;
import com.ling.mail.utils.dto.MailDTO;
import com.ling.vhr.modules.emp.model.Employee;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.Message;
import org.springframework.stereotype.Component;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import java.nio.channels.Channel;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 监听消费消息
 * @author zhangling 2021/4/27 11:14
 */
@Component
public class DirectReceiver {

    @Autowired
    MailUtils mailUtils;

    @Autowired
    TemplateEngine templateEngine;

    /**
     * 处理邮件消息
     * @param message
     * @param channel
     */
    @RabbitListener(queues = "ling-mail-queue")
    public void handle(Message message) {
        Employee employee = (Employee) message.getPayload();

        Context context = new Context();
        LocalDate date = LocalDate.now();
        LocalDateTime time = LocalDateTime.now();
        context.setVariable("workId",employee.getWorkId());
        context.setVariable("departmentName",employee.getDepartment().getDepartmentName());
        context.setVariable("positionName",employee.getPosition().getName());
        context.setVariable("jobLevelName",employee.getJobLevel().getName());
        context.setVariable("year",date.getYear());
        context.setVariable("month",date.getMonthValue());
        context.setVariable("day",date.getDayOfMonth());
        context.setVariable("hour",time.getHour());
        context.setVariable("minute",time.getMinute());
        String mailText = templateEngine.process("mail", context);

        MailDTO mailDTO = new MailDTO();
        mailDTO.setTo(employee.getEmail());
        mailDTO.setTitle("微人事入职欢迎邮件!");
        mailDTO.setText(mailText);

        mailUtils.sendHtmlMail(mailDTO);
    }
}
