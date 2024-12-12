package com.ling.vhr.lov;

import com.ling.vhr.modules.system.lov.service.LovValueService;
import com.ling.vhr.modules.system.lov.domain.vo.LovValueVO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

/**
 * @author zhangling
 * @date 2021/12/20 11:56 上午
 */
@SpringBootTest
public class LovValueTest {

    @Autowired
    LovValueService lovValueService;

    @Test
    public void lovValue(){
        String lovCode = "STUDY_TYPE";
        List<LovValueVO> lovValueVOS = lovValueService.queryLovValue(lovCode);
        System.out.println("lovValueVOS = " + lovValueVOS);
    }
}
