package com.example.demo.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BestSellerDto {
    private Long productId;
    private String productName;
    private int totalSoldQuantity;
    private String imageLink; // link ảnh đại diện
    private Integer quantity;
}
