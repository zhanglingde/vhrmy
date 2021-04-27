package com.ling.mail;

import com.ling.mail.utils.MailUtils;
import com.ling.mail.utils.dto.MailDTO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class MailApplicationTests {

	@Autowired
	MailUtils mailUtils;

	@Test
	void contextLoads() {
		MailDTO mailDTO = new MailDTO();
		mailDTO.setTo("390597591@qq.com")
				.setTitle("测试邮件")
				.setText("<font color='red'>正文</font>");
		mailUtils.sendHtmlMail(mailDTO);
	}

}
