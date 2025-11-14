package com.example.demo.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class SePayWebhookRequest {
    private String description;
    private BigDecimal amount;
    private String status;
}
