package com.example.cls_sb_250708_ex1.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController // 어노테이션
public class HelloRestController {
    @GetMapping("/hello")
    public String hello(){
        return "<h1>hello 응답됬어</h1>";
    }
}
