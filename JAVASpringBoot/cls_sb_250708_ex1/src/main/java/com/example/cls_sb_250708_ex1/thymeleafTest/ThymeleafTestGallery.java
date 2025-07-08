package com.example.cls_sb_250708_ex1.thymeleafTest;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class ThymeleafTestGallery {
    @GetMapping("/testGallery")
    public String example(Model model) {
        List<String> imageList = List.of(
                "국밥.jpg", "치킨.jpg", "피자.jpg", "햄버거.jpg"
        );
        model.addAttribute("images", imageList);
        return "ThymeleafTestGallery";
    }
}

