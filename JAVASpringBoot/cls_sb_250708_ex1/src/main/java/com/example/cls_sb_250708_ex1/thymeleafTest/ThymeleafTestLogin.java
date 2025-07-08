package com.example.cls_sb_250708_ex1.thymeleafTest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ThymeleafTestLogin {
    // 회원 가입 /get - signup (server-user)
    @GetMapping("/signup")
    public String signupform(Model model) {
        model.addAttribute("user", new LoginUser());
        return "ThymeleafTestSignup";
    }

/*    // 회원 가입 내용 전송 /post (user->server)
    @PostMapping("/signup")
    public String signupSubmit(@ModelAttribute LoginUser user) {
        // 여기에서 user 객체를 사용하여 회원 가입 처리 로직을 구현합니다.
        // 예를 들어, 데이터베이스에 저장하거나 다른 서비스 호출
        System.out.println("회원가입 정보:");
        System.out.println("Username: " + user.getUsername());
        System.out.println("Password: " + user.getPassword());
        System.out.println("Gender: " + user.getGender());
        System.out.println("Agree to terms: " + user.getAgree());
        return "ThymeleafTestLoginResult"; // 가입 완료 페이지로 리다이렉트 또는 포워드
    }*/

}
