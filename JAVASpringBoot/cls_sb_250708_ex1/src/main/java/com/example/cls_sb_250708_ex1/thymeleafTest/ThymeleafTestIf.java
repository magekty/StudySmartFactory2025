package com.example.cls_sb_250708_ex1.thymeleafTest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ThymeleafTestIf {
    @GetMapping("/testIf")
    public String example(Model model){
        model.addAttribute("isAdmin", true);
        model.addAttribute("username", "김태영");
        return "ThymeleafTestIf";
    }
}
