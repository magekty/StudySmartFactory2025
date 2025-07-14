package com.example.cls_sb_250708_ex1.LoginCookie;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthService {
    private final LoginCookieUser user =
            new LoginCookieUser("root", "1234");

    public boolean login(String username, String password) {
        boolean condition1 = user.getUsername().equals(username);
        boolean condition2 = user.getPassword().equals(password);
        log.info("username:" + username);
        return condition1 && condition2;
    }
}
