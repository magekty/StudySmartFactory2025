package com.example.cls_sb_250708_ex1.model;

// JPA(Java Persistence API) 자바 저장소 API
// Java진영에서 사용하는 ORM(Object Relational Mapping)
// SQL (x) - java (o) : 언어 편의성 => erd(x) -> class
// DB:H2, sqlite, MySql, PostgreSql, Oracle
// JPA 구현: Hibernate, OpenJPA, ...

//build.gradle 파일 - 공통 세팅
//dependencies{
//        implementation'org.springframework.boot:spring-boot-starter-data-jpa'
//        runtimeOnly'com.h2database:h2'
//
//        runtimeOnly 'com.mysql:mysql-connector-java'
//        }
//application.properties 파일 - 공통 세팅
//# JPA, DB, console, sqlAutoUpdate Settings
//spring.datasource.url=jdbc:h2:mem:testdb
//spring.datasource.driver-class-name=org.h2.Driver
//spring.datasource.username=root
//spring.datasource.password=1121
//spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
//spring.h2.console.enabled=true
//spring.jpa.hibernate.ddl-auto=update
// 주소
//http://localhost:8080/h2-console

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter // 자동 세터
@Getter // 자동 게터
@AllArgsConstructor // 모든 아규먼트 생성자
@NoArgsConstructor // 기본 생성자
@Entity // 엔티티 클래스
public class TodoJpa {
    @Id // 기본키
    @GeneratedValue(strategy = GenerationType.IDENTITY) // 자동증가
    private Long id;
    @NotBlank(message = "title은 비워지면 안 되요")
    @Size(max = 50, message = "최대50자까지 가능해요")
    private String title;
    private boolean done;
}
