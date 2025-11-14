package com.example.demo.controller;


import com.example.demo.Entity.ProductDetail;
import com.example.demo.Entity.ProductDiscount;
import com.example.demo.service.ProductDiscountService;
import com.example.demo.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class ProductDiscountController {

    @Autowired
    private ProductDiscountService productDiscountService;

    @Autowired
    private ProductService productService;

    // GET: Hiển thị danh sách biến thể và giảm giá
    @GetMapping("/ProductDiscount")
    public String viewDiscountPage(Model model) {
        List<ProductDetail> productDetails = productDiscountService.getAllProductDetails();
        model.addAttribute("productDetails", productDetails);
        return "admin/product-discount/productdiscount";
    }

    // POST: Cập nhật hoặc thêm giảm giá cho biến thể
    @PostMapping("/update")
    public String updateDiscount(
            @RequestParam("productDetailId") Long productDetailId,
            @RequestParam("discountedAmount") Double discountedAmount,
            @RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime startDate,
            @RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime endDate,
            @RequestParam("closed") Boolean closed,
            RedirectAttributes redirectAttributes
    ) {
        try {
            productDiscountService.saveOrUpdateDiscount(productDetailId, discountedAmount, startDate, endDate, closed);
            redirectAttributes.addFlashAttribute("message", "Cập nhật giảm giá thành công!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi khi cập nhật giảm giá!");
            redirectAttributes.addFlashAttribute("messageType", "danger");
        }
        return "redirect:/admin/ProductDiscount";
    }

    // (Tùy chọn) POST: Xóa giảm giá
    @PostMapping("/delete")
    public String deleteDiscount(@RequestParam("discountId") Long discountId,
                                 RedirectAttributes redirectAttributes) {
        try {
            productDiscountService.deleteDiscountById(discountId);
            redirectAttributes.addFlashAttribute("message", "Đã xóa giảm giá.");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi khi xóa giảm giá.");
            redirectAttributes.addFlashAttribute("messageType", "danger");
        }
        return "redirect:/admin/ProductDiscount";
    }

    // GET: Hiển thị form tạo mới product discount
    @GetMapping("/ProductDiscount/create")
    public String createProductDiscountForm(Model model) {
        List<ProductDetail> productDetails = productDiscountService.getAllProductDetails();
        model.addAttribute("productDetails", productDetails);
        model.addAttribute("productDiscount", new ProductDiscount());
        return "admin/product-discount/create";
    }

    // POST: Xử lý tạo mới product discount
    @PostMapping("/ProductDiscount/add")
    public String addProductDiscount(
            @RequestParam("productDetailId") Long productDetailId,
            @RequestParam("discountedAmount") Double discountedAmount,
            @RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime startDate,
            @RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime endDate,
            @RequestParam("closed") Boolean closed,
            RedirectAttributes redirectAttributes
    ) {
        try {
            // Validation
            if (productDetailId == null) {
                redirectAttributes.addFlashAttribute("message", "Vui lòng chọn biến thể sản phẩm!");
                redirectAttributes.addFlashAttribute("messageType", "danger");
                return "redirect:/admin/ProductDiscount/create";
            }

            if (discountedAmount == null || discountedAmount <= 0) {
                redirectAttributes.addFlashAttribute("message", "Số tiền giảm phải lớn hơn 0!");
                redirectAttributes.addFlashAttribute("messageType", "danger");
                return "redirect:/admin/ProductDiscount/create";
            }

            if (startDate.isAfter(endDate)) {
                redirectAttributes.addFlashAttribute("message", "Ngày kết thúc phải sau ngày bắt đầu!");
                redirectAttributes.addFlashAttribute("messageType", "danger");
                return "redirect:/admin/ProductDiscount/create";
            }

            productDiscountService.saveOrUpdateDiscount(productDetailId, discountedAmount, startDate, endDate, closed);
            redirectAttributes.addFlashAttribute("message", "Thêm giảm giá sản phẩm thành công!");
            redirectAttributes.addFlashAttribute("messageType", "success");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi khi thêm giảm giá: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "danger");
        }

        return "redirect:/admin/ProductDiscount";
    }
}
