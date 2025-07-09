package com.example.cls_sb_250708_ex1.thymeleafTest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ThymeleafTestLogin {
    // 회원 가입 /get - signup (server-user)
    @GetMapping("/signup")
    public String signupform(Model model) {
        model.addAttribute("loginUser", new LoginUser());
        return "Login/signup";
    }


    // 회원 가입 내용 전송 /post (user->server)
    @PostMapping("/signup")
    public String signupSubmit(@ModelAttribute LoginUser user, Model model) {
        if (!user.getAgree()) {
            model.addAttribute("error", "약관에 동의하세요");
            return "Login/signup";
        }
        model.addAttribute("user", user);
        return "Login/welcome";
    }

    @GetMapping("/login")
    public String loginForm() {
        return "Login/login";
    }

    @PostMapping("/login")
    public String loginSubmit(@RequestParam String username,
                              @RequestParam String password,
                              Model model) {
        // 나중에는 ID:user1, PW:1234를 DB(MySQL)연동해서 검증
        if ("user1".equals(username) && "1234".equals(password)) {
            model.addAttribute("username", username);
            return "Login/welcome";
        } else {
            model.addAttribute("error", "로그인 정보를 잘못 입력했네요");
            return "Login/login";
        }
    }


}
