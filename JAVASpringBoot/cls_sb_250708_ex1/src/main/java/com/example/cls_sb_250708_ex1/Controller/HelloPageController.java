package com.example.cls_sb_250708_ex1.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloPageController {
    @GetMapping("/hello-page")
    public String helloPage(Model model){
        model.addAttribute("name","김태영");
        return "hello";
    }
}
