package com.example.cls_sb_250708_ex1.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class Todo {
    private Long id;
    @NotBlank(message = "title은 비워지면 안 되요")
    @Size(max = 50, message = "최대50자까지 가능해요")
    private String title;


    private boolean done;

    public Todo() {
    }

    public Todo(Long id, String title, boolean done) {
        this.id = id;
        this.title = title;
        this.done = done;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean getDone() {
        return done;
    }

    public void setDone(boolean done) {
        this.done = done;
    }
}
