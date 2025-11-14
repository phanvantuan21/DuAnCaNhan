package com.example.demo.controller;

import com.example.demo.Entity.User;
import com.example.demo.repository.UserRepone;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class QuanLiNguoiDung {

    @Autowired
    private UserRepone xyz;

    @GetMapping("/account")
    public String QuanLiNguoiDung(
            @RequestParam(name = "query", required = false) String query,
            Model model) {

        List<User> users;

        if (query != null && !query.trim().isEmpty()) {
            users = xyz.searchUsers(query);
        } else {
            users = xyz.findAll();
        }

        model.addAttribute("users", users);
        model.addAttribute("query", query);
        return "taikhoan";
    }



}
