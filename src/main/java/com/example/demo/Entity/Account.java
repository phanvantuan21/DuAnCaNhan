package com.example.demo.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "account")
@Getter
@Setter
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "birth_day")
    private LocalDateTime birthDay;

    @Column(name = "code", unique = true)
    private String code;

    @Column(name = "create_date")
    private LocalDateTime createDate;

    @Column(name = "email")
    private String email;

    @Column(name = "is_non_locked")
    private boolean isNonLocked;

    @Column(name = "password")
    private String password;

    @Column(name = "update_date")
    private LocalDateTime updateDate;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;
}
