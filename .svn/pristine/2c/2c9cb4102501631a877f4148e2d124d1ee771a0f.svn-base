package kr.or.ddit.security;

import java.io.IOException;
import java.security.Principal;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.AccessDeniedHandler;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	// 사용자 정의 접근 거부자  
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
	                   AccessDeniedException accessDeniedException) throws IOException {
		
	    log.info("AccessDeniedException : {}", accessDeniedException.getMessage());
	    
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    Principal principal = request.getUserPrincipal();
	    
	    if (auth != null) {
	    	log.info("# 접근 거부 - 사용자 ID: {}", principal.getName());
	    }

	    // 접근 거부 시 로그인 페이지로 이동
	    response.sendRedirect("/login/loginForm.do"); 
	}

}
