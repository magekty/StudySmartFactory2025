package com.example.sf_system_0001_simple_react_sb.service;

import com.example.sf_system_0001_simple_react_sb.repository.UserJwtRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@AllArgsConstructor
@Service
public class UserJwtService {
    private final UserJwtRepository userJwtRepository;
    private final BCryptPasswordEncoder encoder;
}
