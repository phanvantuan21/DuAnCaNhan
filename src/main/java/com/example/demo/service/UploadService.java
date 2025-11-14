package com.example.demo.service;

import jakarta.servlet.ServletContext;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@Service
public class UploadService {
    private final ServletContext servletContext;
    public UploadService(ServletContext servletContext){
        this.servletContext = servletContext;
    }
    public String handleSaveUploadFile(MultipartFile file, String targetFoler){
        String finalName = "";
        try {
            byte[] bytes = file.getBytes();
            String rootPath = this.servletContext.getRealPath("/resources/images");
            File dir = new File(rootPath + File.separator + targetFoler);
            if (!dir.exists())
                dir.mkdir();
             finalName = System.currentTimeMillis()
                    + "-" + file.getOriginalFilename();
            File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName);
            BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
            stream.write(bytes);
            stream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return finalName;
    }

    public static void deleteImage(String imageName, String targetFoler) {
        // Đường dẫn tương đối đến thư mục chứa ảnh trong project
        String relativePath = "src/main/webapp/resources/images/"+ targetFoler + imageName;

        File file = new File(relativePath);

        if (file.exists()) {
            if (file.delete()) {
                System.out.println("Đã xóa ảnh: " + imageName);
            } else {
                System.out.println("Không thể xóa ảnh: " + imageName);
            }
        } else {
            System.out.println("Ảnh không tồn tại: " + imageName);
        }
    }
}
