package com.ling.mail.utils;

import com.ling.mail.utils.dto.MailDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.validation.annotation.Validated;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.MimeMessage;

/**
 * @author zhangling 2021/4/27 10:50
 */
@Component
public class MailUtils {

    private static final Logger logger = LoggerFactory.getLogger(MailUtils.class);

    @Autowired
    JavaMailSender javaMailSender;

    @Value("${spring.mail.username}")
    private String from;

    public void sendHtmlMail(MailDTO mailDTO) {
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
            helper.setFrom(from);
            helper.setTo(mailDTO.getTo());
            helper.setSubject(mailDTO.getTitle());
            helper.setText(mailDTO.getText(), true);
            javaMailSender.send(mimeMessage);
            logger.info("邮件发送成功！");
        } catch (MessagingException e) {
            e.printStackTrace();
            logger.error("发送邮件错误:{}", e.getMessage());
        }
    }


}
