package com.example.cls_sb_250708_ex1.university.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter // 자동 세터
@Getter // 자동 게터
@AllArgsConstructor // 모든 아규먼트 생성자
@NoArgsConstructor // 기본 생성자
@Entity
public class Enrollment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    // ManyToOne -> Student
    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;

    // ManyToOne -> Course
    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
}
// create table enrollment(
// id int auto_increment primary key,
// student_id int,
// course_id int,
// foreign key(student_id) references student(id)
// foreign key(course_id) references course(id)
// );
