package com.example.demo.Entity;


import jakarta.persistence.*;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDateTime;
import java.util.List;

@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "product_detail")
public class ProductDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;
    @Column
    private String barcode;
    @Column
    @NotNull(message = "giá không được bỏ trống")
    @PositiveOrZero(message = "giá phải lớn hơn hoặc bằng 0")
    private Double price;
    @Column
    @NotNull(message = "số lượng không được bỏ trống")
    @PositiveOrZero(message = "số lượng phải lớn hơn hoặc bằng 0")
    private Integer quantity;
    @ManyToOne
    @JoinColumn(name = "color_id")
    private Color color;
    @ManyToOne
    @JoinColumn(name = "size_id")
    private Size size;
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
    @OneToMany(mappedBy = "productDetail")
    private List<Image> imageList;
    @OneToMany(mappedBy = "productDetail", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<ProductDiscount> productDiscount;
    @OneToMany(mappedBy = "productDetail", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<BillDetail> billDetailList;


    public float getDiscountedPrice() {
        if(productDiscount != null && !productDiscount.isEmpty()) {
            LocalDateTime now = LocalDateTime.now();
            for (ProductDiscount discount : productDiscount) {
                if (!discount.getClosed() && now.isAfter(discount.getStartDate()) && now.isBefore(discount.getEndDate())) {
                    return (float) (price - discount.getDiscountedAmount());
                }
            }
        }
        return price.floatValue();

    }
}

