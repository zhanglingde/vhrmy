package com.ling.vhr.modules.system.log.service;

import com.ling.vhr.common.utils.ElasticSearchUtils;
import com.ling.vhr.modules.system.log.model.LogEntry;
import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author zhangling  2021/8/10 11:01
 */
@Service
public class LogService {

    @Autowired
    ElasticSearchUtils elasticSearchUtils;

    /**
     * 日志列表
     * @return
     */
    public List<LogEntry> logList() {
        List<LogEntry> list = elasticSearchUtils.searchListData("log-ling-dev-2021.08.10", null, LogEntry.class);
        return list;
    }
}
