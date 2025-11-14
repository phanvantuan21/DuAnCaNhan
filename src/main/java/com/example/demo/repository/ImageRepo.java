package com.example.demo.repository;

import com.example.demo.Entity.Image;
import com.example.demo.Entity.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ImageRepo extends JpaRepository<Image , Long> {
    Image findByProductDetail(ProductDetail productDetail);
}
