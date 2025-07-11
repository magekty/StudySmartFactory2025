package com.example.cls_sb_250708_ex1.university.service;

import com.example.cls_sb_250708_ex1.university.model.Course;
import com.example.cls_sb_250708_ex1.university.model.Enrollment;
import com.example.cls_sb_250708_ex1.university.model.Student;
import com.example.cls_sb_250708_ex1.university.repository.CourseRepository;
import com.example.cls_sb_250708_ex1.university.repository.EnrollmentRepository;
import com.example.cls_sb_250708_ex1.university.repository.StudentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EnrollmentService {
    private final StudentRepository studentRepository;
    private final CourseRepository courseRepository;
    private final EnrollmentRepository enrollmentRepository;

    public Enrollment enroll(Long studentId, Long courseId) {
        Student student = studentRepository.findById(studentId).orElseThrow();
        Course course = courseRepository.findById(courseId).orElseThrow();
        Enrollment enrollment = new Enrollment();
        enrollment.setStudent(student);
        enrollment.setCourse(course);
        return enrollmentRepository.save(enrollment);
    }

}
