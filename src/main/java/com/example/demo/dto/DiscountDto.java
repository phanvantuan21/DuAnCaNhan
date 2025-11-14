package com.example.demo.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DiscountDto {
    private Long id;
    private String code;
    private String detail;
    private Float amount;
    private LocalDateTime endDate;
    private Integer maximumAmount;
    private Integer maximumUsage;
    private Float minimumAmountInCart;
    private Integer percentage;
    private LocalDateTime startDate;
    private Integer status;
    private Integer type;
}
