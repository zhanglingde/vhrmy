package com.ling.vhr;

import com.ling.vhr.common.utils.DelayQueueTask;
import com.ling.vhr.common.utils.ElasticSearchUtils;
import com.ling.vhr.esmapper.BookEsMapper;
import com.ling.vhr.esmapper.InvoiceVatEsMapper;
import com.ling.vhr.modules.invoice.InvoiceVat;
import com.ling.vhr.modules.system.log.domain.entity.LogEntry;
import lombok.Data;
import org.dromara.easyes.core.kernel.EsWrappers;
import org.junit.Assert;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

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
    InvoiceVatEsMapper invoiceVatMapper;

    @Autowired
    BookEsMapper bookEsMapper;


    @Test
    public void testCreateIndex() {
        // 测试创建索引,框架会根据实体类及字段上加的自定义注解一键帮您生成索引 需确保索引托管模式处于manual手动挡(默认处于此模式),若为自动挡则会冲突
        boolean success = bookEsMapper.createIndex();
        Assertions.assertTrue(success);
    }

    @Test
    public void testInsert() {
        // 测试插入数据
        com.ling.vhr.modules.invoice.Book book = new com.ling.vhr.modules.invoice.Book();
        book.setName("三国");
        book.setCode("sanguo");
        int successCount = bookEsMapper.insert(book);
        System.out.println(successCount);
    }

    @Test
    public void testSelect(){
        // 测试查询 写法和MP一样 可以用链式,也可以非链式 根据使用习惯灵活选择即可
        String code = "三国";
        com.ling.vhr.modules.invoice.Book document = EsWrappers.lambdaChainQuery(bookEsMapper)
                .eq(com.ling.vhr.modules.invoice.Book::getName, code)
                .one();
        System.out.println(document);
        Assert.assertEquals(code,document.getCode());
    }



    @Test
    public void t004(){
        // 测试查询 写法和MP一样 可以用链式,也可以非链式 根据使用习惯灵活选择即可
        String code = "INVV_2111171AG911TS";
        String invoiceNumber = "12275970";
        InvoiceVat document = EsWrappers.lambdaChainQuery(invoiceVatMapper)
                .eq(InvoiceVat::getInvoiceNumber, invoiceNumber)
                .one();
        System.out.println(document);
        Assert.assertEquals(code,document.getEsCode());
    }

}
