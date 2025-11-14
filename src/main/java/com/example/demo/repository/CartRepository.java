package com.example.demo.repository;

import com.example.demo.Entity.Cart;
import com.example.demo.Entity.User;
import com.example.demo.Entity.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    
    // Tìm giỏ hàng theo account
    List<Cart> findByAccountOrderByCreateDateDesc(User account);
    
    // Tìm item cụ thể trong giỏ hàng
    Optional<Cart> findByAccountAndProductDetail(User account, ProductDetail productDetail);
    
    // Xóa tất cả item trong giỏ hàng của account
    void deleteByAccount(User account);
    
    // Đếm số item trong giỏ hàng
    long countByAccount(User account);
    
    // Kiểm tra xem sản phẩm có trong giỏ hàng không
    boolean existsByAccountAndProductDetail(User account, ProductDetail productDetail);
}
