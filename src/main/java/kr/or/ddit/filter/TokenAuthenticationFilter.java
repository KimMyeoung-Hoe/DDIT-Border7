//package kr.or.ddit.filter;
//
//import java.io.IOException;
//
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.web.filter.OncePerRequestFilter;
//
//import jakarta.servlet.FilterChain;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import kr.or.ddit.util.TokenProvider;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//public class TokenAuthenticationFilter extends OncePerRequestFilter{
//	
//	// 전반적인 토큰 생성, 토큰 검증 등 기능을 담당하는 객체
//	private TokenProvider tokenProvider;
//	
//	private final static String HEADER_AUTHORIZATION = "Authorization";
//	private final static String TOKEN_PREFIX = "Bearer ";
//	
//	public TokenAuthenticationFilter(TokenProvider tokenProvider) {
//		this.tokenProvider = tokenProvider;
//	}
//	
//	@Override
//	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
//			throws ServletException, IOException {
//		log.info("# TokenAuthenticationFilter.doFilterInternal->Msg : Filter execution...!");
//		
//		String authorizationHeader = request.getHeader(HEADER_AUTHORIZATION);
//		String token = getAccessToken(authorizationHeader);
//		if(token != null && tokenProvider.validToken(token)) {
//			Authentication authentication = tokenProvider.getAuthentication(token);
//			SecurityContextHolder.getContext().setAuthentication(authentication);
//		}
//		filterChain.doFilter(request, response);
//	}
//	
//	private String getAccessToken(String authorizationHeader) {
//		// 'Authorization' 키 값이 unll이 아니고, 'Bearer ' 식별자로 시작하는 헤더 값이라면 토큰 분리
//		if(authorizationHeader != null && authorizationHeader.startsWith(TOKEN_PREFIX)) {
//			return authorizationHeader.substring(TOKEN_PREFIX.length());
//		}
//		return null;
//	}
//}
