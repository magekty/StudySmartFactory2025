package com.example.cls_sb_250708_ex1.university.service;

import org.springframework.stereotype.Service;


import com.example.cls_sb_250708_ex1.university.model.Student;
import com.example.cls_sb_250708_ex1.university.repository.StudentRepository;
import lombok.RequiredArgsConstructor;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StudentService {
    private final StudentRepository studentRepository;

    public List<Student> getAll() {
        return studentRepository.findAll();
    }

    public Student getOne(Long id) {
        return studentRepository.findById(id).orElseThrow();
    }

    public Student save(Student student) {
        return studentRepository.save(student);
    }

/*    public Student update(Long id, Student student) {
        Student existingStudent = studentRepository.findById(id).orElseThrow();
        existingStudent.setName(student.getName());
        return studentRepository.save(existingStudent);
    }*/

    public void delete(Long id) {
        studentRepository.deleteById(id);
    }

}
