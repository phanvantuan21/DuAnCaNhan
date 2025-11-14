package com.example.demo.repository;

import com.example.demo.Entity.Bill;
import com.example.demo.Entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {
    
    // Tìm thanh toán theo bill
    List<Payment> findByBillOrderByPaymentDateDesc(Bill bill);
    
    // Tìm thanh toán theo trạng thái
    List<Payment> findByOrderStatusOrderByPaymentDateDesc(String orderStatus);
}
