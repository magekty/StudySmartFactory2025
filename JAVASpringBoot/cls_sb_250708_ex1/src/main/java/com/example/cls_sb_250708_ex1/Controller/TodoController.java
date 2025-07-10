package com.example.cls_sb_250708_ex1.Controller;

import com.example.cls_sb_250708_ex1.model.Todo;
import com.example.cls_sb_250708_ex1.service.TodoService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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

    /*    @GetMapping("/create")
        public String createFrom() {
            return "Todo/create";
        }*/
    @GetMapping("/create")
    public String createFrom(Model model) {
        model.addAttribute("todo", new Todo());
        return "Todo/create";
    }

    /*    @PostMapping("/create")
        public String create(@RequestBody @Valid String title) {
            todoService.add(title);
            return "redirect:/todos";
        }*/
    @PostMapping("/create")
    public String create(@ModelAttribute("todo") @Valid Todo todo, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "Todo/create";
        }
        todoService.add(todo.getTitle());
        return "redirect:/todos";
    }


    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        todoService.delete(id);
        return "redirect:/todos";
    }

    // update
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        Todo todo = todoService.findById(id).
                orElseThrow(() -> new RuntimeException("Todo not found"));
        model.addAttribute("todo", todo);
        return "Todo/edit";
    }

    //    <form method="post" th:action="@{/todos/edit/{id}(id=${todo.id})}">
/*    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Long id, @RequestParam @Valid String title, @RequestParam(required = false) boolean done) {
        todoService.update(id, title, done);
        return "redirect:/todos";
    }*/
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Long id, @ModelAttribute("todo") @Valid Todo todo, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "Todo/edit";
        }
        todoService.update(id, todo.getTitle(), todo.getDone());
        return "redirect:/todos";
    }


}
