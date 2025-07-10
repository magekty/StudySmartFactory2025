package com.example.cls_sb_250708_ex1.Controller;

import com.example.cls_sb_250708_ex1.model.Todo;
import com.example.cls_sb_250708_ex1.model.TodoJpa;
import com.example.cls_sb_250708_ex1.service.TodoJpaService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/todoJpaes")
public class TodoJpaController {
    private final TodoJpaService todoJpaService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("todoJpaes", todoJpaService.getAll());
        return "TodoJpa/list";
    }

    @GetMapping("/create")
    public String createFrom(Model model) {
        model.addAttribute("todoJpa", new TodoJpa());
        return "TodoJpa/create";
    }

    @PostMapping("/create")
    public String create(@ModelAttribute("todoJpa") @Valid TodoJpa todoJpa, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "TodoJpa/create";
        }
        todoJpaService.add(todoJpa.getTitle());
        return "redirect:/todoJpaes";
    }


    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        todoJpaService.delete(id);
        return "redirect:/todoJpaes";
    }

    // update
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        TodoJpa todoJpa = todoJpaService.findById(id);
        model.addAttribute("todoJpa", todoJpa);
        return "TodoJpa/edit";
    }

    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Long id, @ModelAttribute("todoJpa") @Valid TodoJpa todoJpa, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "TodoJpa/edit";
        }
        todoJpaService.update(id, todoJpa.getTitle(), todoJpa.isDone());
        return "redirect:/todoJpaes";
    }
}
