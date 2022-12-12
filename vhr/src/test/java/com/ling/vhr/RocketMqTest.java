package com.ling.vhr;

import cn.hutool.core.io.IoUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.json.JSONUtil;
import com.ling.vhr.common.roecketmq.MqUtils;
import com.ling.vhr.modules.emp.model.Employee;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

/**
 * @author zhangling
 * @date 2022/8/19 1:40 PM
 */
@Slf4j
public class RocketMqTest extends VhrApplicationTests {

    @Test
    public void normalTest() {
        boolean normal = MqUtils.normal("normal" + RandomUtil.randomNumbers(4), "hello world", "tagC");
        System.out.println("normal = " + normal);
    }

    @Test
    public void normalTest2() {
        Employee employee = new Employee().setName("ling").setAddress("杭州市");
        boolean normal = MqUtils.normal("normal", "employee" + RandomUtil.randomNumbers(4), JSONUtil.toJsonStr(employee), "tagC");
        System.out.println("normal = " + normal);
    }

    @Test
    public void test002(){
        // String urlpath = "http://xz.holytax.com/pdf/d/OWEuiMsVJAauEKjyLBqOKhFmautyM8lQpieMUfOR4jHJAqJ2GPvRnblDWSfQzp72%5EbEifFEcgHg/v2.0";
        // String urlpath = "https://tysl.beijing.chinatax.gov.cn:9443/api?action=getDoc&code=011002100113_03134891_20221205_D8B8H6D3&type=3";
        // String urlpath = "https://srm-prod.oss-cn-hangzhou.aliyuncs.com/EC2103222026O5JQ/INVV_FPKJ22112811582864.ofd?Expires=1678851297&OSSAccessKeyId=LTAI4Fr2FVu7d2ZCrARGtsrf&Signature=G2AvKA4LWyI0dxlYEMZzWII78yY%3D&attname=null";
        String urlpath = "http://srm-prod.oss-cn-hangzhou-internal.aliyuncs.com/EC33G67RI848LE/INVV_FPKJ221208YMUTY80.pdf?Expires=1679105701&OSSAccessKeyId=LTAI4Fr2FVu7d2ZCrARGtsrf&Signature=AZDrA%2FC46OR7IYOyHySAMaZIM6o%3D";
        try {
            InputStream in = new URL(urlpath).openStream();
            byte[] bytes = IoUtil.readBytes(in);
            System.out.println("bytes.length = " + bytes.length);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
