package com.example.demo.Entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

import java.util.List;


@Entity
@Table(name = "product")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private long id;
    @Column
    @NotBlank(message = "Mã sản phẩm không được để trống")
    private String code;
    @Column
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime create_date;
    @Column
    private String describe;
    @Column
    @NotBlank(message = "Tên sản phẩm không được để trống")
    private String name;
    @Column
    private int status;
    @Column
    private LocalDateTime updated_date;
    @Column
    private boolean delete_flag;
    @Column
    private int gender;
    @ManyToOne
    @JoinColumn(name = "brand_id")
    private Brand brand;
    @ManyToOne
    @JoinColumn(name="category_id")
    private Category category;
    @ManyToOne
    @JoinColumn(name = "material_id")
    private Material material;
    @OneToMany(mappedBy = "product")
    List<ProductDetail> productDetailList;

    @Transient
    public int getTotalQuantity() {
        if (productDetailList == null) return 0;
        return productDetailList.stream()
                .mapToInt(ProductDetail::getQuantity)
                .sum();
    }
}
