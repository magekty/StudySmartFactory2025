package com.example.sf_system_0001_simple_react_sb.repository;

import com.example.sf_system_0001_simple_react_sb.entity.UserJwtEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserJwtRepository extends JpaRepository<UserJwtEntity, Long> {
    UserJwtEntity findByUsername(String username);
    boolean existsByUsername(String username);

}
