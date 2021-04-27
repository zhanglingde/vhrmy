package com.ling.mail.utils.dto;

/**
 * @author zhangling 2021/4/27 10:53
 */
public class MailDTO {

    /**
     * 收件人
     */
    private String to;
    /**
     * 邮件标题
     */
    private String title;
    /**
     * 邮件正文
     */
    private String text;

    public String getTo() {
        return to;
    }

    public MailDTO setTo(String to) {
        this.to = to;
        return this;
    }

    public String getTitle() {
        return title;
    }

    public MailDTO setTitle(String title) {
        this.title = title;
        return this;
    }

    public String getText() {
        return text;
    }

    public MailDTO setText(String text) {
        this.text = text;
        return this;
    }
}
