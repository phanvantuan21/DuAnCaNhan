package com.example.demo.Entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "bill")
public class Bill {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "code")
    private String code;

    @Column(name = "amount")
    private Double amount;

    @Column(name = "billing_address")
    private String billingAddress;

    @Column(name = "create_date")
    private LocalDateTime createDate;

    @Column(name = "invoice_type")
    private String invoiceType;

    @Column(name = "promotion_price")
    private Double promotionPrice;

    @Column(name = "return_status")
    private String returnStatus;

    @Column(name = "status")
    private String status;

    @Column(name = "update_date")
    private LocalDateTime updateDate;

    @Column(name = "sales_channel")
    private String salesChannel;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "discount_code_id")
    private Discount discountCode;

    @ManyToOne
    @JoinColumn(name = "payment_method_id")
    private PaymentMethod paymentMethod;

    @OneToMany(mappedBy = "bill", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<BillDetail> billDetails;

    @OneToMany(mappedBy = "bill", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Payment> payments;

    @PrePersist
    protected void onCreate() {
        createDate = LocalDateTime.now();
        if (status == null) {
            status = "PENDING";
        }
    }



    @PreUpdate
    protected void onUpdate() {
        updateDate = LocalDateTime.now();
    }

    // Helper methods
    public boolean isPending() {
        return "PENDING".equals(status);
    }

    public boolean isConfirmed() {
        return "CONFIRMED".equals(status);
    }

    public boolean isProcessing() {
        return "PROCESSING".equals(status);
    }

    public boolean isShipping() {
        return "SHIPPING".equals(status);
    }

    public boolean isDelivered() {
        return "DELIVERED".equals(status);
    }

    public boolean isCancelled() {
        return "CANCELLED".equals(status);
    }

    public Double getFinalAmount() {
        if (amount != null && promotionPrice != null) {
            return amount - promotionPrice;
        }
        return amount != null ? amount : 0.0;
    }

    @Transient
    public Date getCreateDateAsDate(){
        return createDate != null
                ? Date.from(createDate.atZone(ZoneId.systemDefault()).toInstant())
                : null ;
    }



}
