package com.example.demo.service;

import com.example.demo.Entity.Bill;
import com.example.demo.repository.BillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class QRTimeoutService {

    @Autowired
    private BillRepository billRepository;

    // Chạy mỗi phút để kiểm tra đơn hàng QR hết hạn
    @Scheduled(fixedRate = 60000) // 60 giây = 1 phút
    public void cancelExpiredQROrders() {
        // QR code hết hạn sau 5 phút
        LocalDateTime expiredTime = LocalDateTime.now().minusMinutes(5);
        
        List<Bill> expiredBills = billRepository.findByStatusAndCreateDateBefore("PENDING", expiredTime);
        
        for (Bill bill : expiredBills) {
            // Kiểm tra nếu là thanh toán QR (paymentMethodId = 3)
            if (bill.getPaymentMethod() != null && bill.getPaymentMethod().getId() == 3L) {
                bill.setStatus("EXPIRED");
                billRepository.save(bill);
                
                System.out.println("🕐 Đã hủy đơn hàng QR hết hạn: " + bill.getCode());
                // Không cần hoàn trả số lượng vì chưa trừ số lượng
            }
        }
    }
}
