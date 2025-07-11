package com.example.cls_sb_250708_ex1.university.repository;

import com.example.cls_sb_250708_ex1.university.model.StudentCard;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentCardRepository extends JpaRepository<StudentCard, Long> {
}
