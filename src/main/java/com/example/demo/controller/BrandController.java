package com.example.demo.controller;

import com.example.demo.Entity.Brand;
import com.example.demo.repository.BrandRepo;
import com.example.demo.service.BrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
public class BrandController {

    @Autowired
    private BrandRepo repo;

    @Autowired
    private BrandService brandService;

    @GetMapping("/Brand")
    public String Brand( Model model) {
        List<Brand> brands;
        brands = repo.findByDeleteFalse();
        model.addAttribute("brands", brands);
        return "brands";
    }
    @GetMapping("/Brand/delete")
    public String BrandDelete(@RequestParam(required = false) Long id, RedirectAttributes redirectAttributes) {
        // Kiểm tra xem thương hiệu có đang được sử dụng không
        try {
            brandService.deleteBrand(id);
            redirectAttributes.addFlashAttribute("success", "xóa thành công");
        }catch (IllegalStateException e){
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/Brand";
    }

    @PostMapping("/Brand/add")
    public String addBrand(@RequestParam String code,
                          @RequestParam String name,
                          @RequestParam Boolean status,
                          RedirectAttributes redirectAttributes) {
        List<Brand> brands = repo.findByCode(code);
        if(!brands.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "mã code đã tồn tại");
            redirectAttributes.addFlashAttribute("messageType","danger");
            return  "redirect:/Brand";
        }
        try {
            Brand brand = Brand.builder()
                    .code(code)
                    .name(name)
                    .status(status)
                    .delete(false)
                    .build();
            repo.save(brand);
            redirectAttributes.addFlashAttribute("message", "Thêm thương hiệu thành công!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi khi thêm thương hiệu: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/Brand";
    }

    @PostMapping("/Brand/update")
    public String updateBrand(@ModelAttribute Brand brand, RedirectAttributes redirectAttributes) {
        List<Brand> brands = repo.findAllById(List.of(brand.getId())); // trả về List<Brand>

        if (!brands.isEmpty()) {
            Brand existing = brands.get(0);
            existing.setCode(brand.getCode());
            existing.setName(brand.getName());
            existing.setStatus(brand.getStatus());
            repo.save(existing);
            redirectAttributes.addFlashAttribute("message", "Cập nhật thương hiệu thành công!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } else {
            redirectAttributes.addFlashAttribute("message", "Không tìm thấy thương hiệu!");
            redirectAttributes.addFlashAttribute("messageType", "danger");
        }
        return "redirect:/Brand";
    }
    @GetMapping("/Brand/search")
    public String searchBrands(@RequestParam(required = false) String query, Model model) {
        List<Brand> brands = brandService.searchBrands(query);
        model.addAttribute("brands", brands);
        model.addAttribute("query", query);
        return "brands"; // thay bằng tên file HTML thực tế của bạn
    }

}


