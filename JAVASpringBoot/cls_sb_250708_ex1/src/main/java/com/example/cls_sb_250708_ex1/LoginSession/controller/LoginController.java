package com.example.cls_sb_250708_ex1.LoginSession.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@RequestMapping("/LoginSession")
//@Controller
public class LoginController {
    @GetMapping("/")
    public String home(Model model, Principal principal) {
        model.addAttribute("username",
                principal.getName());
        return "LoginSession/home";
    }

    @GetMapping("/login")
    public String login() {
        return "LoginSession/login";
    }
}
