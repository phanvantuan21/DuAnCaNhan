package com.example.demo.service;

import com.example.demo.Entity.Size;
import com.example.demo.repository.SizeRepo;
import com.example.demo.repository.ProductDetailRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SizeService {
    private final SizeRepo sizeRepo;
    private final ProductDetailRepo productDetailRepo;

    public SizeService(SizeRepo sizeRepo, ProductDetailRepo productDetailRepo){
        this.sizeRepo = sizeRepo;
        this.productDetailRepo = productDetailRepo;
    }

    public List<Size> getAll(){
        List<Size> sizes = sizeRepo.findAll();
        return sizes;
    }

    public void deleteSize(Long colorId){
        boolean existsColor = productDetailRepo.existsBySize_IdAndQuantityGreaterThan(colorId, 0);
        if(existsColor){
            throw new IllegalStateException("không xóa được do sản phẩm vẫn còn hàng");
        }
        Size size = sizeRepo.findById(colorId).orElse(null);
        if(size != null){
            size.setDelete(true);
            sizeRepo.save(size);
        }
    }
    public List<Size> searchSizes(String query) {
        return sizeRepo.searchSizes(query);
    }

}
