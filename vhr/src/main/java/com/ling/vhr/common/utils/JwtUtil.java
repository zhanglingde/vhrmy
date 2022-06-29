package com.ling.vhr.common.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * @author zhangling  2022/1/25 19:45
 */
public class JwtUtil {

    private static final String secret = "zhangling";

    /**
     * 生成 token
     *
     * @param subject
     * @return
     */
    public static String createToken(String subject) {
        String token = Jwts.builder().setSubject(subject)
                // 设置过期时间
                .setExpiration(new Date(new Date().getTime() + 1000 * 3))
                .signWith(SignatureAlgorithm.HS256, secret)
                .compact();
        return token;
    }

    /**
     * 解析 token
     *
     * @param token
     * @return
     */
    public static String parseToken(String token) {
        Claims body = Jwts.parser().setSigningKey(secret).parseClaimsJws(token).getBody();
        String subject = body.getSubject();
        return subject;
    }

    public static void main(String[] args) throws InterruptedException {
        String name = "ling";
        String token = createToken(name);
        System.out.println("token = " + token);

        String subject = parseToken(token);
        System.out.println("subject = " + subject);

        TimeUnit.SECONDS.sleep(4);

        subject = parseToken(token);
        System.out.println("subject = " + subject);
    }
}
