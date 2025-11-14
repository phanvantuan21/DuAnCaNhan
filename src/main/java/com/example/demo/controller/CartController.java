package com.example.demo.controller;

import com.example.demo.Entity.*;
import com.example.demo.dto.ProductDetailDto;
import com.example.demo.service.*;
import com.example.demo.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.http.HttpStatus;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @Autowired
    private ProductDetailService productDetailService;

    @Autowired
    private BillService billService;

    @Autowired
    private PaymentMethodRepository paymentMethodRepository;

    @Autowired
    private DiscountRepo discountRepo;

    @Autowired
    private SePayService sePayService;

    @Autowired
    private BillRepository billRepository;
    // Hiển thị giỏ hàng
@GetMapping("")
public String viewCart(HttpSession session, Model model) {
    User user = (User) session.getAttribute("user");
    if (user == null) {
        return "redirect:/Login";
    }

    List<Cart> cartItems = cartService.getCartByUser(user);

    for (Cart cart : cartItems) {
        var discounts = cart.getProductDetail().getProductDiscount();

        if (discounts != null && !discounts.isEmpty()) {
            var discount = discounts.get(0);

            // ⚙️ Gán Date từ LocalDateTime
            discount.setEndDateAsDate(Date.from(discount.getEndDate()
                    .atZone(ZoneId.systemDefault()).toInstant()));

            discount.setStartDateAsDate(Date.from(discount.getStartDate()
                    .atZone(ZoneId.systemDefault()).toInstant()));

            if (discount.getEndDateAsDate() != null) {
                cart.setDiscountEndTime(discount.getEndDateAsDate().getTime());
            } else {
                cart.setDiscountEndTime(null);
            }
        } else {
            cart.setDiscountEndTime(null);
        }
    }

    Double cartTotal = cartService.getCartTotal(user);

    model.addAttribute("cartItems", cartItems);
    model.addAttribute("cartTotal", cartTotal);
    model.addAttribute("cartItemCount", cartItems.size());

    return "user/client/cart";
}

    // Thêm sản phẩm vào giỏ hàng
    @PostMapping(value = "/add", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String addToCart(@RequestParam Long productDetailId, 
                           @RequestParam Integer quantity,
                           HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "error:Vui lòng đăng nhập";
        }

        try {
            ProductDetail productDetail = productDetailService.getProductDetailById(productDetailId);
            if (productDetail == null) {
                return "error:Sản phẩm không tồn tại";
            }

            if (productDetail.getQuantity() < quantity) {
                return "error:Không đủ hàng trong kho";
            }

            cartService.addToCart(user, productDetail, quantity);
            return "success:Đã thêm vào giỏ hàng";
        } catch (Exception e) {
            return "error:" + e.getMessage();
        }
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    @PostMapping("/update")
    @ResponseBody
    public String updateCartItem(@RequestParam Long cartId, 
                                @RequestParam Integer quantity) {
        try {
            cartService.updateCartItemQuantity(cartId, quantity);
            return "success:Cập nhật thành công";
        } catch (Exception e) {
            return "error:" + e.getMessage();
        }
    }

    // Xóa sản phẩm khỏi giỏ hàng
    @PostMapping("/remove")
    @ResponseBody
    public String removeFromCart(@RequestParam Long cartId) {
        try {
            cartService.removeFromCart(cartId);
            return "success:Đã xóa khỏi giỏ hàng";
        } catch (Exception e) {
            return "error:" + e.getMessage();
        }
    }

    // Trang thanh toán
    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }
        
        List<Cart> cartItems = cartService.getCartByUser(user);
        if (cartItems.isEmpty()) {
            return "redirect:/cart";
        }
        Customer customer = user.getCustomer();
        if (customer == null
            || customer.getName() == null || customer.getName().isEmpty()
            || customer.getPhoneNumber() == null || customer.getPhoneNumber().isEmpty()){
               redirectAttributes.addFlashAttribute("error", "Vui lòng cập nhật thông tin cá nhân trước khi thanh toán");
                return "redirect:/profile";
        }
        // Kiểm tra tồn kho
        if (!cartService.validateCartStock(user)) {
            model.addAttribute("error", "Một số sản phẩm trong giỏ hàng không đủ số lượng");
            return "redirect:/cart";
        }

        Double cartTotal = cartService.getCartTotal(user);
        List<PaymentMethod> paymentMethods = paymentMethodRepository.findByStatusTrue();
        List<Discount> availableDiscounts = discountRepo.findByDeleteFalse();
        
        for (PaymentMethod method : paymentMethods) {
            switch (method.getName()) {
                case "CHUYEN_KHOAN":
                    method.setName("Chuyển khoản");
                    break;
                case "TIEN_MAT":
                    method.setName("Tiền mặt");
                    break;
                case "THE":
                    method.setName("Thẻ tín dụng");
                    break;
            }
        }
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal);
        model.addAttribute("paymentMethods", paymentMethods);
        model.addAttribute("discounts", availableDiscounts);
        model.addAttribute("customer", customer);

        return "user/client/checkout";
    }
    // Xử lý đặt hàng
    @PostMapping("/place-order")
    public String placeOrder(@RequestParam String billingAddress,
                           @RequestParam String invoiceType,
                           @RequestParam Long paymentMethodId,
                           @RequestParam(required = false) Long discountId,
                           HttpSession session,
                           RedirectAttributes redirectAttributes,
                           Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }

        try {
            PaymentMethod paymentMethod = paymentMethodRepository.findById(paymentMethodId).orElse(null);
            Discount discount = null;
            if (discountId != null) {
                discount = discountRepo.findById(discountId).orElse(null);
            }

            Bill bill = billService.createBillFromCart(user, billingAddress, invoiceType, paymentMethod, discount);
            bill.setSalesChannel("online");
            billRepository.save(bill);
        if (paymentMethodId == 3L) {
        String bankCode = "MB"; // ngân hàng (VD: MB, VCB, TCB...)
        String accountNumber = "0367387326"; // số tài khoản của shop
        BigDecimal amount = BigDecimal.valueOf(bill.getFinalAmount());

        String qrUrl = sePayService.generateBankQR(
            bankCode,
            accountNumber,
            amount,
            bill.getCode()
        );

        model.addAttribute("qrUrl", qrUrl);
        model.addAttribute("billId", bill.getId());
        model.addAttribute("billCode", bill.getCode());
        return "show-qr"; // Trả về JSP hiển thị mã QR
        }
            redirectAttributes.addFlashAttribute("success", "Đặt hàng thành công! Mã đơn hàng: " + bill.getCode());
            return "redirect:/orders/" + bill.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Đặt hàng thất bại: " + e.getMessage());
            return "redirect:/cart/checkout";
        }
    }

    // Lấy số lượng item trong giỏ hàng (AJAX)
    @GetMapping("/count")
    @ResponseBody
    public long getCartItemCount(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return 0;
        }
        return cartService.getCartItemCount(user);
    }

    // API tính toán discount
   @PostMapping("/api/discount/calculate")
@ResponseBody
public Map<String, Object> calculateDiscount(@RequestBody Map<String, Object> request) {
    Map<String, Object> response = new HashMap<>();
    
    try {
        Long discountId = Long.valueOf(request.get("discountId").toString());
        Double totalAmount = Double.valueOf(request.get("totalAmount").toString());
        
        Optional<Discount> discountOpt = discountRepo.findById(discountId);
        LocalDateTime now = LocalDateTime.now();
        if (discountOpt.isPresent()) {
            Discount discount = discountOpt.get();
            
            // Chỉ xử lý mã giảm giá theo phần trăm
            if (discount.getPercentage() != null && discount.getPercentage() > 0) {
                // Kiểm tra điều kiện tối thiểu
                if (discount.getMinimumAmountInCart() != null && totalAmount < discount.getMinimumAmountInCart()) {
                    response.put("success", false);
                    response.put("message", "Mã giảm giá chưa có hiệu lực");
                    return response;
                }
                if (discount.getEndDate() != null && now.isAfter(discount.getEndDate())) {
                    response.put("success", false);
                    response.put("message", "Mã giảm giá đã hết hạn");
                    return response;
                }

                // Kiểm tra số lượt sử dụng còn lại
                if (discount.getMaximumUsage() != null && discount.getMaximumUsage() <= 0) {
                    response.put("success", false);
                    response.put("message", "Mã giảm giá đã hết lượt sử dụng");
                    return response;
                }
                
                // Tính toán giảm giá theo phần trăm
                double discountAmount = 0.0;
                if(discount.getPercentage() != null && discount.getPercentage() > 0) {
                    discountAmount = totalAmount * (discount.getPercentage() / 100.0);
                }else if(discount.getAmount() != null && discount.getAmount() > 0 ) {
                    discountAmount = discount.getAmount();
                } else {
                    response.put("success", false);
                    response.put("message", "Mã giảm giá không hợp lệ");
                    return response;
                }
                
                // Áp dụng giới hạn tối đa nếu có
                if (discount.getMaximumAmount() != null && discountAmount > discount.getMaximumAmount()) {
                    discountAmount = discount.getMaximumAmount();
                }
                if( discount.getMinimumAmountInCart() != null && totalAmount < discount.getMinimumAmountInCart()){
                    response.put("success", false);
                    response.put("message", "Mã giảm giá chưa có hiệu lực");
                    return response;
                }
                System.out.println("Giảm sau khi check max: " + discountAmount);

                response.put("percentage", discount.getPercentage());
                response.put("success", true);
                response.put("discountAmount", String.format("%,.0f", discountAmount));
                response.put("finalAmount", String.format("%,.0f", totalAmount - discountAmount));
                response.put("totalAmount", String.format("%,.0f", totalAmount));
                response.put("message", "Áp dụng mã giảm giá thành công");
            } else {
                // Không hỗ trợ mã giảm theo số tiền cố định
                response.put("success", false);
                response.put("message", "Mã giảm giá này không được hỗ trợ");
            }
        } else {
            response.put("success", false);
            response.put("message", "Mã giảm giá không tồn tại");
        }
    } catch (Exception e) {
        response.put("success", false);
        response.put("message", "Có lỗi xảy ra khi tính toán giảm giá");
    }
    
    return response;
}
    @GetMapping("/qr-code/{code}")
public String showQRCodePage(@PathVariable String code, Model model) {
    // Tìm hóa đơn theo mã code
    Bill bill = billRepository.findByCode(code)
        .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy đơn hàng"));

        String bankCode = "MB";
        String accountNumber = "0367387326";
        String qrUrl = sePayService.generateBankQR(
        bankCode,
        accountNumber,
        BigDecimal.valueOf(bill.getFinalAmount()),
        "Thanh toan don hang: " + bill.getCode() // Đổi domain nếu cần
    );

    // Truyền dữ liệu sang trang JSP
    model.addAttribute("billCode", bill.getCode());
    model.addAttribute("billId", bill.getId());
    model.addAttribute("qrUrl", qrUrl);

    return "show-qr"; // payment.jsp
}

}

