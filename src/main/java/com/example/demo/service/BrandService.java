package com.example.demo.service;

import com.example.demo.Entity.Brand;
import com.example.demo.repository.BrandRepo;
import com.example.demo.repository.ProductDetailRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandService {
    @Autowired
    private BrandRepo brandRepo;
;
    @Autowired
    private ProductDetailRepo productDetailRepo;

    public List<Brand> getAllBrand(){
        return brandRepo.findAll();
    }

    public void deleteBrand(Long brandId){
        boolean existsBrand = productDetailRepo.existsByProductBrandIdAndQuantityGreaterThan(brandId, 0);
        if(existsBrand){
            throw new IllegalStateException("không xóa được do sản phẩm còn hàng");
        }
        Brand brand = brandRepo.findById(brandId).orElse(null);
        if(brand != null){
            brand.setDelete(true);
            brandRepo.save(brand);
        }
    }
    public List<Brand> searchBrands(String query) {
        if (query == null || query.trim().isEmpty()) {
            return brandRepo.findAll();
        }
        return brandRepo.searchBrands(query);
    }
}
