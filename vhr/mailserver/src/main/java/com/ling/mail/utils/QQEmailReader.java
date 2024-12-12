package com.ling.mail.utils;

import javax.mail.*;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.mail.search.FlagTerm;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class QQEmailReader {

    public static void main(String[] args) {
        // QQ邮箱服务器设置
        String host = "imap.qq.com";
        String mailStoreType = "imaps";

        // 用户名和授权码（不是密码）
        String username = "390597591@qq.com";
        String password = "ywxjujfvrhvabhia";

        // 获取会话属性对象
        Properties properties = new Properties();
        properties.put("mail.store.protocol", mailStoreType);
        properties.put("mail.imap.host", host);
        properties.put("mail.imap.port", "993");
        properties.put("mail.imap.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        try {
            // 创建会话
            Session emailSession = Session.getDefaultInstance(properties);

            // 创建存储对象并连接
            Store store = emailSession.getStore(mailStoreType);
            store.connect(host, username, password);

            // 获取收件箱文件夹
            Folder inbox = store.getFolder("INBOX");
            inbox.open(Folder.READ_ONLY);

            // 搜索未读邮件
            Flags seenFlag = new Flags(Flags.Flag.SEEN);
            FlagTerm unseenFlagTerm = new FlagTerm(seenFlag, false);
            Message[] messages = inbox.search(unseenFlagTerm);

            System.out.println("Total Unread Messages : " + messages.length);

            // 处理每封未读邮件
            for (int i = 0; i < messages.length; i++) {
                MimeMessage message = (MimeMessage) messages[i];
                System.out.println("---------------------------------");
                System.out.println("Email Number " + (i + 1));
                System.out.println("Subject: " + message.getSubject());
                System.out.println("From: " + message.getFrom()[0]);
                System.out.println("Sent Date: " + message.getSentDate());

                // 提取附件
                saveAttachments(message);

                // 标记邮件为已读
                message.setFlag(Flags.Flag.SEEN, true);
            }

            // 关闭连接
            inbox.close(false);
            store.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void saveAttachments(Part part) throws MessagingException, IOException {
        if (part.isMimeType("multipart/*")) {
            Multipart multipart = (Multipart) part.getContent();
            int count = multipart.getCount();
            for (int i = 0; i < count; i++) {
                BodyPart bodyPart = multipart.getBodyPart(i);
                saveAttachments(bodyPart); // 递归处理每个部分
            }
        } else if (part.isMimeType("message/rfc822")) {
            saveAttachments((Part) part.getContent()); // 如果是嵌套的消息，继续递归
        } else {
            if (part.getDisposition() != null &&
                    (part.getDisposition().equalsIgnoreCase(Part.ATTACHMENT) ||
                            part.getDisposition().equalsIgnoreCase(Part.INLINE))) {
                String fileName = MimeUtility.decodeText(part.getFileName());
                // String fileName = "test.xlsx";
                InputStream is = part.getInputStream();
                File savedFile = new File("D:\\" + fileName);
                FileOutputStream fos = new FileOutputStream(savedFile);
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = is.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
                fos.close();
                System.out.println("Saved file: " + fileName);
            }
        }
    }
}