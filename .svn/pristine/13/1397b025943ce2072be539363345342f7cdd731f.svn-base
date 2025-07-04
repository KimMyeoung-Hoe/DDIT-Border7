package kr.or.ddit.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//파일 업로드 시, local 경로에 파일을 업로드하기 위한 설정
@Configuration
public class FileConfiguration implements WebMvcConfigurer{

	//local 패스 경로에 업로드 한 파일을 맵핑하기 위해 local 패스와 웹 경로를 맵핑한다.
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		//매핑경로설정 //웹경로 비슷하게 일치시키는게 편할거임
		registry.addResourceHandler("/upload/**").
			addResourceLocations("file:///C:/upload/");///로컬 페스 경로임
		//
		WebMvcConfigurer.super.addResourceHandlers(registry);
	}
	
	@Override
	public void addCorsMappings(CorsRegistry registry) {
	    registry.addMapping("/**")
	            .allowedOrigins("*")
	            .allowedMethods("*")
	            .allowedHeaders("*");
	}
}
