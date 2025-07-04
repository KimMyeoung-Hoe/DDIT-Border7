package kr.or.ddit.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.user.service.IUserService;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestBody;


@Slf4j
@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Autowired
	public IUserService userService;
	
	// 로그인메인 페이지
	@PreAuthorize("true") 
	@GetMapping("/loginForm.do")
	public String loginForm(String error, String logout, Model model) {
		log.info("error : {}", error);
		log.info("logout : {}", logout);
		if (error != null) {
			model.addAttribute("error", error);
		}
		if (error != null) {
			model.addAttribute("logout", logout);
		}
		return "login/loginForm";
	}
	
	@PreAuthorize("true") 
	@PostMapping("/findid.do")
	public ResponseEntity<String> findid(@RequestBody UserVO user) {
	    log.info("findid()->user : {}", user);
	    
	    String userId = userService.findId(user);
	    
	    if(userId != null && !userId.isEmpty()) {
	        return ResponseEntity.ok(userId);
	    } else {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("잘못된 값입니다. 다시 입력해 주세요.");
	    }
	}
	
	@PreAuthorize("true") 
	@PostMapping("/findpw.do")
	public ResponseEntity<String> findpw(@RequestBody UserVO user) {
	    log.info("findpw()->user : {}", user);
	    
	    String userPw = userService.findpw(user);
	    		
	    if(userPw.equals("1")) {
	    	return ResponseEntity.ok(userPw);
	    } else {
	    	return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("잘못된 값입니다. 다시 입력해 주세요.");
	    }
	}
	
	@PreAuthorize("true") 
	@PostMapping("/changepw.do")
	public ResponseEntity<String> changepw(@RequestBody UserVO user) {
		log.info("changepw()->changePW : {}", user);
		
		int result = userService.updatePw(user);
		
		if(result == 1) {
			return ResponseEntity.ok("비밀번호 변경 성공");
		} else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("비밀번호 변경에 실패하였습니다.");
		}
	}
}
