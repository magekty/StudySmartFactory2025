package com.example.cls_sb_250708_ex1.service;

import com.example.cls_sb_250708_ex1.model.Todo;
import jakarta.validation.Valid;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TodoService {
    private final List<Todo> todos = new ArrayList<>();
    private Long nextId = 1L;

    public List<Todo> getAll() {
        return todos;
    }

    public Todo add(String title) {
        Todo todo = new Todo(nextId++, title, false);
        todos.add(todo);
        return todo;
    }

    public Optional<Todo> findById(Long id) {
        return todos.stream().filter(t -> t.getId().equals(id)).findFirst();
    }

    public void update(Long id, String title, boolean done) {
        findById(id).ifPresent(t -> {
            t.setTitle(title);
            t.setDone(done);
        });
    }

    public void delete(Long id) {
        todos.removeIf(t -> t.getId().equals(id));
    }

}
