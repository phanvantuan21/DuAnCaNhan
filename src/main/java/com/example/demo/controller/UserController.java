package com.example.demo.controller;


import com.example.demo.Entity.Customer;
import com.example.demo.Entity.User;
import com.example.demo.dto.LoginDto;
import com.example.demo.repository.UserRepone;
import com.example.demo.service.CustomerService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
public class UserController {

    @Autowired
    private UserRepone userReponse;

    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private CustomerService customerService;
    

    @GetMapping("/Login")
    public String DangNhap() {
        return "user";
    }
    @GetMapping("/admin/login")
    public String adminLogin() {
        return "admin/login";
    }

  @PostMapping({"/Login", "/admin/login"})
public String getLogin(
        LoginDto loginDto,
        RedirectAttributes re,
        HttpSession session,
        HttpServletRequest request,
        Model model
) {
    String requestURI = request.getRequestURI(); // Lấy đường dẫn thực tế người dùng gửi form
    boolean isAdminLogin = requestURI.contains("/admin");

    Optional<User> userOpt = userReponse.findByEmail(loginDto.getName());
    if (userOpt.isPresent()) {
        User user = userOpt.get();
        if (passwordEncoder.matches(loginDto.getPassword(), user.getPassword())) {
            if (user.getIsNonLocked()) {
                session.setAttribute("user", user);

                Customer customer = user.getCustomer();
                if (customer != null) {
                    session.setAttribute("customer", customer);
                }

                String roleName = user.getRole().getName();
                List<GrantedAuthority> authorities =
                        List.of(new SimpleGrantedAuthority(roleName));

                Authentication authToken =
                        new UsernamePasswordAuthenticationToken(user.getEmail(), null, authorities);

                SecurityContext securityContext = SecurityContextHolder.createEmptyContext();
                securityContext.setAuthentication(authToken);
                SecurityContextHolder.setContext(securityContext);
                session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);

                re.addFlashAttribute("message", "Đăng nhập thành công " + user.getEmail());

                // Điều hướng theo role
                if ("ROLE_ADMIN".equals(roleName) || "ROLE_EMPLOYEE".equals(roleName)) {
                    return "redirect:/admin/Home";
                } else {
                    return "redirect:/";
                }
            } else {
                re.addFlashAttribute("message", "Tài khoản đã bị khóa");
                return isAdminLogin ? "redirect:/admin/login" : "redirect:/Login";
            }
        }
    }

    // Sai email hoặc mật khẩu
    re.addFlashAttribute("message", "Email hoặc mật khẩu không đúng");
    return isAdminLogin ? "redirect:/admin/login" : "redirect:/Login";
}

    
    @GetMapping("/Logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        // Xóa thông tin người dùng khỏi session
        session.removeAttribute("user");
        User user = (User) session.getAttribute("user");
        // Clear Spring Security context
        SecurityContextHolder.clearContext();
         
        // Hủy toàn bộ session
        session.invalidate();
        // Thêm thông báo đăng xuất thành công
        redirectAttributes.addFlashAttribute("message", "Đăng xuất thành công");
        // Chuyển hướng về trang home thay vì trang đăng nhập
        if(user != null && user.getRole() != null){
            String roleName = user.getRole().getName();
            if("ROLE_ADMIN".equals(roleName) || "ROLE_EMPLOYEE".equals(roleName)){
                return "redirect:/admin/login";
            }
        }
        return "redirect:/";
    }
    @GetMapping("/search")
    public String searchName(@RequestParam("keyword") String keyword) {
        String newKeyword = keyword.toLowerCase();
        switch (newKeyword) {
            case "Trang chủ":
                return "redirect:/Home";
            case "Sản phẩm":
                return "redirect:/product";
            case "Bán hàng":
                return "redirect:/admin/sales";
            case "Hóa đơn":
                return "redirect:/admin/bills";
            case "Quản lý đơn hàng":
                return "redirect:/admin/orders";
            case "Quản lý Danh mục":
                return "redirect:/Category";
            case "Quản lý màu sắc":
                return "redirect:/Color";
            case "Quản lý kích thước":
                return "redirect:/Size";
            case "Quản lý thương hiệu":
                return "redirect:/Brand";
            case "Quản lý chất liệu":
                return "redirect:/Material";
            case "Tài khoản":
                return "redirect:/admin/account";
            case "mã giảm giá":
                return "redirect:/admin/Discount";
            case "giảm giá":
                return "redirect:/admin/ProductDiscount";
            default:
                return "home";
        }
    }
}


