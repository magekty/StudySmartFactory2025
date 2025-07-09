package com.example.cls_sb_250708_ex1.model;

// MVC 패턴
// Model: 데이터, 비지니스 로직
// View: 레이아웃, 화면
// Controller: 모델/뷰 명령을 전달

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class Item {
    private Long id;
    @NotBlank(message = "name은 반드시 채워져야 해요")
    private String name;
    @NotNull(message = "Quantity는 비워지면 안 되요")
    @Min(value = 1, message = "Quantity는 1 이상이어야 해요")
    private int quantity;

    public Item() {
    }

    public Item(Long id, String name, int quantity) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
