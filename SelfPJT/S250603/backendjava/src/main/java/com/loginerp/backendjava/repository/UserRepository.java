// src/main/java/com/yourcompany/appname/repository/UserRepository.java
package com.loginerp.backendjava.repository;

import com.loginerp.backendjava.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    // Spring Data JPA가 자동으로 CRUD 메서드 생성 (findById, save, findAll 등)
    // 필요시 사용자 정의 쿼리 메서드 추가 가능
    // Optional<User> findByEmail(String email);
}