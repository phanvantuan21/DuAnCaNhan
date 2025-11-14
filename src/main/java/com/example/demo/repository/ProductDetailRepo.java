package com.example.demo.repository;

import com.example.demo.Entity.Product;
import com.example.demo.Entity.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductDetailRepo extends JpaRepository<ProductDetail, Long> {
    @Query("SELECT pd FROM ProductDetail pd " +
           "LEFT JOIN FETCH pd.color " +
           "LEFT JOIN FETCH pd.size " +
           "LEFT JOIN FETCH pd.product " +
           "WHERE pd.product.id = :productId")
    List<ProductDetail> findByProductId(@Param("productId") Long productId);


    boolean existsByProductBrandIdAndQuantityGreaterThan(Long brandId, Integer quantity);

    boolean existsByColor_IdAndQuantityGreaterThan(Long colorId, Integer quantity);

    boolean existsBySize_IdAndQuantityGreaterThan(Long sizeId, Integer quantity);

    boolean existsByProduct_IdAndQuantityGreaterThan(Long productId, Integer quantity);

    boolean existsByProductCategoryIdAndQuantityGreaterThan(Long CategoryId, Integer quantity);

    boolean existsByProductMaterialIdAndQuantityGreaterThan(Long MaterialId, Integer quantity);

List<ProductDetail> findByProduct_NameContainingIgnoreCase(String keyword);



}
