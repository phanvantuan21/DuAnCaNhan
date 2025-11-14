package com.example.demo.dto;


import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class InfoDto {


    @NotBlank(message = "không được để trống tên")
    private String name;

    @NotBlank(message = "không được để trống số điện thoại")
    private String phoneNumber;

    @NotBlank(message = "không được để trống địa chỉ")
    private String address;
}
