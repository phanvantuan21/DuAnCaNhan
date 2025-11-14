package com.example.demo.service;

import com.example.demo.Entity.*;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class BillService {

    @Autowired
    private BillRepository billRepository;

    @Autowired
    private BillDetailRepository billDetailRepository;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductDetailService productDetailService;

    @Autowired
    private DiscountRepo discountRepo;

    // ============aas===== Tạo hóa đơn từ giỏ hàng trong DB =================
    public Bill createBillFromCart(User user, String billingAddress, String invoiceType,
            PaymentMethod paymentMethod, Discount discount) {
        List<Cart> cartItems = cartRepository.findByAccountOrderByCreateDateDesc(user);

        if (cartItems.isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống");
        }

        double totalAmount = cartItems.stream()
                .mapToDouble(Cart::getTotalPrice)
                .sum();

        double discountAmount = 0.0;
        if (discount != null) {
            discountAmount = calculateDiscountAmount(totalAmount, discount);
        }

        Bill bill = Bill.builder()
                .code(generateBillCode())
                .billingAddress(billingAddress)
                .invoiceType(invoiceType)
                .customer(user.getCustomer())
                .paymentMethod(paymentMethod)
                .discountCode(discount)
                .createDate(LocalDateTime.now())
                .status("PENDING")
                .build();

        // đảm bảo set tiền
        bill.setAmount(totalAmount);
        bill.setSalesChannel("offline");
        bill.setPromotionPrice(discountAmount);

        bill = billRepository.save(bill);

        for (Cart cartItem : cartItems) {
            BillDetail billDetail = BillDetail.builder()
                    .bill(bill)
                    .productDetail(cartItem.getProductDetail())
                    .quantity(cartItem.getQuantity())
                    .momentPrice(cartItem.getProductDetail().getPrice())
                    .returnQuantity(0)
                    .build();
            billDetailRepository.save(billDetail);

            // ✅ KHÔNG trừ số lượng khi tạo đơn PENDING
            // Chỉ trừ khi thanh toán thành công (webhook hoặc admin confirm)
        }

        cartRepository.deleteByAccount(user);

        return bill;
    }

    // ================= Tạo hóa đơn từ giỏ hàng tạm (multi-cart POS)
    // =================
    public Bill createBillFromTempCart(User user, String billingAddress, String invoiceType,
            PaymentMethod paymentMethod, Discount discount,
            List<Cart> cartItems) {
        if (cartItems == null || cartItems.isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống");
        }

        double totalAmount = cartItems.stream()
                .mapToDouble(Cart::getTotalPrice)
                .sum();

        double discountAmount = 0.0;
        if (discount != null) {
            discountAmount = calculateDiscountAmount(totalAmount, discount);
        }

        Bill bill = Bill.builder()
                .code(generateBillCode())
                .billingAddress(billingAddress)
                .invoiceType(invoiceType)
                .customer(user.getCustomer())
                .paymentMethod(paymentMethod)
                .discountCode(discount)
                .createDate(LocalDateTime.now())
                .status("SUCCESS")
                .build();

        // đảm bảo set tiền
        bill.setAmount(totalAmount);
        bill.setSalesChannel("offline");
        bill.setPromotionPrice(discountAmount);

        bill = billRepository.save(bill);

        for (Cart c : cartItems) {
            BillDetail detail = BillDetail.builder()
                    .bill(bill)
                    .productDetail(c.getProductDetail())
                    .quantity(c.getQuantity())
                    .momentPrice(c.getProductDetail().getPrice())
                    .returnQuantity(0)
                    .build();
            billDetailRepository.save(detail);

            ProductDetail pd = c.getProductDetail();
            pd.setQuantity(pd.getQuantity() - c.getQuantity());
            productDetailService.save(pd);
        }

        // ✅ Trừ lượt sử dụng mã giảm giá vì đơn hàng đã SUCCESS
        deductDiscountUsage(bill);

        return bill;
    }

    // ================= Các hàm hỗ trợ =================

    public Bill updateBillStatus(Long billId, String newStatus, String updatedBy) {
        Optional<Bill> billOpt = billRepository.findById(billId);
        if (billOpt.isPresent()) {
            Bill bill = billOpt.get();
            String oldStatus = bill.getStatus();

            bill.setStatus(newStatus);
            Bill savedBill = billRepository.save(bill);

            // ✅ THÊM: Logic xử lý inventory theo status
            handleInventoryOnStatusChange(bill, oldStatus, newStatus);

            return savedBill;
        }
        throw new RuntimeException("Không tìm thấy hóa đơn");
    }

    private double calculateDiscountAmount(double totalAmount, Discount discount) {
        if (discount.getMinimumAmountInCart() != null && totalAmount < discount.getMinimumAmountInCart()) {
            return 0;
        }

        // Kiểm tra số lượt sử dụng còn lại
        if (discount.getMaximumUsage() != null && discount.getMaximumUsage() <= 0) {
            return 0; // Không áp dụng giảm giá nếu hết lượt
        }
        if (discount.getType() != null) {
            if (discount.getType() == 1 && discount.getPercentage() != null && discount.getPercentage() > 0) {
                double discountAmount = totalAmount * discount.getPercentage() / 100;
                if (discount.getMaximumAmount() != null) {
                    return Math.min(discountAmount, discount.getMaximumAmount());
                }
                return discountAmount;
            } else if (discount.getType() == 2 && discount.getAmount() != null && discount.getAmount() > 0) {
                return discount.getAmount();
            } else if (discount.getType() == 3 && discount.getPercentage() != null && discount.getPercentage() > 0) {
                double discountAmount = totalAmount * discount.getPercentage() / 100;
                if (discount.getMaximumAmount() != null) {
                    return Math.min(discountAmount, discount.getMaximumAmount());
                }
                return discountAmount;
            }
        }
        return 0;
    }

    private String generateBillCode() {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String dateTimePart = now.format(formatter);
        return "HD" + dateTimePart;
    }


    public Bill getBillById(Long id) {
        return billRepository.findById(id).orElse(null);
    }

    public List<Bill> getBillsByCustomer(Customer customer) {
        return billRepository.findByCustomerOrderByCreateDateDesc(customer);
    }

    public List<Bill> getAllBills() {
        return billRepository.findAllByOrderByCreateDateDesc();
    }

    public List<Bill> getBillsByStatus(String status) {
        return billRepository.findByStatusOrderByCreateDateDesc(status);
    }

    public Double getTotalRevenue() {
        return billRepository.getTotalRevenue();
    }

    public Double getRevenueByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return billRepository.getTotalRevenueByDateRange(startDate, endDate);
    }

    // ================= Xử lý inventory khi thay đổi trạng thái =================

    private void handleInventoryOnStatusChange(Bill bill, String oldStatus, String newStatus) {
        // Trường hợp 1: Từ PENDING -> CONFIRMED (thanh toán thành công)
        if ("PENDING".equals(oldStatus) && "CONFIRMED".equals(newStatus)) {
            deductInventoryForBill(bill);
            deductDiscountUsage(bill); // ✅ Trừ lượt sử dụng mã giảm giá
        }

        // Trường hợp 2: Trừ số lượng khi chuyển sang DELIVERED (đã giao hàng)
        if ("DELIVERED".equals(newStatus)) {
            // Chỉ trừ nếu chưa trừ trước đó (oldStatus = PENDING)
            if ("PENDING".equals(oldStatus)) {
                deductInventoryForBill(bill);
                deductDiscountUsage(bill); // ✅ Trừ lượt sử dụng mã giảm giá
            }
        }

        // Trường hợp 3: Hủy đơn hàng -> Hoàn trả số lượng và discount usage
        if ("CANCELLED".equals(newStatus)) {
            // Chỉ hoàn trả nếu đã trừ số lượng trước đó (không phải PENDING)
            if (!"PENDING".equals(oldStatus)) {
                restoreInventoryForBill(bill);
                restoreDiscountUsage(bill); // ✅ Hoàn trả lượt sử dụng mã giảm giá
            }
        }
    }

    public void deductInventoryForBill(Bill bill) {
        List<BillDetail> billDetails = billDetailRepository.findByBill(bill);

        for (BillDetail detail : billDetails) {
            ProductDetail productDetail = detail.getProductDetail();
            int newQuantity = productDetail.getQuantity() - detail.getQuantity();

            if (newQuantity < 0) {
                throw new RuntimeException("Không đủ số lượng sản phẩm: " + productDetail.getProduct().getName());
            }

            productDetail.setQuantity(newQuantity);
            productDetailService.save(productDetail);
        }
    }

    public void restoreInventoryForBill(Bill bill) {
        List<BillDetail> billDetails = billDetailRepository.findByBill(bill);

        for (BillDetail detail : billDetails) {
            ProductDetail productDetail = detail.getProductDetail();
            productDetail.setQuantity(productDetail.getQuantity() + detail.getQuantity());
            productDetailService.save(productDetail);
        }
    }

    // ================= Xử lý discount usage =================

    public void deductDiscountUsage(Bill bill) {
        if (bill.getDiscountCode() != null) {
            Discount discount = bill.getDiscountCode();
            if (discount.getMaximumUsage() != null && discount.getMaximumUsage() > 0) {
                discount.setMaximumUsage(discount.getMaximumUsage() - 1);
                discountRepo.save(discount);
                System.out.println("✅ Đã trừ 1 lượt sử dụng mã giảm giá: " + discount.getCode() +
                        " (còn lại: " + discount.getMaximumUsage() + ")");
            }
        }
    }

    public void restoreDiscountUsage(Bill bill) {
        if (bill.getDiscountCode() != null) {
            Discount discount = bill.getDiscountCode();
            if (discount.getMaximumUsage() != null) {
                discount.setMaximumUsage(discount.getMaximumUsage() + 1);
                discountRepo.save(discount);
                System.out.println("✅ Đã hoàn trả 1 lượt sử dụng mã giảm giá: " + discount.getCode() +
                        " (hiện có: " + discount.getMaximumUsage() + ")");
            }
        }
    }

    public List<Discount> filterValidDiscounts(double cartTotal) {
        List<Discount> all = discountRepo.findByDeleteFalse();
        List<Discount> valid = new ArrayList<>();
        for (Discount d : all) {
            try {
                calculateDiscountAmount(cartTotal, d);
                valid.add(d);
            } catch (Exception ignored) {
            }
        }
        return valid;
    }

    public List<Bill> searchBills(String query, LocalDate startDate, LocalDate endDate) {
        LocalDateTime start = (startDate != null) ? startDate.atStartOfDay() : null;
        LocalDateTime end = (endDate != null) ? endDate.plusDays(1).atStartOfDay() : null;
        return billRepository.searchBills(query, start, end);
    }


    public List<Bill> getBillsByCustomerAndStatus(Customer customer, String status) {
        return billRepository.findByCustomerAndStatusOrderByCreateDateDesc(customer, status);
    }
}
