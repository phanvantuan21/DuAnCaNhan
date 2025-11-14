package com.example.demo.controller;

import com.example.demo.Entity.Customer;
import com.example.demo.Entity.User;
import com.example.demo.dto.RegistDto;
import com.example.demo.repository.UserRepone;
import com.example.demo.service.CustomerService;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class RegistController {

    @Autowired
    private UserRepone repone;

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;
    @GetMapping("/DangKy")
    public String DangKy(Model model) {
        // Nếu chưa có user trong model (lần đầu truy cập), thì tạo mới
        if (!model.containsAttribute("RegistDto")) {
            model.addAttribute("RegistDto", new RegistDto());
        }
        // Nếu chưa có isSubmitted thì mặc định là false
        if (!model.containsAttribute("isSubmitted")) {
            model.addAttribute("isSubmitted", false);
        }

        return "register";
    }
    
    @GetMapping("/admin/register-admin")
    public String registerUser(Model model) {
        // Nếu chưa có user trong model (lần đầu truy cập), thì tạo mới
        if (!model.containsAttribute("RegistDto")) {
            model.addAttribute("RegistDto", new RegistDto());
        }
        // Nếu chưa có isSubmitted thì mặc định là false
        if (!model.containsAttribute("isSubmitted")) {
            model.addAttribute("isSubmitted", false);
        }

        return "admin/register-admin";
    }

    @PostMapping({"/DangKy", "/admin/register-admin"})
public String Register(
        @ModelAttribute("RegistDto") @Valid RegistDto registDto,
        BindingResult result,
        RedirectAttributes redirectAttributes,
        HttpServletRequest request
) {
    // Xác định nguồn gọi (admin hay user)
    String currentPath = request.getRequestURI();
    boolean isAdminPage = currentPath.contains("/admin");

    // Nếu có lỗi validate
    if (result.hasErrors()) {
        redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.RegistDto", result);
        redirectAttributes.addFlashAttribute("RegistDto", registDto);
        redirectAttributes.addFlashAttribute("isSubmitted", true);

        if (isAdminPage) {
            return "redirect:/admin/register-admin";
        } else {
            return "redirect:/DangKy";
        }
    }

    User user = new User();
    try {
        // Kiểm tra trùng email
        if (repone.findByEmail(registDto.getEmail()).isPresent()) {
            redirectAttributes.addFlashAttribute("message", "Email đã tồn tại!");
            return isAdminPage ? "redirect:/admin/register-admin" : "redirect:/DangKy";
        }

        // Tạo customer mới
        Customer customer = new Customer();
        customer.setEmail(registDto.getEmail());
        customer.setCode(customerService.generateCustomerCode());
        Customer newCustomer = customerService.saveCustomer(customer);

        user.setEmail(registDto.getEmail());
        user.setCustomer(newCustomer);
        user.setPassword(registDto.getPassword());
        user.setCode(userService.generateAccountCode());
        if (user.getIsNonLocked() == null) {
            user.setIsNonLocked(true);
        }
        user.setRole(userService.NameRoleById(3L));
        userService.saveUser(user);

        redirectAttributes.addFlashAttribute("message", "Đăng ký thành công!");

        // Nếu là admin thì quay lại trang quản lý, còn user thì về login
        return isAdminPage ? "redirect:/admin/register-admin" : "redirect:/Login";

    } catch (Exception e) {
        redirectAttributes.addFlashAttribute("message", "Đăng ký thất bại: " + e.getMessage());
        redirectAttributes.addFlashAttribute("RegistDto", registDto);
        redirectAttributes.addFlashAttribute("isSubmitted", true);
        return isAdminPage ? "redirect:/admin/register-admin" : "redirect:/DangKy";
    }
}

}


