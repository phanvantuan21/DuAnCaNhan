package com.example.demo.repository;

import com.example.demo.Entity.ProductDiscount;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ProductDiscountRepo extends JpaRepository<ProductDiscount, Long> {
    Optional<ProductDiscount> findByProductDetailId(Long productDetailId);


}
