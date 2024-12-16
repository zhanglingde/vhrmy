package com.ling.vhr.modules.system.log.service;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.common.utils.ElasticSearchUtils;
import com.ling.vhr.common.utils.PageUtils;
import com.ling.vhr.modules.system.log.domain.dto.LogSearchDto;
import com.ling.vhr.modules.system.log.domain.entity.LogEntry;
import com.ling.vhr.modules.system.log.domain.vo.LogVO;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

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
    public CommonResult<PageUtils<LogVO>> logList(LogSearchDto logSearchDto) {
        String index = "log-ling-dev-";
        String day = Optional.ofNullable(logSearchDto.getDay()).orElse(DateUtil.format(new Date(), "yyyy.MM.dd"));
        index += day;
        if (!elasticSearchUtils.isExistIndex(index)) {
            return CommonResult.error(500, "当前日期没有日志！");
        }
        SearchSourceBuilder search = new SearchSourceBuilder();
        BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
        if (StrUtil.isNotBlank(logSearchDto.getMessage())) {
            boolQueryBuilder.filter(QueryBuilders.matchPhraseQuery("message", logSearchDto.getMessage()));
        }
        if (StrUtil.isNotBlank(logSearchDto.getLevel())) {
            boolQueryBuilder.filter(QueryBuilders.matchQuery("level", logSearchDto.getLevel()));
        }
        if (StrUtil.isNotEmpty(logSearchDto.getStartTime()) && StrUtil.isNotEmpty(logSearchDto.getEndTime())) {
            DateTime startTime = DateUtil.parse(day + logSearchDto.getStartTime(), "yyyy-MM-ddHH:mm:ss");
            DateTime endTime = DateUtil.parse(day + logSearchDto.getEndTime(), "yyyy-MM-ddHH:mm:ss");
            // Date startTime = Date.stringToDate(day + logSearchDto.getStartTime(), "yyyy-MM-ddHH:mm:ss");
            // Date endTime = DateUtils.stringToDate(day + logSearchDto.getEndTime(), "yyyy-MM-ddHH:mm:ss");
            boolQueryBuilder.filter(QueryBuilders.rangeQuery("@timestamp").gte(startTime).lt(endTime));
        }
        search.query(boolQueryBuilder);
        search.size(Optional.ofNullable(logSearchDto.getSize()).orElse(1));
        search.from(Optional.ofNullable(logSearchDto.getPage()).orElse(10));
        search.sort("@timestamp", SortOrder.DESC);

        PageUtils<LogVO> page = elasticSearchUtils.searchPageData(index, search, LogVO.class);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS Z");
        try {
            for (LogVO logVO : page.getList()) {
                logVO.setTimestamp(logVO.getTimestamp().replace("Z", " UTC"));
                // DateUtils.stringToDate(logVO.getTimestamp(),"yyyy-MM-dd'T'HH:mm:ss.SSS Z");
                logVO.setCreateTime(format.parse(logVO.getTimestamp()));
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return CommonResult.success(page);
        //
        // List<LogEntry> list = elasticSearchUtils.searchListData("log-ling-dev-2021.08.10", null, LogEntry.class);
        // return list;
    }
}
