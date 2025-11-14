package com.example.demo.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductDiscountDto {
    private Long id;
    private Boolean closed;
    private Float discountedAmount;
    private LocalDateTime endDate;
    private LocalDateTime startDate;
    private Long productDetail;
}
