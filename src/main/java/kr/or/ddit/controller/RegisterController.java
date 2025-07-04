package kr.or.ddit.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.user.service.IUserService;
import kr.or.ddit.util.UploadFileUtils;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/register")
public class RegisterController {
	
	@Autowired
	private IUserService userService;
	
	
	// 회원가입 메인 페이지
	@PreAuthorize("true")
	@GetMapping("/main.do")
	public String registerMain() {
		return "register/main";
	}
	
	// 회원가입 폼페이지
	@PreAuthorize("true") 
	@GetMapping("/form.do")
	public String registerForm(@RequestParam("auth") String  userAuth, Model model) {
		model.addAttribute("userAuth",userAuth);
		return "register/form";
	}
	
	// 아이디 중복 체크
	@PreAuthorize("true") 
	@GetMapping("/idCheck.do")
	@ResponseBody
	public int checkId(@RequestParam("userId") String userId) {
		
		System.out.println(userId);
		
		return userService.checkId(userId);
	}
	
	@PreAuthorize("true") 
	@PostMapping("/regist.do")
	public ResponseEntity<Map<String, Object>> registeDo(
			UserVO userVO,
			HttpServletRequest request 
			) {
		System.out.println("userVO : " + userVO);

		
		Map<String, Object> response = new HashMap<>();
		response.put("result", 0);
		
		
		String filepath = fileupload(userVO);
		if(filepath != null && filepath != "") {			
			if(userVO.getAuthCode().equals("ROLE_CCA")) {
				userVO.getCcaVO().setCcaProfileImg(filepath);
			}else if(userVO.getAuthCode().equals("ROLE_LOGISTICS")) {
				userVO.getLogistMngVO().setLogistMngProfileImg(filepath);
			}else if(userVO.getAuthCode().equals("ROLE_CONSIGNOR")){
				userVO.getConsignorVO().setConsignorProfileImg(filepath);
			}
		}
		
		ServiceResult result = userService.registUser(userVO);
		if(result==result.OK) {
			response.put("result", 1);
		}
		
		return new ResponseEntity<>(response,HttpStatus.OK);
	}
	
	private String fileupload(UserVO userVO) {

		String uploadPath = "C:/upload";
		
		String saveName = null;
		MultipartFile file = null;
		// 파일 업로드 처리 후 등록
		log.info("파일업로드 실행");
		if(userVO.getCcaVO()!=null && userVO.getCcaVO().getCcapfImg() != null){
			file = userVO.getCcaVO().getCcapfImg();
		}else if(userVO.getConsignorVO()!=null && userVO.getConsignorVO().getConsignorpfImg() != null) {
			file = userVO.getConsignorVO().getConsignorpfImg();
		}else if(userVO.getLogistMngVO()!=null && userVO.getLogistMngVO().getLogisticspfImg() !=null) {
			file = userVO.getLogistMngVO().getLogisticspfImg();
		}else {
			return "";
		}
		
		try {
			saveName = UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return saveName;
	}
}	
	