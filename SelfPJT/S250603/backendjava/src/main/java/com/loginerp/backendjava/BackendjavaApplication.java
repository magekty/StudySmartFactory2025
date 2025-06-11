package com.loginerp.backendjava;

import com.loginerp.backendjava.Jwt.JwtAuthenticationFilter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@SpringBootApplication
public class BackendjavaApplication {

	public static void main(String[] args) {
		SpringApplication.run(BackendjavaApplication.class, args);
	}
	// ModelMapper를 Spring Bean으로 등록
	@Bean
	public ModelMapper modelMapper() {
		ModelMapper modelMapper = new ModelMapper();
		// 기본 매핑 전략 설정 (선택 사항이지만, 명확한 매핑을 위해 권장)
		// STRICT: 소스/대상 필드명이 정확히 일치해야 매핑
		// STANDARD: 기본값. 유연하게 매핑 (camelCase-snake_case 등)
		// LOOSE: 가장 유연하게 매핑 (깊은 객체까지 매핑 시도)
		modelMapper.getConfiguration()
				.setMatchingStrategy(org.modelmapper.convention.MatchingStrategies.STRICT) // STRICT로 설정하여 정확한 매핑 유도
				.setFieldMatchingEnabled(true) // 필드 매칭 활성화
				.setFieldAccessLevel(org.modelmapper.config.Configuration.AccessLevel.PRIVATE); // private 필드까지 접근 허용

		// 추가적인 사용자 정의 매핑 규칙 설정 (아래에서 설명)
		// modelMapper.addMappings(new PropertyMap<User, UserDto>() {
		//     @Override
		//     protected void configure() {
		//         map().setFullName(source.getFirstName() + " " + source.getLastName());
		//         skip().setUserId(null); // 특정 필드는 매핑에서 제외
		//     }
		// });

		return modelMapper;
	}
	@Configuration
	@EnableWebSecurity
	public class SecurityConfig {

		private final JwtAuthenticationFilter jwtFilter;

		public SecurityConfig(JwtAuthenticationFilter jwtFilter) {
			this.jwtFilter = jwtFilter;
		}

		@Bean
		public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
			return http
					.csrf(csrf -> csrf.disable())
/*					.authorizeHttpRequests(auth -> auth
							.anyRequest().permitAll()
					)
					.build();*/
					.authorizeHttpRequests(auth -> auth
							.requestMatchers("/api/auth/**").permitAll()
							.anyRequest().authenticated()
					)
					.addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
					.build();
		}
	}
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

}
