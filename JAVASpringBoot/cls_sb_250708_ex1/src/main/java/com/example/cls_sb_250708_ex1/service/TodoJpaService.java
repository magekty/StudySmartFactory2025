package com.example.cls_sb_250708_ex1.service;

import com.example.cls_sb_250708_ex1.model.TodoJpa;
import com.example.cls_sb_250708_ex1.repository.TodoJpaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TodoJpaService {
    private final TodoJpaRepository todoJpaRepository;

    public List<TodoJpa> getAll() {
        // select * from ~~;
        return todoJpaRepository.findAll();
    }

    public TodoJpa add(String title) {
        TodoJpa todoJpa = new TodoJpa();
        todoJpa.setTitle(title);
        todoJpa.setDone(false);
        // insert into
        return todoJpaRepository.save(todoJpa);
    }

    public TodoJpa findById(Long id) {
        // select * from TodoJpa where id = this.id;
        return todoJpaRepository.
                findById(id).orElseThrow(() -> new RuntimeException("todoJpas not found"));
    }

    public void update(Long id, String title, boolean done) {
        TodoJpa todoJpa = findById(id);
        todoJpa.setTitle(title);
        todoJpa.setDone(done);
        todoJpaRepository.save(todoJpa);
    }

    public void delete(Long id) {
        todoJpaRepository.deleteById(id);
    }
}
