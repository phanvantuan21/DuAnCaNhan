package com.example.demo.controller;

import com.example.demo.Entity.Bill;
import com.example.demo.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/notifications")
@CrossOrigin(origins = "*")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;
    
    // API lấy số lượng đơn hàng mới
    @GetMapping("/count")
    public ResponseEntity<Integer> getNewOrdersCount() {
        int count = notificationService.getNewOrdersCount();
        return ResponseEntity.ok(count);
    }

    // API lấy danh sách đơn hàng mới (giới hạn 5)
    @GetMapping("/new-orders")
    public ResponseEntity<List<Bill>> getNewOrders() {
        List<Bill> newOrders = notificationService.getNewOrders(5);
        return ResponseEntity.ok(newOrders);
    }

    // API lấy tất cả đơn hàng mới (không giới hạn)
    @GetMapping("/all-new-orders")
    public ResponseEntity<List<Bill>> getAllNewOrders() {
        List<Bill> newOrders = notificationService.getAllNewOrders();
        return ResponseEntity.ok(newOrders);
    }

    // API lấy thông tin tổng quan thông báo
    @GetMapping("/summary")
    public ResponseEntity<Map<String, Object>> getNotificationSummary() {
        Map<String, Object> summary = new HashMap<>();
        summary.put("count", notificationService.getNewOrdersCount());
        summary.put("hasNew", notificationService.hasNewOrders());
        summary.put("message", notificationService.getNotificationSummary());
        return ResponseEntity.ok(summary);
    }

    // API lấy đơn hàng mới trong 24h
    @GetMapping("/recent")
    public ResponseEntity<List<Bill>> getRecentNewOrders() {
        List<Bill> recentOrders = notificationService.getNewOrdersInTimeRange(24);
        return ResponseEntity.ok(recentOrders);
    }
}
