package com.example.demo.repository;

import com.example.demo.Entity.Material;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MaterialRepo extends JpaRepository<Material,Long> {

    List<Material> findByDeleteFalse();
    @Query("SELECT m FROM Material m WHERE " +
            "LOWER(m.code) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(m.name) LIKE LOWER(CONCAT('%', :query, '%'))")
    List<Material> searchMaterials(@Param("query") String query);

    List<Material> findByCode(String code);
}
