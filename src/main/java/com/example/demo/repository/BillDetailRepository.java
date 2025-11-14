package com.example.demo.repository;

import com.example.demo.Entity.Bill;
import com.example.demo.Entity.BillDetail;
import com.example.demo.Entity.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface BillDetailRepository extends JpaRepository<BillDetail, Long> {
    
    // Tìm chi tiết hóa đơn theo bill
    List<BillDetail> findByBill(Bill bill);
    
    // Tìm chi tiết hóa đơn theo product detail
    List<BillDetail> findByProductDetail(ProductDetail productDetail);



    // Tính tổng số lượng đã bán của một sản phẩm
    @Query("SELECT SUM(bd.quantity) FROM BillDetail bd WHERE bd.productDetail = :productDetail AND bd.bill.status = 'SUCCESS'")
    Integer getTotalSoldQuantity(@Param("productDetail") ProductDetail productDetail);
    
    // Lấy top sản phẩm bán chạy
    @Query("SELECT bd.productDetail, SUM(bd.quantity) as totalSold FROM BillDetail bd " +
           "WHERE bd.bill.status = 'SUCCESS' " +
           "GROUP BY bd.productDetail " +
           "ORDER BY totalSold DESC")
    List<Object[]> getTopSellingProducts();
    
    // Tính tổng doanh thu của một sản phẩm
    @Query("SELECT SUM(bd.quantity * bd.momentPrice) FROM BillDetail bd WHERE bd.productDetail = :productDetail AND bd.bill.status = 'SUCCESS'")
    Double getTotalRevenueByProduct(@Param("productDetail") ProductDetail productDetail);
}
