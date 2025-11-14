package com.example.demo.service;

import com.example.demo.Entity.AddressShipping;
import com.example.demo.Entity.Customer;
import com.example.demo.dto.InfoDto;
import com.example.demo.repository.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomerService {
    @Autowired
    private CustomerRepo repo;

    public Customer saveCustomer(Customer customer) {
        return repo.save(customer);
    }
    public Customer findCustomerById(Long id) {
        return repo.findById(id).orElse(null);
    }

    
    public String generateCustomerCode(){
        List<Customer> newCode = repo.findByCodeStartingWithOrderByCodeDesc("KH");
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
        return String.format("KH%04d", nextNumber);
    }
    public void updateCustomer(InfoDto dto){
        AddressShipping address = new AddressShipping();
        address.setAddress(dto.getAddress());
        Customer customer = repo.findByName(dto.getName());
        customer.setName(dto.getName());
        address.setCustomer(customer);
        customer.setPhoneNumber(dto.getPhoneNumber());
        List<AddressShipping> addressList = new ArrayList<>();
        addressList.add(address);
        customer.setAddressShipping(addressList);
        repo.save(customer);
    }
}
