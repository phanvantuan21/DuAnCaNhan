package com.example.demo.repository;

import com.example.demo.Entity.User;
import java.util.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepone extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);

    List<User> findByCodeStartingWithOrderByCodeDesc(String code);
    @Query("SELECT u FROM User u " +
            "JOIN u.customer c " +
            "WHERE LOWER(u.code) LIKE LOWER(CONCAT('%', :query, '%')) " +
            "   OR LOWER(u.email) LIKE LOWER(CONCAT('%', :query, '%')) " +
            "   OR LOWER(c.name) LIKE LOWER(CONCAT('%', :query, '%'))")
    List<User> searchUsers(@Param("query") String query);

    List<User> findByIdIn(List<Long> id);

}
