package com.example.demo.service;

import com.example.demo.Entity.Discount;
import com.example.demo.repository.DiscountRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiscountService {
    @Autowired
    private DiscountRepo discountRepo;

    // Lấy tất cả discount chưa xóa
    public List<Discount> findAllActive() {
        return discountRepo.findByDeleteFalse();
    }

    // Tìm theo id
    public Discount findById(Long id) {
        return discountRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy discount với id = " + id));
    }

    // Thêm hoặc cập nhật
    public Discount save(Discount discount) {
        return discountRepo.save(discount);
    }

    // Xóa theo id
    public void deleteById(Long id) {
        discountRepo.deleteById(id);
    }
}
