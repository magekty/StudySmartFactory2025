// src/main/java/com/yourcompany/appname/model/User.java (JPA Entity)
package com.loginerp.backendjava.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data; // Lombok 사용 시

@Entity
@Table(name = "users") // 실제 테이블 이름
@Data // Lombok: getter, setter, toString, equals, hashCode 자동 생성
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // MySQL의 auto_increment
    private Integer userId; // PK
    private String username;
    private String password;
    private String email;
    // 기타 필드
}