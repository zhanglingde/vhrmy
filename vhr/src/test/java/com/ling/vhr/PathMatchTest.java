package com.ling.vhr;

import cn.hutool.core.util.StrUtil;
import cn.hutool.http.Header;
import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import org.junit.jupiter.api.Test;
import org.springframework.util.AntPathMatcher;

/**
 * @author zhangling  2021/12/5 16:16
 */
public class PathMatchTest {

    AntPathMatcher pathMatcher = new AntPathMatcher();

    @Test
    public void test() {
        // String url = "/api/business/{roleId}/list";
        String url = "/api/business/list";
        boolean exist = StrUtil.contains(url, "{");
        System.out.println("exist = " + exist);

    }

    @Test
    public void test02(){
        String url = "https://www.fastmock.site/mock/f120cef92afc0306cd1680a89a3c14c0/ar/call/back";
        String result2 = HttpRequest.post(url)
                .contentType("application/json")
                .contentLength(0)
                .timeout(20000)
                .execute().body();

        HttpResponse execute = HttpRequest.get(url)
                .header(Header.CONTENT_TYPE,"application/json;charset=UTF-8")
                .timeout(20000)
                .execute();
        int status = execute.getStatus();
        String body = execute.body();
        System.out.println();
    }

}
