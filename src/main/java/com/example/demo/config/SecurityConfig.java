package com.example.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityContextRepository securityContextRepository() {
        return new HttpSessionSecurityContextRepository();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authz -> authz
                    .requestMatchers("/Login", "/admin/login", "/admin/register-admin" , "/DangKy", "/", "/Home", "/css/**", "/js/**", "/images/**", "/Logout", "/api/**").permitAll()
                    .requestMatchers("/admin/**").hasAnyRole("ADMIN", "EMPLOYEE")
                    .anyRequest().permitAll()
            )
            .csrf(csrf -> csrf.disable())
            .securityContext(context -> context
                    .securityContextRepository(securityContextRepository())
            )
            .sessionManagement(session -> session
                    .sessionCreationPolicy(org.springframework.security.config.http.SessionCreationPolicy.IF_REQUIRED)
            );

        return http.build();
    }
}
