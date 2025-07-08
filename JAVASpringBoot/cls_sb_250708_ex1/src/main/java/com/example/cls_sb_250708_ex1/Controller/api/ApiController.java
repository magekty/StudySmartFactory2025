package com.example.cls_sb_250708_ex1.Controller.api;

// RESTfull API
// : Representaional State Transfer
// HTTP메소드, CRUD(GET, POST, PUT/PATCH, DELETE)

import com.example.cls_sb_250708_ex1.DTO.UserDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api") // localhost:8080/api/hello
public class ApiController {
    @GetMapping("hello")
    public String apiHello(){
        return "api > hello";
    }
    @GetMapping("/greet")   // http://localhost:8080/api/greet?name=김태영 이런식으로 값에 하드코딩
    public String greet(@RequestParam String name){
        return "hello, "+name+"!";
    }
    @GetMapping("/users/{id}")
    public String getUserById(@PathVariable Long id){
        return "User ID: "+id;
    }
    @PostMapping("/users")
    public String createUser(@RequestBody UserDTO user){
        return "Created user: "+ user.getName();
    }
    @PostMapping("users-json")
    public ResponseEntity<UserDTO> createUserJson(@RequestBody UserDTO user){
        return ResponseEntity.status(HttpStatus.CREATED).body(user);
    }

}
