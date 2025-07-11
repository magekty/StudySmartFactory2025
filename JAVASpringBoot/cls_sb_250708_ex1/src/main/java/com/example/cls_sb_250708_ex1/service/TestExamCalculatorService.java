package com.example.cls_sb_250708_ex1.service;

import org.springframework.stereotype.Service;

@Service
public class TestExamCalculatorService {
    public int add(int a, int b) {
        return a + b;
    }

    public int subtract(int a, int b) {
        return a - b;
    }
}
