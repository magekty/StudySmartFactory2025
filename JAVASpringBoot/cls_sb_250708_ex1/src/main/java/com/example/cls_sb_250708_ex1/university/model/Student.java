package com.example.cls_sb_250708_ex1.university.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Setter // 자동 세터
@Getter // 자동 게터
@AllArgsConstructor // 모든 아규먼트 생성자
@NoArgsConstructor // 기본 생성자
@Entity
public class Student {
    @Id // 기본키
    @GeneratedValue(strategy = GenerationType.IDENTITY) // 자동증가
    private Long id;
    private String name;

    // 1:1
    @OneToOne(mappedBy = "student", cascade = CascadeType.ALL)
    private StudentCard studentCard;

    // 1:N
    @OneToMany(mappedBy = "student", cascade = CascadeType.ALL)
    private List<Enrollment> enrollments = new ArrayList<>();
}
// Create table student(
// id int auto_increment primary key,
// name varchar(50)
// );
