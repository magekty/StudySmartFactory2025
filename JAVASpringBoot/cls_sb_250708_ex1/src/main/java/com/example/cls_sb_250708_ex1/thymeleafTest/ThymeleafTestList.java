package com.example.cls_sb_250708_ex1.thymeleafTest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class ThymeleafTestList {

    @GetMapping("/testList")
    public String listExample(Model model) {
        List<Map<String, Object>> items = new ArrayList<>();
        Map<String, Object> items1 = Map.of("name", "항목1", "show", true);
        Map<String, Object> items2 = Map.of("name", "항목2", "show", false);
        Map<String, Object> items3 = Map.of("name", "항목3", "show", true);

        items.add(items1);
        items.add(items2);
        items.add(items3);
        model.addAttribute("items", items);
        return "ThymeleafTestList";
    }

}
