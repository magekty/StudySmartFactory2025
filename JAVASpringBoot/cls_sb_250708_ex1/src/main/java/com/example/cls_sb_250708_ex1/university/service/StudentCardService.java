package com.example.cls_sb_250708_ex1.university.service;

import com.example.cls_sb_250708_ex1.university.model.Student;
import com.example.cls_sb_250708_ex1.university.model.StudentCard;
import com.example.cls_sb_250708_ex1.university.repository.StudentCardRepository;
import com.example.cls_sb_250708_ex1.university.repository.StudentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class StudentCardService {
    private final StudentRepository studentRepository;
    private final StudentCardRepository studentCardRepository;

    public StudentCard assignCard(Long StudentId, String cardNumber) {
        Student student = studentRepository.findById(StudentId).orElseThrow();
        StudentCard card = new StudentCard();
        card.setStudent(student);
        card.setCardNumber(cardNumber);
        return studentCardRepository.save(card);
    }
}
