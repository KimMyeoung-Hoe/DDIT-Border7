package kr.or.ddit.security;

import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.user.service.IUserService;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;
@Component
@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	private final IUserService userService;
	private final RequestCache requestCache;
	
	@Autowired
	public CustomLoginSuccessHandler(IUserService userService) {
	    this.userService = userService;
	    this.requestCache = new HttpSessionRequestCache();
	}
	    
	@Override
	public void onAuthenticationSuccess(
	    HttpServletRequest request,
	    HttpServletResponse response,
	    Authentication authentication) throws IOException, ServletException {
	    
	    // 1. 로그인 성공 이벤트 기록
	    log.info("CustomLoginSuccessHandler.onAuthenticationSuccess() 실행");
	    
	    // 2. 사용자 정보 조회 및 검증
	    User user = (User) authentication.getPrincipal();
	    if (user.isEnabled()) {
	        log.info("username : {}", user.getUsername());
	        log.info("password : {}", user.getPassword());
	    }
	    
	    // 3. 사용자 권한 정보 로깅
	    Collection<GrantedAuthority> grantedAuthority = user.getAuthorities();
	    Iterator<GrantedAuthority> ite = grantedAuthority.iterator();
	    while (ite.hasNext()) {
	        GrantedAuthority authority = ite.next();
	        log.info("## auth : {}", authority.getAuthority());
	    }
	    
	    // 4. 인증 관련 속성 정리
	    clearAuthenticationAttribute(request);
	    
	    // 5. 리디렉션 처리
	    String targetUrl = "/";    				// 초기화 시는 default가 root가 되도록 "/"로 설정
	    
	    log.info("## Login Success Target Url : {}",targetUrl);
	    
	    HttpSession session = request.getSession();
        
        String authCode = authentication.getAuthorities().stream()
                .findFirst()
                .map(GrantedAuthority::getAuthority)
                .orElse("ROLE_ANONYMOUS"); // 비회원의 ROLE
        
        // userService, 와 setAttribute, config의 생성자 부분 추후 삭제 예정
        UserVO userVo = userService.userInfo(authentication.getName());

        session.setAttribute("auth", authCode);
        session.setAttribute("userId", authentication.getName());
        session.setAttribute("userNo", userVo.getUserNo());
        
        System.out.println("auth : " + authCode);
        System.out.println("userId : " + authentication.getName());
        System.out.println("userNo : " + userVo.getUserNo());

//      6. 최종 리디렉션 처리
//	    SecurityContextHolder sc = null;
//	    String principal = sc.getContext().getAuthentication().getPrincipal().toString();
//	    System.out.println(principal);
//	    kr.or.ddit.vo.CustomUser [Username=1234, Password=[PROTECTED], Enabled=true
//	    		, AccountNonExpired=true, CredentialsNonExpired=true
//	    		, AccountNonLocked=true, Granted Authorities=[ROLE_CONSIGNOR]]
        
	    response.sendRedirect(targetUrl);
	}

	private void clearAuthenticationAttribute(HttpServletRequest request) {
		
		// getSession(false) 세션정보가 없으면 null을 반환 있으면 정보를 반환
		HttpSession session = request.getSession(false);
		
		if (session == null) {
			return;
		}
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}
}
