package com.example.demo.repository;

import com.example.demo.Entity.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SizeRepo extends JpaRepository<Size,Long> {
    List<Size> findByDeleteFalse();
    @Query("SELECT s FROM Size s WHERE " +
            "LOWER(s.code) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(s.name) LIKE LOWER(CONCAT('%', :query, '%'))")
    List<Size> searchSizes(@Param("query") String query);

    List<Size> findByCode(String code);
}
