package com.example.cls_sb_250708_ex1.LoginSessionSimpleDB.repository;

import com.example.cls_sb_250708_ex1.LoginSessionSimpleDB.model.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
    Optional<UserEntity> findByUsername(String username);

    boolean existsByUsername(String username);
}
