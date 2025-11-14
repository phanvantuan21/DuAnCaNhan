package com.example.demo.controller;

import com.example.demo.Entity.Bill;
import com.example.demo.repository.BillRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Optional;
import java.util.Map;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class PaymentStatusController {

    private final BillRepository billRepository;

@GetMapping("/payment-status")
public ResponseEntity<Map<String, String>> checkPaymentStatus(@RequestParam("billCode") String billCode) {
    Optional<Bill> optionalBill = billRepository.findByCode(billCode);

    if (optionalBill.isEmpty()) {
        return ResponseEntity.notFound().build(); // HTTP 404
    }

    Bill bill = optionalBill.get();
    String status = bill.getStatus();

    // Trả về JSON: { "status": "PENDING" }
    Map<String, String> response = new HashMap<>();
    response.put("status", status);
    return ResponseEntity.ok(response);
}

}
