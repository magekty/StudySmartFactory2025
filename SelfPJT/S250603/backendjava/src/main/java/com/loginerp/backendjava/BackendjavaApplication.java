package com.loginerp.backendjava;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.modelmapper.ModelMapper;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class BackendjavaApplication {

	public static void main(String[] args) {//SpringApplication.run(BackendjavaApplication.class, args);
		ConfigurableApplicationContext context = SpringApplication.run(BackendjavaApplication.class, args);
/*		// Spring 컨테이너로부터 JwtConfig 빈을 가져옵니다.
		// 이 JwtConfig 객체는 이미 @Value("${jwt.secret}")에 의해 secretKey가 주입된 상태입니다.
		JwtConfig jwtConfig = context.getBean(JwtConfig.class);

		// JWT 비밀 키의 로드 상태를 확인하는 메서드를 호출합니다.
		// 이전에 추가한 checkSecretKey() 메서드를 사용하는 것이 더 상세한 디버깅 정보를 제공합니다.
		// 만약 printSecretKey()만 있다면 그것을 호출합니다.
		jwtConfig.checkSecretKey(); // 또는 jwtConfig.printSecretKey();*/
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

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

}
