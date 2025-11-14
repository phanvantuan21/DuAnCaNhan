package com.example.demo.controller;

import com.example.demo.Entity.Color;
import com.example.demo.repository.ColorRepo;
import com.example.demo.service.ColorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ColorController {

    @Autowired
    private ColorRepo colorRepo;

    @Autowired
    private ColorService colorService;

    @GetMapping("/Color")
    public String color(Model model) {
        List<Color> colors = colorRepo.findByDeleteFalse();
        model.addAttribute("colors", colors);
        return "color";
    }

    @GetMapping("/Color/delete")
    public String delete(@RequestParam(required = false) Long id, RedirectAttributes redirectAttributes) {
        // Kiểm tra xem màu sắc có đang được sử dụng không
        try{
            colorService.deleteColor(id);
            redirectAttributes.addFlashAttribute("success", "Color deleted successfully");
        }catch (IllegalStateException e){
            redirectAttributes.addFlashAttribute("error",e.getMessage());
        }
        return "redirect:/Color";
    }
    @PostMapping("/Color/add")
    public String addColor(@RequestParam String code,
                           @RequestParam String name,
                           RedirectAttributes  redirectAttributes) {
        List<Color> colors = colorRepo.findByCode(code);
        if(!colors.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "mã màu bị trùng ");
            redirectAttributes.addFlashAttribute("messageType", "danger");
            return  "redirect:/Color";
        }
        try {
            Color color = Color.builder().code(code).name(name).delete(false).build();
            colorRepo.save(color);
            redirectAttributes.addFlashAttribute("message", "sửa màu thành công");
            redirectAttributes.addFlashAttribute("messageType", "success");
        }catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "thêm màu thất bại");
            redirectAttributes.addFlashAttribute("messageType", "error");
    }
        return "redirect:/Color";
    }
    @PostMapping("/Color/update")
    public String updateColor(@ModelAttribute Color color, RedirectAttributes redirectAttributes) {
        List<Color> colors =  colorRepo.findAllById(List.of(color.getId()));
        if(!colors.isEmpty()) {
            Color color1 = colors.get(0);
            color1.setCode(color.getCode());
            color1.setName(color.getName());
            colorRepo.save(color1);
            redirectAttributes.addFlashAttribute("message", "thêm màu thành công");
            redirectAttributes.addFlashAttribute("messageType", "success");
        }else{
            redirectAttributes.addFlashAttribute("message","Thêm màu thất bại");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/Color";
    }
    @GetMapping("/Color/search")
    public String searchColor(@RequestParam("query") String query, Model model) {
        List<Color> colors = colorService.searchColors(query);
        model.addAttribute("colors", colors);
        model.addAttribute("searchQuery", query);
        return "color"; // hoặc đổi nếu view của bạn khác
    }

}
