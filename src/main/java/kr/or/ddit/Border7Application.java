package kr.or.ddit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableScheduling
@SpringBootApplication
public class Border7Application {

	public static void main(String[] args) {
		SpringApplication.run(Border7Application.class, args);
	}
	
	  @Bean
	    public WebMvcConfigurer corsConfigurer() {
	        return new WebMvcConfigurer() {
	            @Override
	            public void addCorsMappings(CorsRegistry registry) {
	                // React 개발 서버의 기본 포트 3000번을 허용합니다.
	                // 배포 환경에서는 실제 프론트엔드 도메인으로 변경해야 합니다.
	                registry.addMapping("/api/**") // /api로 시작하는 모든 경로에 CORS 적용
	                        .allowedOrigins("http://localhost:3000") // React 개발 서버 주소
	                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // 허용할 HTTP 메서드
	                        .allowedHeaders("*"); // 모든 헤더 허용
	            }
	        };
	    }

}
