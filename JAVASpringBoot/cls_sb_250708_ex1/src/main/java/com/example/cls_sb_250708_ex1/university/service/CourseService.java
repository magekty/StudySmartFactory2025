package com.example.cls_sb_250708_ex1.university.service;

import com.example.cls_sb_250708_ex1.university.model.Course;
import com.example.cls_sb_250708_ex1.university.repository.CourseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CourseService {
    private final CourseRepository courseRepository;

    public List<Course> getAll() {
        return courseRepository.findAll();
    }

    public Course getOne(Long id) {
        return courseRepository.findById(id).orElseThrow();
    }

    public Course save(Course course) {
        return courseRepository.save(course);
    }

/*    public Course update(Long id, Course course) {
        Course existingCourse = courseRepository.findById(id).orElseThrow();
        existingCourse.setTitle(course.getTitle());
        return courseRepository.save(existingCourse);
    }*/

    public void delete(Long id) {
        courseRepository.deleteById(id);
    }
}
