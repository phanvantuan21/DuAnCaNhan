package com.example.demo.service;

import com.example.demo.Entity.Image;
import com.example.demo.Entity.ProductDetail;
import com.example.demo.repository.ImageRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ImageService {
    private final ImageRepo imageRepo;
    public ImageService(ImageRepo imageRepo){
        this.imageRepo = imageRepo;
    }
    public void handleSaveImage(Image image){
        this.imageRepo.save(image);
    }
    public List<Image> getAll(){
        List<Image> images = imageRepo.findAll();
        return images;
    }

    public Image getImage(long id){
        Image image = imageRepo.findById(id).get();
        return image;
    }

    public Image getImageByProductDetail(ProductDetail productDetail){
        Image image = imageRepo.findByProductDetail(productDetail);
        return image;
    }
}
