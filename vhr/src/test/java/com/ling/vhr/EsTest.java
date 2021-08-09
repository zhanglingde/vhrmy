package com.ling.vhr;

import com.ling.vhr.common.utils.ElasticSearchUtils;
import com.ling.vhr.common.utils.JsonUtils;
import com.ling.vhr.modules.es.model.LogEntry;
import lombok.Data;
import org.elasticsearch.action.get.GetRequest;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.client.Request;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.awt.print.Book;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zhangling  2021/8/9 14:56
 */
@SpringBootTest
public class EsTest {


    @Autowired
    ElasticSearchUtils elasticSearchUtils;

    @Test
    void test01(){
        boolean book = elasticSearchUtils.isExistIndex("book");
        System.out.println("book = " + book);

    }

    @Test
    void search(){
        List<LogEntry> logEntries = elasticSearchUtils.searchListData("log-ling-dev-2021.08.09", null, LogEntry.class);
        logEntries.forEach(System.out::println);
    }

    @Data
    static class Book {
        private String name;
        private String author;
    }
}
