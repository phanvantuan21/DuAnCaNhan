package com.example.demo.repository;

import com.example.demo.Entity.AddressShipping;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AddressRepo extends JpaRepository<AddressShipping, Long> {

}
