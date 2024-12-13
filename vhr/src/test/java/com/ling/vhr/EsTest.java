package com.ling.vhr;

import com.ling.vhr.common.utils.DelayQueueTask;
import com.ling.vhr.common.utils.ElasticSearchUtils;
import com.ling.vhr.esmapper.InvoiceVatMapper;
import com.ling.vhr.modules.invoice.InvoiceVat;
import com.ling.vhr.modules.system.log.model.LogEntry;
import lombok.Data;
import org.apache.lucene.document.Document;
import org.dromara.easyes.core.kernel.EsWrappers;
import org.junit.Assert;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import redis.clients.jedis.Jedis;

import java.util.List;

/**
 * @author zhangling  2021/8/9 14:56
 */
@SpringBootTest
public class EsTest {


    @Autowired
    DelayQueueTask delayQueueTask;
    @Autowired
    ElasticSearchUtils elasticSearchUtils;

    @Test
    void test01() {
        boolean book = elasticSearchUtils.isExistIndex("book");
        System.out.println("book = " + book);

    }

    @Test
    void search() {
        List<LogEntry> logEntries = elasticSearchUtils.searchListData("log-ling-dev-2021.08.09", null, LogEntry.class);
        logEntries.forEach(System.out::println);
    }

    @Data
    static class Book {
        private String name;
        private String author;
    }

    @Test
    public void testFwet() throws Exception {
        Thread producer = new Thread(() -> {
            for (int i = 0; i < 5; i++) {
                delayQueueTask.queue("zhangling>>>" + i);
            }
        });
        Thread consumer = new Thread(() -> {
            delayQueueTask.loop();
        });

        producer.start();
        consumer.start();
        System.in.read();
    }

    @Autowired
    InvoiceVatMapper invoiceVatMapper;

    @Test
    public void t004(){
        // 测试查询 写法和MP一样 可以用链式,也可以非链式 根据使用习惯灵活选择即可
        String title = "INVV_2111171AG911TS";
        InvoiceVat document = EsWrappers.lambdaChainQuery(invoiceVatMapper)
                .eq(InvoiceVat::getCode, title)
                .one();
        System.out.println(document);
        Assert.assertEquals(title,document.getCode());
    }

}
