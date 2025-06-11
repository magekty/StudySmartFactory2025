package com.loginerp.backendjava.config;

import com.loginerp.backendjava.Jwt.JwtAuthenticationFilter;
import com.loginerp.backendjava.Jwt.JwtUtil;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FilterConfig {
    private final JwtUtil jwtUtil;

    public FilterConfig(JwtUtil jwtUtil) {
        this.jwtUtil = jwtUtil;
    }

    @Bean
    public JwtAuthenticationFilter jwtAuthenticationFilter() {
        return new JwtAuthenticationFilter(jwtUtil);
    }

}
