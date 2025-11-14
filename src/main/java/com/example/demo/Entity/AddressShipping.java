package com.example.demo.Entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "address_shipping")
@Builder
public class AddressShipping {
    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY)
    private long id;

    private String address;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;
}
