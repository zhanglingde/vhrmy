package com.ling.vhr.common.utils;

import org.springframework.util.DigestUtils;

/**
 * @author zhangling  2022/1/25 21:06
 */
public class Md5Util {

    public static void md5() {
        String sourceString = "zhangling";
        String s = DigestUtils.md5DigestAsHex(sourceString.getBytes());

        System.out.println("第一次加密值 = " + s);
        s = DigestUtils.md5DigestAsHex(sourceString.getBytes());
        System.out.println("第二次加密值 = " + s);
    }

    public static void main(String[] args) {
        md5();
    }
}
