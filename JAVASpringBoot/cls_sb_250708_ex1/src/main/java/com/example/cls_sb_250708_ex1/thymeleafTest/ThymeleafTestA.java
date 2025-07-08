package com.example.cls_sb_250708_ex1.thymeleafTest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ThymeleafTestA {
    // testA.html 연결
    // url: /testA
    // return: testA.html
    // data: 없음
    @GetMapping("/testLink")
    public String testLink(Model model){
        model.addAttribute("userId",1);
        model.addAttribute("query","springboot");
        return "ThymeleafTestLink";
    }

}
