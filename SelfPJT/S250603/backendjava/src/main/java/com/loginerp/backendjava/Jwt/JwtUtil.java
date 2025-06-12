package com.loginerp.backendjava.Jwt;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
@Component
public class JwtUtil {
/*    private final String SECRET_KEY = Base64.getEncoder().encodeToString(
            "xodud-whsskqhrwkqgkstbvjtlzmfltzl-2025!-dlrjs-Rhr-go-dlqordhtlqdbrqlxmfh-rlfrp!".getBytes());*/
//    private final long EXPIRATION_TIME = 1000 * 60 * 60; // 1시간

    //private final Key key = Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
    private final SecretKey secretKey;
    private final long validityInMilliseconds;

    // application.properties 또는 환경 변수에서 "jwt.secret" 값을 직접 주입받습니다.
    // Base64 인코딩은 이 단계에서 하지 않고, 서명 키를 생성할 때 처리합니다.
    @Value("${jwt.secret}")
    private String rawSecretString; // 주입받을 원본 비밀 키 문자열

    // 생성자에서 주입받은 rawSecretString을 사용하여 SecretKey를 초기화합니다.
    @Autowired // Spring 4.3 이후로는 단일 생성자라면 @Autowired 생략 가능
    public JwtUtil(@Value("${jwt.secret}") String rawSecretString) { // @Value를 생성자 매개변수에 바로 적용
        this.rawSecretString = rawSecretString;

        // Base64 인코딩된 문자열을 원한다면:
        // String encodedSecret = Base64.getEncoder().encodeToString(rawSecretString.getBytes(StandardCharsets.UTF_8));
        // this.secretKey = Keys.hmacShaKeyFor(encodedSecret.getBytes(StandardCharsets.UTF_8));

        // 일반적으로 JWT 시크릿 키는 raw bytes로 사용하는 것이 일반적입니다.
        // Base64.getEncoder().encodeToString()으로 한 번 더 인코딩할 필요는 없습니다.
        // 만약 키 자체가 Base64 인코딩되어 환경 변수에 저장되어 있다면 decode 해야 할 수도 있습니다.
        // 여기서는 rawSecretString이 직접 키 값이라고 가정합니다.
        this.secretKey = Keys.hmacShaKeyFor(rawSecretString.getBytes(StandardCharsets.UTF_8));
        this.validityInMilliseconds = 3600000; // 1시간 (밀리초)
    }
    public String generateToken(String username) {
        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + validityInMilliseconds))
                .signWith(secretKey, SignatureAlgorithm.HS256)
                .compact();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder().setSigningKey(secretKey).build().parseClaimsJws(token);
            return true;
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }

    public String getUsernameFromToken(String token) {
        return Jwts.parserBuilder().setSigningKey(secretKey).build()
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }
}