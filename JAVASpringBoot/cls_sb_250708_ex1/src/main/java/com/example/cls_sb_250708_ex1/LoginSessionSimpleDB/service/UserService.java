package com.example.cls_sb_250708_ex1.LoginSessionSimpleDB.service;

import com.example.cls_sb_250708_ex1.LoginSessionSimpleDB.model.UserEntity;
import com.example.cls_sb_250708_ex1.LoginSessionSimpleDB.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class UserService implements UserDetailsService {
    private final UserRepository userRepository;
    private final PasswordEncoder encoder;

    // login
    @Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {
        UserEntity user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(
                        "사용자 " + username + " 없음"));
        return User.builder().username(user.getUsername())
                .password(user.getPassword()).roles(user.getRole())
                .disabled(!user.isEnabled()).build();
    }

    // register
    public boolean register(String username, String rawPassword) {
        if (userRepository.existsByUsername(username)) return false;

        UserEntity user = new UserEntity();
        user.setUsername(username);
        user.setPassword(encoder.encode(rawPassword));
        user.setEnabled(true);
        user.setRole("USER");
        userRepository.save(user);
        return true;
    }
}
