package kr.or.ddit.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 외부 폴더의 정적 리소스를 특정 URL로 접근할 수 있게 매핑하는 역할.
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // '/qrcode-images/**' URL 요청을 'C:/upload/qrcode/' 폴더와 연결
        registry.addResourceHandler("/qrcode-image/**")
                .addResourceLocations("file:///C:/upload/qrcode/");
    }
}