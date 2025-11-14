package com.example.demo.repository;

import com.example.demo.Entity.Discount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DiscountRepo extends JpaRepository<Discount, Long> {
    // Lấy tất cả bản ghi có delete_flag = 0
    List<Discount> findByDeleteFalse();
    List<Discount> findByCodeContainingIgnoreCaseOrDetailContainingIgnoreCase(String code, String detail);
}
    

