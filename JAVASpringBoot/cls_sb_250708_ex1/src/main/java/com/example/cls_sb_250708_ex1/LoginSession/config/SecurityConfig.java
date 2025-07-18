package com.example.cls_sb_250708_ex1.LoginSession.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

//@Configuration
public class SecurityConfig {
    //    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(
                        auth -> auth.requestMatchers("/LoginSession/login")
                                .permitAll().anyRequest().authenticated()
                ).formLogin(form -> form.loginPage("/LoginSession/login")
                        .defaultSuccessUrl("/LoginSession/", true).permitAll()
                ).logout(logout -> logout.logoutUrl("/LoginSession/logout")
                        .logoutSuccessUrl("/LoginSession/login?logout").permitAll()
                );
        return http.build();
    }

    //    @Bean
    public UserDetailsService userDetailsService() {
        UserDetails user = User.withDefaultPasswordEncoder()
                .username("hjseo").password("1234").roles("USER").build();
        return new InMemoryUserDetailsManager(user);
    }
}
