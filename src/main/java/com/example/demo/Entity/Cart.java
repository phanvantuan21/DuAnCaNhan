package com.example.demo.Entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "cart")
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "create_date")
    private LocalDateTime createDate;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "update_date")
    private LocalDateTime updateDate;

    @ManyToOne
    @JoinColumn(name = "account_id")
    private User account;

    @ManyToOne
    @JoinColumn(name = "product_detail_id")
    private ProductDetail productDetail;

    @PrePersist
    protected void onCreate() {
        createDate = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updateDate = LocalDateTime.now();
    }

    // Helper methods
public Double getTotalPrice() {
    if (productDetail != null && quantity != null) {
        Double discountedPrice = (double) productDetail.getDiscountedPrice();
        return discountedPrice * quantity;
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

    public String getProductImage() {
        if (productDetail != null && productDetail.getImageList() != null && !productDetail.getImageList().isEmpty()) {
            return productDetail.getImageList().get(0).getLink();
        }
        return "";
    }
    @Transient
    private Long discountEndTime;
}
