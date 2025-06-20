// src/main/java/com/yourcompany/appname/service/UserService.java
package com.loginerp.backendjava.service;

import com.loginerp.backendjava.dto.UserDto;
import com.loginerp.backendjava.model.User;
import com.loginerp.backendjava.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.modelmapper.ModelMapper; // DTO <-> Entity 매핑 라이브러리 (선택 사항)

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService {


    private UserRepository userRepository;

    @Autowired // ModelMapper 빈을 주입받음 (설정 필요)
    private ModelMapper modelMapper;

    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository,
                       PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public User authenticate(String username, String rawPassword) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        if (!passwordEncoder.matches(rawPassword, user.getPassword())) {
            throw new BadCredentialsException("Invalid password");
        }

        return user;
    }

    public List<UserDto> getAllUsers() {
        return userRepository.findAll().stream()
                .map(user -> modelMapper.map(user, UserDto.class))
                .collect(Collectors.toList());
    }

    public UserDto createUser(UserDto userDto) {
        // DTO를 Entity로 변환
        User user = modelMapper.map(userDto, User.class);

        // 비밀번호 암호화
        String encodedPassword = passwordEncoder.encode(userDto.getPassword());
        user.setPassword(encodedPassword);
        
        User savedUser = userRepository.save(user);
        // 저장된 Entity를 다시 DTO로 변환하여 반환
        return modelMapper.map(savedUser, UserDto.class);
    }

    public UserDto getUserById(Integer userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));
        return modelMapper.map(user, UserDto.class);
    }

    // 기타 update, delete 등 메서드
}