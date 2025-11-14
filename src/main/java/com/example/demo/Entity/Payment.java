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
@Table(name = "payment")
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "amount")
    private Double amount;

    @Column(name = "payment_date")
    private LocalDateTime paymentDate;

    @Column(name = "order_status")
    private String orderStatus;

    @Column(name = "status_exchange")
    private String statusExchange;

    @ManyToOne
    @JoinColumn(name = "bill_id")
    private Bill bill;

    @PrePersist
    protected void onCreate() {
        if (paymentDate == null) {
            paymentDate = LocalDateTime.now();
        }
        if (orderStatus == null) {
            orderStatus = "PENDING";
        }
    }

    // Helper methods
    public boolean isPending() {
        return "PENDING".equals(orderStatus);
    }

    public boolean isPaid() {
        return "PAID".equals(orderStatus);
    }

    public boolean isFailed() {
        return "FAILED".equals(orderStatus);
    }
}
