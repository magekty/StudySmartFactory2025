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
public class StudentCard {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true, length = 50)
    private String cardNumber;

    // 1:1
    @OneToOne
    @JoinColumn(name = "student_id")
    private Student student;
}
// create table student_card(
// id int auto_increment primary key,
// card_number varchar(50),
// student_id int unique,
// foreign key(student_id) references student(id)
// );
