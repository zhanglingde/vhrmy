package com.ling.vhr.mockito.lesson04;

/**
 * @author zhangling
 * @date 2022/1/10 11:01 上午
 */
public class StubbingService {

    public int getI() {
        System.out.println("================getI");
        return 10;
    }

    public String getS() {
        System.out.println("================getS");
        throw new RuntimeException();
    }
}
