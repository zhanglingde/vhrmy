package com.ling.vhr.common.interceptor;

import cn.hutool.json.JSONUtil;
import com.alibaba.fastjson.JSONObject;
import com.ling.vhr.common.annotation.RepeatSubmit;
import com.ling.vhr.common.utils.RedisUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.digest.Md5Crypt;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

/**
 * 防止重复提交拦截器
 */
@Slf4j
@Component
public class RepeatSubmitInterceptor implements HandlerInterceptor {

    public final String REPEAT_PARAMS = "repeatParams";

    public final String REPEAT_TIME = "repeatTime";

    public static final String HEADER = "tokenid";

    @Autowired
    RedisUtils redisUtils;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (handler instanceof HandlerMethod) {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            Method method = handlerMethod.getMethod();
            RepeatSubmit repeatSubmit = method.getAnnotation(RepeatSubmit.class);
            if (repeatSubmit != null) {
                if (this.isRepeatSubmit(request, repeatSubmit)) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("success", false);
                    map.put("messageCode", 500);
                    map.put("message", repeatSubmit.message());
                    response.setContentType("application/json;charset=utf-8");
                    response.getWriter().write(JSONUtil.toJsonStr(map));
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * 判断是否重复提交，返回 true 表示是重复提交
     *
     * @param request
     * @return
     * @throws Exception
     */
    private boolean isRepeatSubmit(HttpServletRequest request, RepeatSubmit repeatSubmit) {
        // 1. 获取请求中当前参数
        String nowParams = "";
        // application/json 参数是 json
        if (request instanceof RepeatedlyRequestWrapper) {
            nowParams = getBodyString(request);
        }

        // body参数为空，获取Parameter的数据
        if (StringUtils.isEmpty(nowParams)) {
            nowParams = JSONUtil.toJsonStr(request.getParameterMap());
        }
        Map<String, Object> nowDataMap = new HashMap<>();
        nowDataMap.put(REPEAT_PARAMS, Md5Crypt.apr1Crypt(nowParams));
        nowDataMap.put(REPEAT_TIME, System.currentTimeMillis());

        // 请求地址
        String url = request.getRequestURI();

        // 用户标识唯一值
        String header = request.getHeader(HEADER);

        // 唯一标识（指定key + url + 消息头）
        String key = "REPEAT_SUBMIT_KEY:" + url + ":" + header;

        // 2. 获取请求缓存，存在可能是重复提交
        String valueObject = redisUtils.get(key);
        if (valueObject != null) {
            Map<String, Object> valueMap = JSONObject.parseObject(valueObject);
            if (valueMap.containsKey(REPEAT_PARAMS)) {
                // 3. 判断请求参数是否相同 和 请求时间是否在时间间隔内
                if (compareParams(nowDataMap, valueMap) && compareTime(nowDataMap, valueMap, repeatSubmit.interval())) {
                    return true;
                }
            }
        }
        redisUtils.set(key, nowDataMap, repeatSubmit.interval());
        return false;
    }

    /**
     * 判断参数是否相同
     */
    private boolean compareParams(Map<String, Object> nowMap, Map<String, Object> preMap) {
        String nowParams = (String) nowMap.get(REPEAT_PARAMS);
        String preParams = (String) preMap.get(REPEAT_PARAMS);
        return nowParams.equals(preParams);
    }

    /**
     * 判断两次间隔时间
     */
    private boolean compareTime(Map<String, Object> nowMap, Map<String, Object> preMap, int interval) {
        long time1 = (Long) nowMap.get(REPEAT_TIME);
        long time2 = (Long) preMap.get(REPEAT_TIME);
        return (time1 - time2) < interval;
    }

    private String getBodyString(ServletRequest request) {
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = null;
        try (InputStream inputStream = request.getInputStream()) {
            reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8));
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (IOException e) {
            log.warn("getBodyString出现问题！");
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    log.error(e.getMessage(), e);
                }
            }
        }
        return sb.toString();
    }
}
