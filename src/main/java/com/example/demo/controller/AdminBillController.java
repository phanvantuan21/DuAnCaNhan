package com.example.demo.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.Entity.Bill;
import com.example.demo.repository.BillRepository;
import com.example.demo.service.BillService;

import org.springframework.web.bind.annotation.GetMapping;


@Controller
@RequestMapping("/admin/bills")
public class AdminBillController {
    @Autowired
    private BillRepository billRepository;
    
    @Autowired
    private BillService billService;

    @GetMapping
    public String getAllBills(@RequestParam(required = false) String status, Model model){
        List<Bill> bills;
        if (status != null && !status.isEmpty()) {
            bills = billRepository.findByStatusOrderByCreateDateDesc(status);
        } else {
            bills = billRepository.findAll();
        }

        model.addAttribute("recentBills", bills);
        model.addAttribute("selectedStatus", status);
        return "admin/bills";
    }

    @GetMapping("/search")
    public String searchBills(
            @RequestParam(required = false) String query,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            Model model) {

        List<Bill> bills = billService.searchBills(query, startDate, endDate);
        model.addAttribute("recentBills", bills);
        model.addAttribute("query", query);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "admin/bills";
    }

}
    

