package com.example.demo.controller;

import com.example.demo.Entity.Brand;
import com.example.demo.Entity.Category;
import com.example.demo.Entity.Material;
import com.example.demo.Entity.Product;
import com.example.demo.Entity.ProductDetail;
import com.example.demo.Entity.ProductDiscount;
import com.example.demo.service.BrandService;
import com.example.demo.service.CategoryService;
import com.example.demo.service.MaterialService;
import com.example.demo.service.ProductService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class ProductController {
    private final ProductService productService;
    private final BrandService brandService;
    private final CategoryService categoryService;
    private final MaterialService materialService;

    public ProductController(ProductService productService, BrandService brandService,
            CategoryService categoryService,
            MaterialService materialService) {

        this.productService = productService;
        this.brandService = brandService;
        this.categoryService = categoryService;
        this.materialService = materialService;
    }

    @ModelAttribute("listBrand")
    public Map<Long, String> listBrand() {
        Map<Long, String> map = new HashMap<>();
        List<Brand> brands = brandService.getAllBrand();
        for (Brand brand : brands) {
            map.put(brand.getId(), brand.getName());
        }
        return map;
    }

    @ModelAttribute("listCategory")
    public Map<Long, String> listCategory() {
        Map<Long, String> map = new HashMap<>();
        List<Category> categories = categoryService.getAllCategory();
        for (Category category : categories) {
            map.put(category.getId(), category.getName());
        }
        return map;
    }

    @ModelAttribute("listMaterial")
    public Map<Long, String> listMaterial() {
        Map<Long, String> map = new HashMap<>();
        List<Material> materials = materialService.getAllMaterial();
        for (Material material : materials) {
            map.put(material.getId(), material.getName());
        }
        return map;
    }

    @GetMapping("/admin/products")
    public String getAdminProductPage(Model model) {
        List<Product> products = productService.getAll();
        model.addAttribute("products", products);
        return "admin/product/show";
    }

    @GetMapping("/product")
    public String getProduct(Model model,
            @RequestParam(value = "categoryId", required = false) Long categoryId,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "sortBy", required = false) String sortBy,
            @RequestParam(value = "keyword", required = false) String keyword) {

        List<Product> products = productService.getAll();
        List<Category> categories = categoryService.getAllCategory();
        // Set default sort if not specified
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "newest";
        }
        // Filter by search keyword
        if (keyword != null && !keyword.isEmpty()) {
            String lowerCaseSearch = keyword.toLowerCase();
            products = products.stream()
                    .filter(p -> p.getName().toLowerCase().contains(lowerCaseSearch))
                    .collect(Collectors.toList());
        }
        // Filter by category
        if (categoryId != null && categoryId > 0) {
            products = products.stream()
                    .filter(p -> p.getCategory().getId().equals(categoryId))
                    .collect(Collectors.toList());
        }

        // Filter by status (stock availability)
        if (status != null && !status.isEmpty()) {
            if ("1".equals(status)) { // Còn hàng
                products = products.stream()
                        .filter(p -> p.getTotalQuantity() > 0)
                        .collect(Collectors.toList());
            } else if ("0".equals(status)) { // Hết hàng
                products = products.stream()
                        .filter(p -> p.getTotalQuantity() == 0)
                        .collect(Collectors.toList());
            } else if ("sale".equals(status)) { // Giảm giá
                products = products.stream()
                        .filter(p -> !p.getProductDetailList().isEmpty() &&
                                p.getProductDetailList().get(0).getDiscountedPrice() < p.getProductDetailList().get(0)
                                        .getPrice())
                        .collect(Collectors.toList());
            } else if ("best".equals(status)) {
                List<Long> bestSellerIds = productService.getBestSellerByProduct()
                        .stream().map(dto -> dto.getProductId()).collect(Collectors.toList());
                products = products.stream().filter(p -> bestSellerIds.contains(p.getId()))
                        .collect(Collectors.toList());
            }
        }

        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "newest";
        }

        // Hàm lấy giá thực tế
        Comparator<Product> actualPriceComparator = Comparator.comparingDouble(p -> {
            if (p.getProductDetailList().isEmpty())
                return 0;
            ProductDetail pd = p.getProductDetailList().get(0);
            return (pd.getDiscountedPrice() > 0
                    && pd.getDiscountedPrice() < pd.getPrice())
                            ? pd.getDiscountedPrice()
                            : pd.getPrice();
        });

        // Sort sản phẩm
        switch (sortBy) {
            case "newest":
                products.sort((p1, p2) -> p2.getCreate_date().compareTo(p1.getCreate_date()));
                break;
            case "price_asc":
                products.sort(actualPriceComparator);
                break;
            case "price_desc":
                products.sort(actualPriceComparator.reversed());
                break;
        }
        model.addAttribute("categories", categories);
        model.addAttribute("keyword", keyword);
        model.addAttribute("products", products);
        model.addAttribute("selectedCategoryId", categoryId);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedSortBy", sortBy);

        return "user/client/product";
    }

    @GetMapping("admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("admin/product/create")
    public String createProduct(@Valid @ModelAttribute("newProduct") Product product, BindingResult bindingResult,
            Model model) {
        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>>>" + error.getField() + "-" + error.getDefaultMessage());
        }
        if (bindingResult.hasErrors()) {
            return "admin/product/create";
        }
        if (productService.getProductByName(product.getName()) != null) {
            String message = "Sản phẩm đã tồn tại";
            model.addAttribute("message", message);
            return "admin/product/create";
        }
        product.setCreate_date(LocalDateTime.now());
        product.setDelete_flag(false);
        product.setGender(1);
        productService.handleSaveProduct(product);
        return "admin/product/create";
    }

    @GetMapping("admin/product/update/{id}")
    public String getPageUpdate(Model model, @PathVariable("id") Long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        return "admin/product/update";
    }

    @PostMapping("admin/product/update")
    public String updateProduct(@Valid @ModelAttribute("product") Product product, BindingResult bindingResult) {
        System.out.println(">>>>>>>>>>>>" + product.getCreate_date());
        if (bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();
            for (FieldError error : errors) {
                System.out.println(">>>>>>" + error.getField() + "-" + error.getDefaultMessage());
            }
            return "admin/product/update";
        }

        product.setUpdated_date(LocalDateTime.now());
        productService.handleSaveProduct(product);
        return "redirect:admin/products";
    }

    @GetMapping("admin/product/delete/{id}")
    public String deleteProduct(@PathVariable("id") long id) {
        Product product = productService.getProductById(id);
        product.setDelete_flag(true);
        productService.handleSaveProduct(product);
        return "redirect:/admin/products";
    }
}
