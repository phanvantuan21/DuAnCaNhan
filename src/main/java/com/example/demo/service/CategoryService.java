package com.example.demo.service;

import com.example.demo.Entity.Category;
import com.example.demo.repository.CategoryRepo;
import com.example.demo.repository.ProductDetailRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {
    @Autowired
    private CategoryRepo categoryRepo;

    @Autowired
    private ProductDetailRepo productDetailRepo;

    public List<Category> getAllCategory(){
        return categoryRepo.findAll();
    }

    public List<Category> searchCategories(String query) {
        return categoryRepo.searchCategories(query);
    }

    public void deleteCategory(Long categoryId){
        boolean existsCategory = productDetailRepo.existsByProductCategoryIdAndQuantityGreaterThan(categoryId, 0);
        if(existsCategory){
            throw new IllegalStateException("không xóa được do sản phẩm còn hàng");
        }
        Category category = categoryRepo.findById(categoryId).orElse(null);
        if(category != null){
            category.setDelete(true);
            categoryRepo.save(category);
        }
    }
}
