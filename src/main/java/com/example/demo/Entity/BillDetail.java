package com.example.demo.Entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "bill_detail")
public class BillDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "moment_price")
    private Double momentPrice;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "return_quantity")
    private Integer returnQuantity;

    @ManyToOne
    @JoinColumn(name = "bill_id")
    private Bill bill;

    @ManyToOne
    @JoinColumn(name = "product_detail_id")
    private ProductDetail productDetail;

    

    @PrePersist
    @PreUpdate
    protected void setMomentPrice() {
        // Lưu giá tại thời điểm đặt hàng
        if (momentPrice == null && productDetail != null && productDetail.getPrice() != null) {
            momentPrice = productDetail.getPrice();
        }
    }

    // Helper methods
    public Double getTotalPrice() {
        if (quantity != null && momentPrice != null) {
            return quantity * momentPrice;
        }
        return 0.0;
    }

    public String getProductName() {
        return productDetail != null && productDetail.getProduct() != null 
            ? productDetail.getProduct().getName() : "";
    }

    public String getProductSize() {
        return productDetail != null && productDetail.getSize() != null 
            ? productDetail.getSize().getName() : "";
    }

    public String getProductColor() {
        return productDetail != null && productDetail.getColor() != null 
            ? productDetail.getColor().getName() : "";
    }
}
