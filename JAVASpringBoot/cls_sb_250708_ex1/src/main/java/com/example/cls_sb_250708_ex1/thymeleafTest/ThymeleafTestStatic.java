package com.example.cls_sb_250708_ex1.thymeleafTest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ThymeleafTestStatic {
    @GetMapping("/testStatic")
    public String exampleSwitch(Model model) {
        return "ThymeleafTestStatic";
    }
}