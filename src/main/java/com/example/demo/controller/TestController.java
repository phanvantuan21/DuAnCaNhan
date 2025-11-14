package com.example.demo.controller;

import com.example.demo.Entity.Bill;
import com.example.demo.repository.BillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;

import java.util.List;

@Controller
public class TestController {

    @Autowired
    private BillRepository billRepository;

    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "Application is running successfully!";
    }

    @GetMapping("/test-orders-jsp")
    public String testOrdersJsp(Model model) {
        // Test JSP path without security
        List<Bill> bills = billRepository.findAll();
        model.addAttribute("bills", bills);
        model.addAttribute("selectedStatus", "");
        return "admin/orders/list";
    }

    @GetMapping("/debug/session")
    @ResponseBody
    public String debugSession(HttpSession session) {
        StringBuilder result = new StringBuilder();
        result.append("Session ID: ").append(session.getId()).append("<br>");
        result.append("Session Attributes:<br>");

        java.util.Enumeration<String> attributeNames = session.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String name = attributeNames.nextElement();
            Object value = session.getAttribute(name);
            result.append("- ").append(name).append(": ").append(value).append("<br>");
        }

        return result.toString();
    }

    @GetMapping("/debug/revenue")
    @ResponseBody
    public String debugRevenue() {
        StringBuilder result = new StringBuilder();

        // 1. Kiểm tra tổng số hóa đơn
        long totalBills = billRepository.count();
        result.append("Tổng số hóa đơn: ").append(totalBills).append("<br>");

        // 2. Kiểm tra hóa đơn SUCCESS
        long successBills = billRepository.countByStatus("SUCCESS");
        result.append("Hóa đơn SUCCESS: ").append(successBills).append("<br>");

        // 3. Lấy doanh thu
        Double totalRevenue = billRepository.getTotalRevenue();
        result.append("Tổng doanh thu: ").append(totalRevenue).append(" VNĐ<br>");

        // 4. Hiển thị 5 hóa đơn gần đây
        List<Bill> recentBills = billRepository.findTop10ByOrderByCreateDateDesc();
        result.append("<br><strong>5 hóa đơn gần đây:</strong><br>");

        for (int i = 0; i < Math.min(5, recentBills.size()); i++) {
            Bill bill = recentBills.get(i);
            result.append("- ").append(bill.getCode())
                  .append(" | Status: ").append(bill.getStatus())
                  .append(" | Amount: ").append(bill.getAmount())
                  .append(" | Promotion: ").append(bill.getPromotionPrice())
                  .append(" | Final: ").append(bill.getFinalAmount())
                  .append("<br>");
        }

        return result.toString();
    }
}
