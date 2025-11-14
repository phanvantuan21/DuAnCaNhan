package com.example.demo.repository;

import com.example.demo.Entity.Color;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColorRepo extends JpaRepository<Color, Long> {
    List<Color> findByDeleteFalse();
    @Query("SELECT c FROM Color c WHERE " +
            "LOWER(c.code) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(c.name) LIKE LOWER(CONCAT('%', :query, '%'))")
    List<Color> searchColors(@Param("query") String query);

    List<Color> findByCode(String code);

}
