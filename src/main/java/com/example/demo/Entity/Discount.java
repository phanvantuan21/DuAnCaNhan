package com.example.demo.Entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "discount_code")
public class Discount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "code")
    private String code;

    @Column(name = "delete_flag", nullable = false)
    private boolean delete;

    @Column(name = "detail")
    private String detail;

    @Column(name = "discount_amount")
    private Float amount;

    @Column(name = "end_date")
    private LocalDateTime endDate;

    @Column(name = "maximum_amount")
    private Integer maximumAmount;

    @Column(name = "maximum_usage")
    private Integer maximumUsage;

    @Column(name = "minimum_amount_in_cart")
    private Float minimumAmountInCart;

    @Column(name = "percentage")
    private Integer percentage;

    @Column(name = "start_date")
    private LocalDateTime startDate;

    @Column(name = "status")
    private Integer status;

    @Column(name = "type")
    private Integer type;
}
