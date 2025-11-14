package com.example.demo.controller;


import com.example.demo.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class PasswordResetController {
    @Autowired
    private AccountService accountService;

    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password";
    }

    @PostMapping("/api/auth/forgot-password")
    @ResponseBody
    public ResponseEntity<String> forgotPassword(@RequestParam String email) {
        String message = accountService.forgotPassword(email);
        return ResponseEntity.ok(message);
    }

    @GetMapping("/reset-password")
    public String showResetPasswordPage() {
        return "reset-password";
    }

    @PostMapping("/api/auth/reset-password")
    @ResponseBody
    public ResponseEntity<String> resetPassword(@RequestParam String code, @RequestParam String newPassword) {
        String message = accountService.resetPassword(code, newPassword);
        return ResponseEntity.ok(message);
    }
}
