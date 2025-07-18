package com.example.cls_sb_250708_ex1.CookieRoleAndPath;


import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/CookieRoleAndPath")
public class CookieScopeController {
    @GetMapping("/set")
    public String setCookies(HttpServletResponse response) {
        Cookie siteCookie = new Cookie("site_mode", "light");
        siteCookie.setPath("/CookieRoleAndPath");
        siteCookie.setMaxAge(60 * 60);
        response.addCookie(siteCookie);

        Cookie adminCookie = new Cookie("admin_token", "admin~~123!");
        adminCookie.setPath("/CookieRoleAndPath/admin");
        adminCookie.setMaxAge(60 * 60);
        response.addCookie(adminCookie);

        Cookie userCookie = new Cookie("user_lang", "korean");
        userCookie.setPath("/CookieRoleAndPath/user");
        userCookie.setMaxAge(60 * 60);
        response.addCookie(userCookie);

        return "CookieRoleAndPath/set_success";
    }


}
