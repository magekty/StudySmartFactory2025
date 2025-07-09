package com.example.cls_sb_250708_ex1.Controller;

import com.example.cls_sb_250708_ex1.model.Item;
import com.example.cls_sb_250708_ex1.service.ItemService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/items")
public class ItemController {

    private final ItemService itemService;

    public ItemController(ItemService itemService) {
        this.itemService = itemService;
    }

    // Create
    @PostMapping
    public ResponseEntity<?> addItem(@RequestBody @Valid Item item, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            // 2. 에러 메시지를 담을 Map 생성
            Map<String, String> errors = new HashMap<>();
            for (FieldError error : bindingResult.getFieldErrors()) {
                errors.put(error.getField(), error.getDefaultMessage());
            }

            // 3. 에러 메시지를 포함한 ResponseEntity 반환
            // 제네릭 타입을 Map<String, String>으로 변경해야 합니다.
            return new ResponseEntity<Map<String, String>>(errors, HttpStatus.BAD_REQUEST);
            // 또는 타입 추론을 사용하여 간단히:
            // return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }
//        return itemService.addItem(item); // 실제 코드
        else {
            itemService.addItem(item);
            return new ResponseEntity<>(item, HttpStatus.OK);
        }
    }

    // Read all
    @GetMapping
    public List<Item> getAllItems() {
        return itemService.getAllItems();
    }

    // Read one
    @GetMapping("/{id}")
    public Item getItem(@PathVariable Long id) {
        return itemService.getItemById(id).
                orElseThrow(() -> new RuntimeException("Item not found"));
    }

    // Update
    @PutMapping("/{id}")
    public Item updateItem(@PathVariable Long id, @RequestBody @Valid Item item) {
        return itemService.updateItem(id, item).
                orElseThrow(() -> new RuntimeException("Item not found"));
    }

    // Delete
    @DeleteMapping("/{id}")
    public String deleteItem(@PathVariable Long id) {
        boolean deleted = itemService.deleteItem(id);
        if (deleted)
            return "Item deleted";
        else
            return "Item not found";
    }

}

