package com.example.cls_sb_250708_ex1.LoginSessionSimpleDB.controller;

import com.example.cls_sb_250708_ex1.LoginSessionSimpleDB.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@RequiredArgsConstructor
@Controller
@RequestMapping("/LoginSessionSimpleDB")
public class LoginController {
    private final UserService userService;

    @GetMapping("/")
    public String home(Model model, Principal principal) {
        model.addAttribute("username", principal.getName());
        return "LoginSessionSimpleDB/home";
    }

    @GetMapping("/login")
    public String login() {
        return "LoginSessionSimpleDB/login";
    }

    @GetMapping("/register")
    public String registerForm() {
        return "LoginSessionSimpleDB/register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String password,
                           Model model) {
        boolean success = userService.register(username, password);
        if (success) {
            return "redirect:/LoginSessionSimpleDB/login?registered";
        } else {
            model.addAttribute("error", "이미 존재하는 사용자");
            return "LoginSessionSimpleDB/register";
        }
    }
}
