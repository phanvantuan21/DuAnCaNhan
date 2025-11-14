package com.example.demo.service;

import com.example.demo.Entity.Material;
import com.example.demo.repository.MaterialRepo;
import com.example.demo.repository.ProductDetailRepo;
import com.example.demo.repository.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MaterialService {
    @Autowired
    private MaterialRepo materialRepo;

    @Autowired
    private ProductDetailRepo productDetailRepo;

    public List<Material> getAllMaterial(){
        return materialRepo.findAll();
    }

    public List<Material> searchMaterials(String query) {
        return materialRepo.searchMaterials(query);
    }

    public void deleteMaterial(Long materialId){
        boolean existsMaterial = productDetailRepo.existsByProductMaterialIdAndQuantityGreaterThan(materialId, 0);
        if(existsMaterial){
            throw new IllegalStateException("không xóa được do sản phẩm còn hàng");
        }
        Material material = materialRepo.findById(materialId).orElse(null);
        if(material!=null){
            material.setDelete(true);
            materialRepo.save(material);
        }
    }
}
