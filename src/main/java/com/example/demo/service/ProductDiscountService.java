package com.example.demo.service;

import com.example.demo.Entity.ProductDetail;
import com.example.demo.Entity.ProductDiscount;
import com.example.demo.repository.ProductDetailRepo;
import com.example.demo.repository.ProductDiscountRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ProductDiscountService {

    @Autowired
    private ProductDiscountRepo productDiscountRepo;

    @Autowired
    private ProductDetailRepo productDetailRepo;

    // Lấy toàn bộ danh sách biến thể sản phẩm
    public List<ProductDetail> getAllProductDetails() {
        return productDetailRepo.findAll(); // Có thể thay bằng custom query join nếu muốn
    }

    // Cập nhật hoặc thêm mới giảm giá cho từng biến thể
    public void saveOrUpdateDiscount(Long productDetailId,
                                     Double discountedAmount,
                                     LocalDateTime startDate,
                                     LocalDateTime endDate,
                                     Boolean closed) {
        Optional<ProductDiscount> optional = productDiscountRepo.findByProductDetailId(productDetailId);
        ProductDiscount discount;

        if (optional.isPresent()) {
            discount = optional.get(); // cập nhật bản ghi cũ
        } else {
            ProductDetail detail = productDetailRepo.findById(productDetailId).orElse(null);
            if (detail == null) return; // không tìm thấy biến thể
            discount = new ProductDiscount();
            discount.setProductDetail(detail);
        }

        discount.setDiscountedAmount(discountedAmount);
        discount.setStartDate(startDate);
        discount.setEndDate(endDate);
        discount.setClosed(closed);

        productDiscountRepo.save(discount);
    }

    // (Tùy chọn) Xóa giảm giá
    public void deleteDiscountById(Long id) {
        productDiscountRepo.deleteById(id);
    }
}
