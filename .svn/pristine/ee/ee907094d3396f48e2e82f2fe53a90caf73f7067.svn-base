package kr.or.ddit.security;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {
	@GetMapping("/accessError")
	public String accessDenied(Authentication auth, Model model) {
		log.info("accessDenied() 실행");
		log.info("Authentication 정보");
		
		if (auth != null) {
			log.info("auth : {}" + auth.toString());
		} else {
			log.info("auth : 비로그인 사용자 접근");
		}
		model.addAttribute("msg", "accessDenied");
		return "redirect:/login/loginForm.do"; 

	}
	
}	
