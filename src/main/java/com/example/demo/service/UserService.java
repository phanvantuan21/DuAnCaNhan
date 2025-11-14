package com.example.demo.service;

import com.example.demo.Entity.Role;
import com.example.demo.Entity.User;
import com.example.demo.repository.UserRepone;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserRepone userReponse;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public User saveUser(User user) {
        // Mã hóa mật khẩu trước khi lưu
        if (user.getPassword() != null && !user.getPassword().startsWith("$2a$")) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }

        // Nếu ngày tạo chưa được set từ phía controller, set tại đây
        if (user.getCreateDate() == null) {
            user.setCreateDate(LocalDateTime.now());
        }

        // Đặt trạng thái mặc định
        if (user.getIsNonLocked() == null) {
            user.setIsNonLocked(true);
        }
        return userReponse.save(user);
    }
    public Role NameRoleById(Long id){
        String name = switch (id.intValue())
        {
            case 1 -> "ROLE_ADMIN";
            case 2 -> "ROLE_EMPLOYEE";
            case 3 -> "ROLE_USER";
            default
                -> "ROLE_USER";
        };
        return Role.builder().id(id).name(name).build();
    }
    public String generateAccountCode(){
        List<User> newCode = userReponse.findByCodeStartingWithOrderByCodeDesc("TK");
        int nextNumber =1;
        if(!newCode.isEmpty()){
            String lastCoded =  newCode.get(0).getCode();
            String code = lastCoded.substring(2);
            try{
                nextNumber = Integer.parseInt(code) +1;
            }catch(NumberFormatException e){
                nextNumber = 1;
            }
        }
        return String.format("TK%04d",nextNumber);
    }
}
