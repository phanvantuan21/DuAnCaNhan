package com.example.demo.service;

import com.example.demo.Entity.Bill;
import com.example.demo.repository.BillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class NotificationService {
    
    @Autowired
    private BillRepository billRepository;
    
    /**
     * Lấy số lượng đơn hàng mới (status = PENDING)
     */
    public int getNewOrdersCount() {
        return (int) billRepository.countByStatus("PENDING");
    }
    
    /**
     * Lấy danh sách đơn hàng mới với giới hạn số lượng
     */
    public List<Bill> getNewOrders(int limit) {
        return billRepository.findByStatusOrderByCreateDateDesc("PENDING")
                .stream()
                .limit(limit)
                .collect(Collectors.toList());
    }
    
    /**
     * Lấy tất cả đơn hàng mới
     */
    public List<Bill> getAllNewOrders() {
        return billRepository.findByStatusOrderByCreateDateDesc("PENDING");
    }
    
    /**
     * Lấy đơn hàng mới trong khoảng thời gian (ví dụ: 24h gần đây)
     */
    public List<Bill> getNewOrdersInTimeRange(int hours) {
        LocalDateTime startTime = LocalDateTime.now().minus(hours, ChronoUnit.HOURS);
        return billRepository.findByCreateDateBetweenOrderByCreateDateDesc(startTime, LocalDateTime.now())
                .stream()
                .filter(bill -> "PENDING".equals(bill.getStatus()))
                .collect(Collectors.toList());
    }
    
    /**
     * Kiểm tra có đơn hàng mới không
     */
    public boolean hasNewOrders() {
        return getNewOrdersCount() > 0;
    }
    
    /**
     * Lấy thông báo tóm tắt
     */
    public String getNotificationSummary() {
        int count = getNewOrdersCount();
        if (count == 0) {
            return "Không có đơn hàng mới";
        } else if (count == 1) {
            return "Có 1 đơn hàng mới";
        } else {
            return "Có " + count + " đơn hàng mới";
        }
    }
}
