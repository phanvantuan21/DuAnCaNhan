package com.example.demo.repository;

import com.example.demo.Entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.demo.Entity.Category;

import java.util.List;

@Repository
public interface ProductRepo extends JpaRepository<Product, Long> {
    @Query("select p from Product p where p.delete_flag = :delete_flag")
    List<Product> findByDeleteFlag(@Param("delete_flag") boolean deleteFlag);
    Product findByName(String name);

    List<Product> findTop5ByCategoryAndIdNot(Category category, Long id);

    
    @Query("""
        SELECT p.id AS productId,
               p.name AS productName,
               SUM(bd.quantity - COALESCE(bd.returnQuantity, 0)) AS totalSoldQuantity,
               MIN(i.link) AS imageLink,
                pd.quantity
        FROM Product p
        JOIN p.productDetailList pd
        JOIN pd.billDetailList bd
        JOIN bd.bill b
        LEFT JOIN pd.imageList i
        WHERE b.status = 'success'
        GROUP BY p.id, p.name ,pd.quantity
        ORDER BY totalSoldQuantity DESC
    """)
    List<Object[]> findBestSellingProductsWithImage();
}
