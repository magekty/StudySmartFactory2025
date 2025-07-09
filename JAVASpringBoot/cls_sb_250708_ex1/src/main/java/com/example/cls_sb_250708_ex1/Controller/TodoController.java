package com.example.cls_sb_250708_ex1.Controller;

import com.example.cls_sb_250708_ex1.service.TodoService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/todos")
public class TodoController {
    private final TodoService todoService;


    public TodoController(TodoService todoService) {
        this.todoService = todoService;
    }


    @GetMapping
    public String list(Model model) {
        model.addAttribute("todos", todoService.getAll());
        return "Todo/list";
    }

    @GetMapping("/create")
    public String createFrom() {
        return "Todo/create";
    }

    @PostMapping("/create")
    public String create(@RequestParam String title) {
        todoService.add(title);
        return "redirect:/todos";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        todoService.delete(id);
        return "redirect:/todos";
    }


}
