// src/main/java/com/yourcompany/appname/controller/UserController.java
package com.loginerp.backendjava.controller;

import com.loginerp.backendjava.dto.UserDto;
import com.loginerp.backendjava.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController // RESTful API 컨트롤러임을 나타냄
@RequestMapping("/api/users") // 기본 URL 경로
@CrossOrigin(origins = "http://localhost:8080/api/users") // CORS 허용 (프론트엔드 URL에 따라 * 대신 특정 URL 지정)
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping // GET /api/users
    public ResponseEntity<List<UserDto>> getAllUsers() {
        List<UserDto> users = userService.getAllUsers();
        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    @PostMapping // POST /api/users
    public ResponseEntity<UserDto> createUser(@RequestBody UserDto userDto) {
        UserDto createdUser = userService.createUser(userDto);
        return new ResponseEntity<>(createdUser, HttpStatus.CREATED); // 201 Created 응답
    }

    @GetMapping("/{id}") // GET /api/users/{id}
    public ResponseEntity<UserDto> getUserById(@PathVariable Integer id) {
        UserDto user = userService.getUserById(id);
        return new ResponseEntity<>(user, HttpStatus.OK);
    }

    // PUT (Update), DELETE 등 다른 API 엔드포인트도 유사하게 구현
}