package com.example.demo.repository;

import com.example.demo.Entity.Bill;
import com.example.demo.Entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface BillRepository extends JpaRepository<Bill, Long> {
    List<Bill> findAllByOrderByCreateDateDesc();

    // Tìm hóa đơn theo mã
    Optional<Bill> findByCode(String code);

    // Tìm hóa đơn theo customer
    List<Bill> findByCustomerOrderByCreateDateDesc(Customer customer);

    // Tìm hóa đơn theo customer và trạng thái
    List<Bill> findByCustomerAndStatusOrderByCreateDateDesc(Customer customer, String status);

    // Tìm hóa đơn theo trạng thái
    List<Bill> findByStatusOrderByCreateDateDesc(String status);

    // Tìm hóa đơn theo khoảng thời gian
    List<Bill> findByCreateDateBetweenOrderByCreateDateDesc(LocalDateTime startDate, LocalDateTime endDate);

    // Tìm hóa đơn gần đây (10 đơn gần nhất)
    List<Bill> findTop10ByOrderByCreateDateDesc();

    // Tìm hóa đơn theo customer trong khoảng thời gian
    List<Bill> findByCustomerAndCreateDateBetweenOrderByCreateDateDesc(
            Customer customer, LocalDateTime startDate, LocalDateTime endDate);

    // Đếm số hóa đơn theo trạng thái
    long countByStatus(String status);

    // Đếm số hóa đơn của customer
    long countByCustomer(Customer customer);

    // Tính tổng doanh thu theo trạng thái thành công
    @Query("SELECT SUM(b.amount) FROM Bill b WHERE b.status = 'SUCCESS'")
    Double getTotalRevenue();

    // Tính tổng doanh thu trong khoảng thời gian
    @Query("SELECT SUM(b.amount - COALESCE(b.promotionPrice, 0)) FROM Bill b WHERE b.status = 'SUCCESS' AND b.createDate BETWEEN :startDate AND :endDate")
    Double getTotalRevenueByDateRange(@Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);

    // Tìm hóa đơn theo địa chỉ giao hàng
    List<Bill> findByBillingAddressContainingIgnoreCase(String address);

    // Lấy mã hóa đơn lớn nhất để tạo mã mới
    @Query("SELECT b.code FROM Bill b WHERE b.code LIKE 'HD%' ORDER BY b.code DESC")
    List<String> findLatestBillCode();

    // Tìm đơn hàng hết hạn (cho QR timeout)
    List<Bill> findByStatusAndCreateDateBefore(String status, LocalDateTime createDate);

    @Query("SELECT b FROM Bill b WHERE " +
            "(:query IS NULL OR :query = '' OR " +
            "LOWER(b.code) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(b.customer.name) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(b.billingAddress) LIKE LOWER(CONCAT('%', :query, '%'))) " +
            "AND (:startDate IS NULL OR b.createDate >= :startDate) " +
            "AND (:endDate IS NULL OR b.createDate <= :endDate)")
    List<Bill> searchBills(
            @Param("query") String query,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate
    );

}
