    package com.example.demo.Entity;

    import jakarta.persistence.*;
    import lombok.*;

    import java.time.LocalDateTime;
    import java.time.format.DateTimeFormatter;
    import java.util.List;
    import com.example.demo.Entity.ProductDetail;
    import java.util.Date;

    @Builder
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @Entity
    @Table(name = "product_discount")
    public class ProductDiscount {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name = "id")
        private Long id;

        @Column(name = "closed")
        private Boolean closed;

        @Column(name = "discounted_amount")
        private Double discountedAmount;

        @Column(name = "end_date")
        private LocalDateTime endDate;

        @Column(name = "start_date")
        private LocalDateTime startDate;

        @ManyToOne
        @JoinColumn(name = "product_detail_id")
        private ProductDetail productDetail;

// Trong ProductDiscount
@Transient // nếu dùng JPA để đánh dấu không map vào DB
private Date startDateAsDate;

@Transient
private Date endDateAsDate;

    }
    
