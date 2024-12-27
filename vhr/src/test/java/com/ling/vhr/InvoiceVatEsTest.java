package com.ling.vhr;

import com.ling.vhr.common.utils.DelayQueueTask;
import com.ling.vhr.common.utils.ElasticSearchUtils;
import com.ling.vhr.common.utils.JsonUtils;
import com.ling.vhr.esmapper.BookEsMapper;
import com.ling.vhr.esmapper.InvoiceVatEsMapper;
import com.ling.vhr.modules.invoice.InvoiceVat;
import com.ling.vhr.modules.system.log.domain.entity.LogEntry;
import lombok.Data;
import org.dromara.easyes.core.kernel.EsWrappers;
import org.elasticsearch.index.query.*;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.junit.Assert;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

/**
 * @author zhangling  2021/8/9 14:56
 */
@SpringBootTest
public class InvoiceVatEsTest {


    @Autowired
    InvoiceVatEsMapper invoiceVatMapper;
    @Autowired
    ElasticSearchUtils elasticSearchUtils;


    @Test
    public void testCreateIndex() {
        // 测试创建索引,框架会根据实体类及字段上加的自定义注解一键帮您生成索引 需确保索引托管模式处于manual手动挡(默认处于此模式),若为自动挡则会冲突
        boolean success = invoiceVatMapper.createIndex();
        Assertions.assertTrue(success);
    }

    @Test
    public void testInvoiceVatInsert() {
        // 测试插入数据
        InvoiceVat invoiceVat = new InvoiceVat();
        invoiceVat.setEsCode("INVV_2111171AG911TS002");
        invoiceVat.setInvoiceNumber("202412270001");
        int successCount = invoiceVatMapper.insert(invoiceVat);
        System.out.println(successCount);
    }

    @Test
    public void easyEsInvoiceVatSearch(){
        // INVV_19tqjlqtnh0
        // 测试查询 写法和MP一样 可以用链式,也可以非链式 根据使用习惯灵活选择即可
        InvoiceVat document = EsWrappers.lambdaChainQuery(invoiceVatMapper)
                .match(InvoiceVat::getEsCode, "INVV_19tqjlqtnh0")
                .one();
        System.out.println(document);
        // Assert.assertEquals(code,document.getEsCode());
    }

    @Test
    public void clientSearch(){
        SearchSourceBuilder search = new SearchSourceBuilder();
        // QueryBuilder queryBuilder = new QueryBuilder();
        BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
        List<QueryBuilder> queryBuilderList = new ArrayList<>();


        QueryBuilder termQueryBuilder = QueryBuilders.termQuery("invoice_number", "24318781111000000000");
        queryBuilderList.add(termQueryBuilder);
        boolQueryBuilder.must().addAll(queryBuilderList);
        search.query(boolQueryBuilder);
        List<InvoiceVat> invoiceVat = elasticSearchUtils.searchListData("invoice_vat", search, InvoiceVat.class);
        System.out.println(JsonUtils.toJsonString(invoiceVat));
    }




}
