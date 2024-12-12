package com.ling.vhr;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.json.JSONUtil;
import com.ling.vhr.common.roecketmq.MqUtils;
import com.ling.vhr.common.utils.MapstructUtils;
import com.ling.vhr.modules.emp.model.Employee;
import com.ling.vhr.modules.system.lov.domain.dto.LovValueDTO;
import com.ling.vhr.modules.system.lov.domain.vo.LovValueVO;
import io.github.linpeilie.Converter;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;

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



    private static Converter converter = new Converter();

    public static void main(String[] args) {
        LovValueDTO lovValueDTO = LovValueDTO.builder()
                .lovId(1)
                .lovCode("TEST")
                .value("测试值集")
                .lovValueId(2)
                .desc("描述")
                .build();
        // LovValueVO convert = converter.convert(lovValueDTO, LovValueVO.class);
        LovValueVO convert = MapstructUtils.convert(lovValueDTO, LovValueVO.class);
        System.out.println(convert);
        // LovValueDTO dto = converter.convert(convert, LovValueDTO.class);
        // System.out.println(dto);
    }

    @Test
    public void test003() {
        LovValueDTO lovValueDTO = LovValueDTO.builder()
                .lovId(1)
                .lovCode("TEST")
                .value("测试值集")
                .lovValueId(2)
                .desc("描述")
                .build();
        // LovValueVO convert = converter.convert(lovValueDTO, LovValueVO.class);
        LovValueVO convert = MapstructUtils.convert(lovValueDTO, LovValueVO.class);
        System.out.println(convert);
        // LovValueDTO dto = converter.convert(convert, LovValueDTO.class);
        // System.out.println(dto);
    }

}
