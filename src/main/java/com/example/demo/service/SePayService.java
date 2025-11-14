package com.example.demo.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.stereotype.Service;

@Service
public class SePayService {

   public String generateBankQR(String bankCode, String accountNumber, BigDecimal amount, String billCode) {
    String encodedInfo = URLEncoder.encode(billCode, StandardCharsets.UTF_8);
    BigDecimal roundedAmount = amount.setScale(0, RoundingMode.HALF_UP);

    return "https://img.vietqr.io/image/" + bankCode + "-" + accountNumber + "-compact.png"
            + "?amount=" + roundedAmount
            + "&addInfo=" + encodedInfo;
}

}
