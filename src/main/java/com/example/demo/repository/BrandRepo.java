package com.example.demo.repository;

import com.example.demo.Entity.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BrandRepo extends JpaRepository<Brand, Long> {
    List<Brand> findByDeleteFalse();

    Optional<Brand> findById(Long id); // Mặc định Spring Data cung cấp

    List<Brand> findByCode(String code);

    @Query("SELECT b FROM Brand b WHERE " +
            "LOWER(b.code) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(b.name) LIKE LOWER(CONCAT('%', :query, '%'))")
    List<Brand> searchBrands(@Param("query") String query);

    Long id(Long id);
}
