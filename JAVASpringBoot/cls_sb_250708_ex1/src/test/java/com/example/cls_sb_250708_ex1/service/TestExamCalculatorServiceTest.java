package com.example.cls_sb_250708_ex1.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class TestExamCalculatorServiceTest {
    @Autowired
    private TestExamCalculatorService testExamCalculatorService;

    @Test
    void testAdd() {
        int result = testExamCalculatorService.add(2, 3);
        assertThat(result).isEqualTo(5);
    }

    @Test
    void testSubtract() {
        int result = testExamCalculatorService.subtract(10, 3);
        assertThat(result).isEqualTo(7);
    }

}
