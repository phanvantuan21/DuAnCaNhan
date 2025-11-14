package com.example.demo.controller;

import com.example.demo.dto.InfoDto;

import com.example.demo.Entity.AddressShipping;
import com.example.demo.Entity.Customer;
import com.example.demo.Entity.User;
import com.example.demo.service.AddressService;
import com.example.demo.service.CustomerService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class ProfileController {

    private final CustomerService customerService;
    private final AddressService addressService;

    public ProfileController(CustomerService customerService, AddressService addressService) {
        this.customerService = customerService;
        this.addressService = addressService;
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            return "redirect:/";
        }

        // Lấy thông tin User để có email đăng nhập
        User user = (User) session.getAttribute("user");

        Customer customer1 = customerService.findCustomerById(customer.getId());

        // Nếu customer chưa có email, lấy email từ User account
        if (customer1.getEmail() == null && user != null && user.getEmail() != null) {
            customer1.setEmail(user.getEmail());
            customer1 = customerService.saveCustomer(customer1);
            session.setAttribute("customer", customer1); // Cập nhật session
        }

        List<AddressShipping> address = customer1.getAddressShipping();
        if (customer1.getPhoneNumber() == null || customer1.getName() == null
                || address == null || address.isEmpty()) {
            InfoDto dto = new InfoDto();
            dto.setName(customer1.getName());
            dto.setPhoneNumber(customer1.getPhoneNumber());
            if (address != null && !address.isEmpty()) {
                dto.setAddress(address.get(0).getAddress());
            }
            model.addAttribute("InfoDto", dto);
            return "profile";
        }
        model.addAttribute("customer", customer1);
        model.addAttribute("address", address.get(0));
        return "fullprofile";
    }

    @GetMapping("/admin/customer/{id}")
    public String viewCustomerDetail(@PathVariable("id") Long id, Model model) {
        Customer customer = customerService.findCustomerById(id);
        if (customer == null) {
            return "redirect:/Home"; // hoặc trang lỗi tùy bạn
        }

        List<AddressShipping> addressList = customer.getAddressShipping();
        AddressShipping address = (addressList != null && !addressList.isEmpty()) ? addressList.get(0) : null;

        model.addAttribute("customer", customer);
        model.addAttribute("address", address);

        return "admin/adminUserProfile"; // JSP bạn sẽ tạo bên admin
    }

    @PostMapping("/postFile")
    public String postFile(@ModelAttribute("InfoDto") @Valid InfoDto infoDto, BindingResult result, HttpSession session,
            RedirectAttributes redirectAttributes, Model model) {
        System.out.println("=== DEBUG POSTFILE ===");
        System.out.println("Name: " + infoDto.getName());
        System.out.println("Phone: " + infoDto.getPhoneNumber());
        System.out.println("Address: " + infoDto.getAddress());
        System.out.println("Has errors: " + result.hasErrors());

        if (result.hasErrors()) {
            System.out.println("Validation errors: " + result.getAllErrors());
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.InfoDto", result);
            redirectAttributes.addFlashAttribute("InfoDto", infoDto);
            return "profile";
        }
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            return "redirect:/Home";
        }
        AddressShipping address = new AddressShipping();
        address.setAddress(infoDto.getAddress());
        customer.setName(infoDto.getName());
        customer.setPhoneNumber(infoDto.getPhoneNumber());
        Customer newCustomer = customerService.saveCustomer(customer);
        address.setCustomer(newCustomer);
        session.setAttribute("customer", newCustomer);
        AddressShipping newAddress = addressService.saveAddress(address);
        session.setAttribute("address", newAddress);
        // Kiểm tra thông tin cần thiết để chuyển sang fullprofile (không yêu cầu email)
        if (newCustomer.getPhoneNumber() != null && newCustomer.getName() != null && newAddress != null) {
            model.addAttribute("customer", newCustomer);
            model.addAttribute("address", newAddress);
            return "fullprofile";
        }

        redirectAttributes.addFlashAttribute("message", "Vui lòng điền đầy đủ thông tin");
        return "redirect:profile";
    }

    @PostMapping("/updateProfile")
    public String updateProfile(@RequestParam("email") String email,
            @RequestParam("name") String name,
            @RequestParam("phoneNumber") String phoneNumber,
            @RequestParam("address") String address,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            return "redirect:/Home";
        }

        // Cập nhật thông tin customer
        customer.setEmail(email.trim().isEmpty() ? null : email.trim());
        customer.setName(name);
        customer.setPhoneNumber(phoneNumber);
        Customer updatedCustomer = customerService.saveCustomer(customer);

        // Cập nhật địa chỉ
        List<AddressShipping> addresses = updatedCustomer.getAddressShipping();
        AddressShipping addressShipping;
        if (addresses != null && !addresses.isEmpty()) {
            // Cập nhật địa chỉ hiện có
            addressShipping = addresses.get(0);
            addressShipping.setAddress(address);
        } else {
            // Tạo địa chỉ mới
            addressShipping = new AddressShipping();
            addressShipping.setAddress(address);
            addressShipping.setCustomer(updatedCustomer);
        }
        AddressShipping updatedAddress = addressService.saveAddress(addressShipping);

        // Cập nhật session
        session.setAttribute("customer", updatedCustomer);
        session.setAttribute("address", updatedAddress);

        redirectAttributes.addFlashAttribute("message", "Cập nhật thông tin thành công!");
        return "redirect:/profile";
    }

}
