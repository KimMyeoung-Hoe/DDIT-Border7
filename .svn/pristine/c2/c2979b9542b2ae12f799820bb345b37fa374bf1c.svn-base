package kr.or.ddit.config;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import jakarta.servlet.DispatcherType;
import kr.or.ddit.security.CustomAccessDeniedHandler;
import kr.or.ddit.security.CustomLoginFailureHandler;
import kr.or.ddit.security.CustomLoginSuccessHandler;
import kr.or.ddit.security.CustomUserDetailsService;
import kr.or.ddit.user.service.IUserService;
import kr.or.ddit.user.service.UserServiceImpl;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true) 
public class SecurityConfig {

	@Autowired
	private CustomUserDetailsService customUserDetailsService;
	
	@Bean
	public WebSecurityCustomizer configure() {
	    return (web) -> web.ignoring()
	                      .requestMatchers(new AntPathRequestMatcher("/resources/**"));			//WEB-INF/views 라서 접근안됨 
	}
	
	@Bean 
    public IUserService userService() { // 이후 삭제 예정
        return new UserServiceImpl();
    }
	
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
	    http.csrf((csrf) -> csrf.disable());
	    http.httpBasic((hbasic) -> hbasic.disable());
	    
	    // CORS 필터를 적용합니다.
        http.cors(Customizer.withDefaults()); 
        
	    http.authorizeHttpRequests(
	        (authorize) -> 
	            authorize.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ASYNC).permitAll()
	            .requestMatchers(PathRequest.toStaticResources().atCommonLocations()).permitAll()
	            // WebSocket 허용
	            .requestMatchers("/signaling/**").permitAll() // web 소켓용
	            .requestMatchers("/**").permitAll()
//	            .requestMatchers("/resources/**", "/css/**").permitAll()
//	            .requestMatchers("/", "/login/**").permitAll()
	            .anyRequest().authenticated()
	    );

		// 사용자 정의 접근 거부 처리자
		http.exceptionHandling(exception -> 
	    	exception.accessDeniedHandler(new CustomAccessDeniedHandler())
		);
		
		// 사용자 정의 로그인 처리자
		http.formLogin(login -> 
		    login.loginPage("/login/loginForm.do") 
		    	.loginProcessingUrl("/login")
		        .successHandler(new CustomLoginSuccessHandler(userService()))
		        .failureHandler(new CustomLoginFailureHandler())
		);

		// 로그아웃 처리
		http.logout((logout) -> 
			logout.logoutUrl("/logout")	
			.invalidateHttpSession(true)					// 로그아웃 시, 세션 삭제
			.logoutSuccessUrl("/")
			.deleteCookies("JSESSION_ID"));					// 로그아웃 시, 쿠키 삭제
		
		return http.build();
	}
	
	@Bean
	protected PasswordEncoder passwordEncoder() {
	    return new BCryptPasswordEncoder();
	}

	@Bean
	protected AuthenticationManager authenticationManager(
	        BCryptPasswordEncoder bCryptPasswordEncoder,
	        UserDetailsService detailsService) {

	    DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
	    authProvider.setUserDetailsService(detailsService);  
	    authProvider.setPasswordEncoder(bCryptPasswordEncoder);  

	    return new ProviderManager(authProvider);
	}
	 // --- CORS 설정 시작 ---
    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        // 모든 출처를 허용합니다. (개발 시에만 사용하고, 프로덕션에서는 특정 출처를 지정하세요)
        configuration.setAllowedOrigins(Arrays.asList("*")); 
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(Arrays.asList("*"));
        configuration.setAllowCredentials(true); // 자격 증명 허용 (쿠키, HTTP 인증)
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration); // 모든 경로에 CORS 설정 적용
        return source;
    }
    // --- CORS 설정 끝 ---
}
