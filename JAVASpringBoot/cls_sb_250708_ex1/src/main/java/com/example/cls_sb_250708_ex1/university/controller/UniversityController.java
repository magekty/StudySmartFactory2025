package com.example.cls_sb_250708_ex1.university.controller;

import com.example.cls_sb_250708_ex1.university.model.Course;
import com.example.cls_sb_250708_ex1.university.model.Enrollment;
import com.example.cls_sb_250708_ex1.university.model.Student;
import com.example.cls_sb_250708_ex1.university.service.CourseService;
import com.example.cls_sb_250708_ex1.university.service.EnrollmentService;
import com.example.cls_sb_250708_ex1.university.service.StudentCardService;
import com.example.cls_sb_250708_ex1.university.service.StudentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/univ")
@RequiredArgsConstructor
public class UniversityController {
    private final StudentService studentService;
    private final CourseService courseService;
    private final StudentCardService studentCardService;
    private final EnrollmentService enrollmentService;

    @GetMapping("/students")
    public String students(Model model) {
        model.addAttribute("students", studentService.getAll());
        model.addAttribute("courses", courseService.getAll());
        return "University/students";
    }

    @GetMapping("/students/new")
    public String newStudentForm(Model model) {
        model.addAttribute("student", new Student());
        return "University/student";
    }

    @PostMapping("/students/new")
    public String saveStudent(Student student) {
        studentService.save(student);
        return "redirect:/univ/students";
    }

    @PostMapping("/enroll")
    public String enrollStudent(@RequestParam Long studentId, @RequestParam Long courseId) {
        // 수강신청 시 할일 서비스 등록할 것!!
        enrollmentService.enroll(studentId, courseId);
        return "redirect:/univ/enrollments";
    }

    @PostMapping("/assign-card")
    public String assignCard(@RequestParam Long studentId, @RequestParam String cardNumber) {
        // 카드신청 시 할일 등록할 것!!
        studentCardService.assignCard(studentId, cardNumber);
        return "redirect:/univ/students";
    }

    @GetMapping("/courses")
    public String courses(Model model) {
        model.addAttribute("courses", courseService.getAll());
        return "University/courses";
    }

    @GetMapping("/courses/new")
    public String newCourse(Model model) {
        model.addAttribute("course", new Course());
        return "University/course";
    }

    @PostMapping("/courses/new")
    public String saveCourse(@ModelAttribute Course course) {
        courseService.save(course);
        return "redirect:/univ/courses";
    }

    @GetMapping("/enrollments")
    public String enrollments(Model model) {
        List<Enrollment> list = enrollmentService.getAll();
        model.addAttribute("enrollments", list);
        return "University/enrollments";
    }

    @PostMapping("/enrollments/delete")
    public String deleteEnrollment(@RequestParam Long id) {
        enrollmentService.deleteEnrollment(id);
        return "redirect:/univ/enrollments";
    }
}
