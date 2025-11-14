package com.example.demo.repository;

import com.example.demo.Entity.PaymentMethod;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaymentMethodRepository extends JpaRepository<PaymentMethod, Long> {
    
    // Tìm phương thức thanh toán đang hoạt động
    List<PaymentMethod> findByStatusTrue();
}
