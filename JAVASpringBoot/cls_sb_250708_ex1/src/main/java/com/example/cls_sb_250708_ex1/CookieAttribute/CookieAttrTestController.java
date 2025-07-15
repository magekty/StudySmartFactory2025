package com.example.cls_sb_250708_ex1.CookieAttribute;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/CookieAttrTest")
public class CookieAttrTestController {

    @GetMapping("/cookies")
    public String showCookies(HttpServletRequest request, Model model) {
        Cookie[] cookies = request.getCookies();
        return "CookieAttribute/cookieAttr";
    }
}
