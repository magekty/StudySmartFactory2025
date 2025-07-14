package com.example.cls_sb_250708_ex1.LoginCookie;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequiredArgsConstructor
@RequestMapping("/cookie-login-test")
@Controller
public class LoginCookieAuthController {
    private final AuthService authService;

    @GetMapping("/")
    public String homePage(HttpServletRequest request, Model model) {
        Cookie[] cookies = request.getCookies();
        boolean loggedIn = false;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                boolean condition1 = cookie.getName().equals("login");
                boolean condition2 = cookie.getValue().equals("true");
                if (condition1 && condition2) {
                    loggedIn = true;
                    break;
                }
            }
        }

        model.addAttribute("loggedIn", loggedIn);
        return "LoginCookie/home";
    }

    @GetMapping("/logout")
    public String logout(HttpServletResponse response) {
        Cookie cookie = new Cookie("login", null);
        cookie.setMaxAge(0); // 쿠키는 삭제 보다 만료
        cookie.setPath("/"); // 쿠키의 유효 경로를 루트로 설정
        response.addCookie(cookie);
        return "redirect:/cookie-login-test/";
    }

    @GetMapping("/login")
    public String loginForm() {
        return "LoginCookie/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password,
                        Model model, HttpServletResponse response) {

        if (authService.login(username, password)) {
            Cookie cookie = new Cookie("login", "true");
            cookie.setMaxAge(60 * 60); // 60초*60 => 1시간
            cookie.setPath("/"); // 쿠키의 유효 경로를 루트로 설정
            response.addCookie(cookie);
            return "redirect:/cookie-login-test/";
        } else {
            model.addAttribute("error", "id 또는 pw가 잘 못 되었어요");
            return "LoginCookie/login";
        }
//        return "redirect:/";
    }

}
