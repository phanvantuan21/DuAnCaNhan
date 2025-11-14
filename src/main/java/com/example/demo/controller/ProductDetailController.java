package com.example.demo.controller;

import com.example.demo.Entity.*;
import com.example.demo.service.*;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ProductDetailController {
    private final SizeService sizeService;
    private final ColorService colorService;
    private final ProductService productService;
    private final ImageService imageService;
    private final ProductDetailService productDetailService;
    private final UploadService uploadService;
    public ProductDetailController(SizeService sizeService, ColorService colorService,ProductService productService,
                                   ImageService imageService, ProductDetailService productDetailService,
                                   UploadService uploadService ){
        this.sizeService = sizeService;
        this.colorService = colorService;
        this.productService = productService;
        this.imageService = imageService;
        this.productDetailService = productDetailService;
        this.uploadService = uploadService;
    }

    @ModelAttribute("listProduct")
    public Map<Long, String> getProduct(){
        Map<Long, String> maps = new HashMap();
        List<Product> products = productService.getAll();
        for(Product product : products){
            maps.put(product.getId(), product.getName());
        }
        return maps;
    }

    @ModelAttribute("listSize")
    public Map<Long, String> getSize(){
        Map<Long, String> maps = new HashMap();
        List<Size> sizes = sizeService.getAll();
        for(Size size : sizes){
            maps.put(size.getId(), size.getName());
        }
        return maps;
    }

    @ModelAttribute("listColor")
    public Map<Long, String> getColor(){
        Map<Long, String> maps = new HashMap();
        List<Color> colors = colorService.getAll();
        for(Color color : colors){
            maps.put(color.getId(), color.getName());
        }
        return maps;
    }
    @PostMapping("/product-detail/create")
    public String createProductDetail(@Valid @ModelAttribute("newProductDetail")ProductDetail productDetail,
                                      BindingResult bindingResult,
                                      @RequestParam("imgFile")MultipartFile file) {
        List<FieldError> errors = bindingResult.getFieldErrors();
        for(FieldError error : errors){
            System.out.println(">>>>>>" + error.getField() + "-" + error.getDefaultMessage());
        }
        if(bindingResult.hasErrors()){
            return "admin/product-detail/create";
        }
        productDetailService.handleSaveProductDetail(productDetail);
        if(!file.isEmpty()) {
            saveImage(new Image(), file, productDetail);
        }
//        else{
//            Image image = new Image();
//            image.setProductDetail(productDetail);
//            image.setLink(null);
//            imageService.handleSaveImage(image);
//        }
        return "redirect:/product-detail";
    }
    public void saveImage(Image image, MultipartFile file, ProductDetail productDetail){
        String imgProduct = uploadService.handleSaveUploadFile(file,"product");
        image.setCreateDate(LocalDateTime.now());
        image.setLink(imgProduct);
        image.setProductDetail(productDetail);
        imageService.handleSaveImage(image);
    }

    @GetMapping("/product-detail/create")
    public String showCreatePage(Model model){
        model.addAttribute("newProductDetail", new ProductDetail());
        return "admin/product-detail/create";
    }

    @GetMapping("/product-detail")
    public String getAllProductDetails(Model model){
        List<ProductDetail> productDetails = productDetailService.getAll();
        model.addAttribute("productDetails", productDetails);
        return "admin/product-detail/show";
    }

    @GetMapping("/product-detail/{id}")
    public String getAllProductDetail(Model model, @PathVariable("id")Long id){
        Product product = productService.getProductById(id);
        List<ProductDetail> productDetails = productDetailService.getProductByProductId(id);

        model.addAttribute("product", product);
        model.addAttribute("productDetails", productDetails);

        return "admin/product-detail/show";
    }

    @GetMapping("/product-detail/edit/{id}")
    public String loadPageEdit(@PathVariable("id") long id, Model model){
        ProductDetail productDetail = productDetailService.getOneProductDetail(id);
        model.addAttribute("productDetail", productDetail);
        return "admin/product-detail/update";
    }

    @PostMapping("/product-detail/update")
    public String updateProductDetail(@ModelAttribute("productDetail") @Valid ProductDetail productDetail,
                                      BindingResult bindingResult,
                                      @RequestParam("imgFile")MultipartFile file){
        List<FieldError> errors = bindingResult.getFieldErrors();
        for(FieldError error : errors){
            System.out.println(">>>>>>" + error.getField() + "-" + error.getDefaultMessage());
        }
        if(bindingResult.hasErrors()){
            return "admin/product-detail/update";
        }
        if(!file.isEmpty()){
            Image newImage = imageService.getImageByProductDetail(productDetail);
            saveImage(newImage, file, productDetail);
        }
        Product product = productService.getProductByName(productDetail.getProduct().getName());
        productDetail.setProduct(product);
        productDetailService.handleSaveProductDetail(productDetail);

        return "redirect:/product-detail/" + productDetail.getProduct().getId();
    }

    @GetMapping("/product-detail/delete/{id}")
    public String deleteProductDetail(@PathVariable("id") long id){
        // Soft delete - có thể thêm trường deleteFlag vào ProductDetail entity
        // Hoặc hard delete như dưới đây:
        productDetailService.deleteProductDetail(id);
        return "redirect:/product-detail";
    }
}

