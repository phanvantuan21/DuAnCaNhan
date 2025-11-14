package com.example.demo.service;

import com.example.demo.Entity.Product;
import com.example.demo.repository.AccountRepository;
import com.example.demo.repository.ProductDetailRepo;
import com.example.demo.repository.ProductRepo;
import org.springframework.stereotype.Service;

import com.example.demo.dto.BestSellerDto;
import com.example.demo.dto.ProductDetailDto;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Service
public class ProductService {

    private final AccountRepository accountRepository;
    private final ProductRepo productRepo;
    private final ProductDetailRepo productDetailRepo;

    public ProductService(ProductRepo productRepo, ProductDetailRepo productDetailRepo, AccountRepository accountRepository){
        this.productRepo = productRepo;
        this.productDetailRepo = productDetailRepo;
        this.accountRepository = accountRepository;
    }
    public Product handleSaveProduct(Product product){
        return this.productRepo.save(product);
    }
    public List<Product> getAll(){
        List<Product> products = productRepo.findByDeleteFlag(false);
        return products;
    }
    public Product getProductById(Long id){
        Product product = this.productRepo.findById(id).get();
        return product;
    }

    public List<Product> getRelatedProducts(Long productId) {
        Product product = getProductById(productId);
        if (product == null || product.getCategory() == null) return List.of();

        // Lấy 4 sản phẩm cùng category, khác sản phẩm hiện tại
        return productRepo.findTop5ByCategoryAndIdNot(product.getCategory(), product.getId());
    }

    public Product getProductByName(String name){
        return this.productRepo.findByName(name);
    }

    public void updateProductStatus(Long productId){
        boolean status = productDetailRepo.existsByProduct_IdAndQuantityGreaterThan(productId, 0);

        Product product = productRepo.findById(productId).orElse(null);
        if(product != null){
            if(status){
                product.setStatus(1);
            }else{
                product.setStatus(0);
            }
            productRepo.save(product);
        }
    }

    public List<ProductDetailDto> getAllProductForUser(){
        return productDetailRepo.findAll().stream()
        .map(detail -> new ProductDetailDto(
                detail.getId(),
                detail.getProduct().getName(),
                detail.getPrice(),
                detail.getDiscountedPrice(),
                (detail.getImageList() != null && !detail.getImageList().isEmpty())
                    ? detail.getImageList().get(0).getLink()
                    : null
        )).toList();
    }
   public List<ProductDetailDto> getDiscountedProducts(double percent){
        return productDetailRepo.findAll().stream()
                .filter(detail -> detail.getDiscountedPrice() == 0 &&
                        detail.getDiscountedPrice() < detail.getPrice() * (1 - percent / 100))
                .map(detail -> new ProductDetailDto(
                        detail.getId(),
                        detail.getProduct().getName(),
                        detail.getPrice(),
                        detail.getDiscountedPrice(),
                    (detail.getImageList() != null && !detail.getImageList().isEmpty())
                            ? detail.getImageList().get(0).getLink()
                            : null
                ))
                .collect(Collectors.toList());
    }

    public List<BestSellerDto> getBestSellerByProduct(){
        return productRepo.findBestSellingProductsWithImage().stream()
        .map(
            obj -> BestSellerDto.builder().productId(((Number) obj[0]).longValue()).
            productName((String) obj[1]).
            totalSoldQuantity(((Number) obj[2]).intValue())
            .imageLink((String) obj[3])
            .quantity((Integer) obj[4])
            .build()
        ).collect(Collectors.toList());
    }
}
