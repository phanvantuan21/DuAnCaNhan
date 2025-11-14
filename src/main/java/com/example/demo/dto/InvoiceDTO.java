package com.example.demo.dto;

import java.math.BigDecimal;
import java.util.List;

public class InvoiceDTO {
    private String invoiceNumber;
    private String date;
    private String customerName;
    private String customerAddress;
    private List<Item> items;
    private BigDecimal total;

    // getters, setters, constructors

    public static class Item {
        private String description;
        private int quantity;
        private BigDecimal unitPrice;
        private BigDecimal amount;

        // getters, setters, constructors
    }
}
