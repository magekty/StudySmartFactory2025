package com.example.cls_sb_250708_ex1.university.controller;

import com.example.cls_sb_250708_ex1.university.service.StudentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/univ")
@RequiredArgsConstructor
public class UniversityController {
    private final StudentService studentService;

    @GetMapping("/students")
    public String students(Model model) {
        model.addAttribute("students", studentService.getAll());
        return "University/students";
    }
}
