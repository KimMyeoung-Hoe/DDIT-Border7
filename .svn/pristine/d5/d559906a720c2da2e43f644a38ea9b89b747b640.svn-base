package kr.or.ddit.security;

import java.io.IOException;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

// 로그인 실패 처리자
@Slf4j
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(
	        HttpServletRequest request,
	        HttpServletResponse response,
	        AuthenticationException exception) throws IOException, ServletException {

	    log.info("CustomLoginFailureHandler.onAuthenticationFailure() 실행");
	    log.info("exception : {}", exception.getMessage());

	    HttpSession session = request.getSession();
	    
	    if (exception instanceof org.springframework.security.authentication.DisabledException) {
	        session.setAttribute("loginErrorType", "disabled");        
	        session.setAttribute("loginError", "탈퇴한 회원입니다.");
	    } else {
	        session.setAttribute("loginErrorType", "invalid");         
	        session.setAttribute("loginError", "아이디 또는 비밀번호가 잘못되었습니다.");
	    }

	    response.sendRedirect("/login/loginForm.do");
	}
}


    

