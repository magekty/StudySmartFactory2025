package com.example.cls_sb_250708_ex1.repository;

import com.example.cls_sb_250708_ex1.model.TodoJpa;
import org.springframework.data.jpa.repository.JpaRepository;

//@Repository
public interface TodoJpaRepository extends JpaRepository<TodoJpa, Long> {

}
