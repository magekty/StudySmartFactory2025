package com.loginerp.backendjava.Jwt.config;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

@Configuration
public class JwtConfig {

    @Value("${jwt.secret}")
    private String secretKey;

    private final Environment env; // Environment 객체 주입을 위한 필드

    // 생성자를 통해 Environment 객체 주입받기
    public JwtConfig(Environment env) {
        this.env = env;
    }

    public String getSecretKey() {
        return secretKey;
    }

    // @PostConstruct 어노테이션으로 빈 초기화 후 실행되는 메서드
    @PostConstruct
    public void checkSecretKey() {
        System.out.println("--- Debugging JWT Secret Key ---");
        System.out.println("1. @Value injected secretKey: " + secretKey); // @Value에 의해 주입된 값
        System.out.println("2. Environment.getProperty(\"jwt.secret\"): " + env.getProperty("jwt.secret")); // Environment 객체에서 직접 가져온 값
        System.out.println("3. System.getenv(\"JWT_SECRET\"): " + System.getenv("JWT_SECRET")); // JVM이 시스템 환경 변수에서 직접 가져온 값
        System.out.println("--------------------------------");
    }
}