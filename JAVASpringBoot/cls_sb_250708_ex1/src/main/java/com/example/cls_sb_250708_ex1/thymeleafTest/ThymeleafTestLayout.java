package com.example.cls_sb_250708_ex1.thymeleafTest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ThymeleafTestLayout {
    @GetMapping("/layout/home")
    public String home() {
        return "Layout/home";
    }

    @GetMapping("/layout/about")
    public String about() {
        return "Layout/about";
    }
}
