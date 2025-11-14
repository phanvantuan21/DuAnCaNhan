package com.example.demo.Entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "account")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "birth_day")
    private LocalDateTime birthDay;

    @Column(name = "code")
    private String code;

    @Column(name = "create_date")
    private LocalDateTime createDate;

    @Column(name = "email")
    @Email(message = "Email không hợp lệ")
    private String email;

    @Column(name = "is_non_locked", nullable = false)
    @Builder.Default
    private Boolean isNonLocked = true;

    @Column(name = "password")
    @NotBlank(message = "Không được để trống mật khẩu")
    private String password;

    @Column(name = "update_date")
    private LocalDateTime updateDate;

    @PrePersist
    protected void onCreate() {
        createDate = LocalDateTime.now();
        if (isNonLocked == null) {
            isNonLocked = true;
        }
    }
    @PreUpdate
    protected void onUpdate() {
        updateDate = LocalDateTime.now();
    }
    // Getter và setter cho compatibility với code cũ
    public String getName() {
        return this.email; // Sử dụng email làm tên đăng nhập
    }
    public void setName(String name) {
        this.email = name;
    }
    @ManyToOne
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;
    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    private Customer customer;
}
