package com.example.cls_sb_250708_ex1.LoginSessionSimpleDB.config;

import com.example.cls_sb_250708_ex1.LoginSessionSimpleDB.service.UserService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, UserService userService) throws Exception {
        http
                .authorizeHttpRequests(
                        auth -> auth.requestMatchers(
                                        "/LoginSessionSimpleDB/login",
                                        "/LoginSessionSimpleDB/register",
                                        "/LoginSessionSimpleDB/register/**"
                                )
                                .permitAll().anyRequest().authenticated()
                ).formLogin(form -> form.loginPage("/LoginSessionSimpleDB/login")
                        .defaultSuccessUrl("/LoginSessionSimpleDB/", true).permitAll()
                ).rememberMe(
                        rm -> rm
                                .key("secure-remember-me")
                                .tokenValiditySeconds(2 * 24 * 60 * 60) //2days
                                .userDetailsService(userService)
                ).logout(logout -> logout.logoutUrl("/LoginSessionSimpleDB/logout")
                        .logoutSuccessUrl("/LoginSessionSimpleDB/login?logout").permitAll()
                );
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
//    @Bean
//    public UserDetailsService userDetailsService(){
//        UserDetails user = User.withDefaultPasswordEncoder()
//                .username("hjseo").password("1234").roles("USER").build();
//        return new InMemoryUserDetailsManager(user);
//    }
}
