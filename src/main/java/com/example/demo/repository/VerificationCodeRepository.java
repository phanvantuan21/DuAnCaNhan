package com.example.demo.repository;

import com.example.demo.Entity.VerificationCode;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface VerificationCodeRepository extends JpaRepository<VerificationCode, Long>{
    Optional<VerificationCode> findByCode(String code);
    Optional<VerificationCode> findByAccount_EmailAndCode(String email, String code);
}
