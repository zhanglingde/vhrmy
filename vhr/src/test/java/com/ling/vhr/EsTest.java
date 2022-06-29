package com.ling.vhr;

import com.ling.vhr.common.utils.DelayQueueTask;
import com.ling.vhr.common.utils.ElasticSearchUtils;
import com.ling.vhr.modules.system.log.model.LogEntry;
import lombok.Data;
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

}
