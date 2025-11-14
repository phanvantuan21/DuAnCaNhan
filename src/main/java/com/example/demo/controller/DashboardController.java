package com.example.demo.controller;

import com.example.demo.Entity.Bill;
import com.example.demo.Entity.Product;
import com.example.demo.repository.BillRepository;
import com.example.demo.repository.ProductRepo;
import com.example.demo.repository.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class DashboardController {

    @Autowired
    private BillRepository billRepository;
    
    @Autowired
    private ProductRepo productRepository;

    @Autowired
    private CustomerRepo customerRepository;

    @GetMapping({"/Home", "/admin/Home"})
    public String dashboard(Model model) {
        // Thống kê tổng quan
        long totalOrders = billRepository.count();
        long totalProducts = productRepository.count();
        long totalCustomers = customerRepository.count();
        
        // Tính doanh thu - cách thay thế
        List<Bill> successBills = billRepository.findByStatusOrderByCreateDateDesc("SUCCESS");
        Double totalRevenue = successBills.stream()
            .mapToDouble(Bill::getFinalAmount)
            .sum();

        // Debug log
        System.out.println("=== DASHBOARD DEBUG ===");
        System.out.println("Total bills: " + totalOrders);
        System.out.println("SUCCESS bills: " + successBills.size());
        System.out.println("Total revenue: " + totalRevenue);
        
        // Đơn hàng trong tháng này
        LocalDateTime startOfMonth = LocalDateTime.now().withDayOfMonth(1).truncatedTo(ChronoUnit.DAYS);
        LocalDateTime endOfMonth = startOfMonth.plusMonths(1).minusSeconds(1);
        List<Bill> monthlyOrders = billRepository.findByCreateDateBetweenOrderByCreateDateDesc(startOfMonth, endOfMonth);
        
        // Tính doanh thu tháng này
        Double monthlyRevenue = monthlyOrders.stream()
            .filter(bill -> "SUCCESS".equals(bill.getStatus()))
            .mapToDouble(Bill::getFinalAmount)
            .sum();
        
        // Đơn hàng gần đây (10 đơn mới nhất)
        List<Bill> recentOrders = billRepository.findTop10ByOrderByCreateDateDesc();
        
        // Thống kê trạng thái đơn hàng
        long pendingOrders = billRepository.countByStatus("PENDING");
        long processingOrders = billRepository.countByStatus("PROCESSING");
        long shippingOrders = billRepository.countByStatus("SHIPPING");
        long deliveredOrders = billRepository.countByStatus("DELIVERED");
        long cancelledOrders = billRepository.countByStatus("CANCELLED");
        
        // Sản phẩm sắp hết hàng (số lượng < 10)
        List<Product> lowStockProducts = productRepository.findAll().stream()
            .filter(product -> product.getTotalQuantity() < 10)
            .limit(5)
            .collect(Collectors.toList());
        
        // Tính tỷ lệ tăng trưởng so với tháng trước
        LocalDateTime lastMonthStart = startOfMonth.minusMonths(1);
        LocalDateTime lastMonthEnd = startOfMonth.minusSeconds(1);
        List<Bill> lastMonthOrders = billRepository.findByCreateDateBetweenOrderByCreateDateDesc(lastMonthStart, lastMonthEnd);
        
        Double lastMonthRevenue = lastMonthOrders.stream()
            .filter(bill -> "SUCCESS".equals(bill.getStatus()))
            .mapToDouble(Bill::getFinalAmount)
            .sum();
        
        double revenueGrowth = 0;
        if (lastMonthRevenue > 0) {
            revenueGrowth = ((monthlyRevenue - lastMonthRevenue) / lastMonthRevenue) * 100;
        }
        
        double orderGrowth = 0;
        if (lastMonthOrders.size() > 0) {
            orderGrowth = ((double)(monthlyOrders.size() - lastMonthOrders.size()) / lastMonthOrders.size()) * 100;
        }
        
        // Thêm dữ liệu vào model
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalCustomers", customerRepository.count());
        model.addAttribute("monthlyRevenue", monthlyRevenue);
        model.addAttribute("monthlyOrders", monthlyOrders.size());
        model.addAttribute("recentOrders", recentOrders);
        model.addAttribute("pendingOrders", pendingOrders);
        model.addAttribute("processingOrders", processingOrders);
        model.addAttribute("shippingOrders", shippingOrders);
        model.addAttribute("deliveredOrders", deliveredOrders);
        model.addAttribute("cancelledOrders", cancelledOrders);
        model.addAttribute("lowStockProducts", lowStockProducts);
        model.addAttribute("revenueGrowth", Math.round(revenueGrowth * 100.0) / 100.0);
        model.addAttribute("orderGrowth", Math.round(orderGrowth * 100.0) / 100.0);
        
        return "home";
    }
}
