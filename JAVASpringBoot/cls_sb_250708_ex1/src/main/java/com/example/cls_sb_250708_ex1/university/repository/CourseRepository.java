package com.example.cls_sb_250708_ex1.university.repository;

import com.example.cls_sb_250708_ex1.university.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CourseRepository extends JpaRepository<Course, Long> {
}
