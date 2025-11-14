package com.example.demo.service;

import com.example.demo.Entity.AddressShipping;
import com.example.demo.repository.AddressRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class AddressService {
    @Autowired
    private AddressRepo repo;
    public AddressShipping saveAddress(AddressShipping address) {
        return repo.save(address);
    }
}
