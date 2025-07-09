package com.example.cls_sb_250708_ex1.service;

import com.example.cls_sb_250708_ex1.model.Item;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ItemService {
    private final List<Item> items = new ArrayList<>();
    private Long nextId = 1L;

    // Create
    public Item addItem(Item item) {
        item.setId(nextId++);
        items.add(item);
        return item;
    }

    // Read all
    public List<Item> getAllItems() {
        return items;
    }

    // Read one
    public Optional<Item> getItemById(Long id) {
        return items.stream().filter(i -> i.getId().equals(id)).findFirst();
    }

    // Update
    public Optional<Item> updateItem(Long id, Item newItem) {
        return getItemById(id).map(item -> {
            item.setName(newItem.getName());
            item.setQuantity(newItem.getQuantity());
            return item;
        });
    }

    // Delete
    public boolean deleteItem(Long id) {
        return items.removeIf(item -> item.getId().equals(id));
    }
}
