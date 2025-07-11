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
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(length = 50)
    private String title;

    // N:M -> Enrollment
    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL)
    private List<Enrollment> enrollments = new ArrayList<>();
}
// create table course(
// id int auto_increment primary key,
// title varchar(50)
// );
