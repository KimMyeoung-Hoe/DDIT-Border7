package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Controller
@Slf4j
public class SendMessageController {
	
	@GetMapping("/sendMessage")
	@ResponseBody
	public String sendMessage(String  receiver, String text) {
		log.info("receiver {} ",receiver);
		log.info("text {} ",text);
		String api_key = "NCSAFWQ6HAS3J9UY";
	    String api_secret = "MQAGADBJGGWMGY3BXJZWCXCGI3DBUHB5";
	    String domain = "https://api.coolsms.co.kr";
		DefaultMessageService messageService = NurigoApp.INSTANCE.initialize(api_key, api_secret, domain);
		Message message = new Message();
		message.setFrom("01052803731");
		message.setTo(receiver);//받는사람 번호 : 010******** << 이런식으로 '-' 없애야함
		message.setText(text); //입력할 정보
		
		try {
			messageService.send(message);
			return "SUCCESS";
		}catch (NurigoMessageNotReceivedException e) {
			System.out.println(e.getFailedMessageList());
			System.out.println(e.getMessage());
			 return "FAIL: " + e.getMessage();
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
			 return "FAIL: " + e.getMessage();
		}
	
	}
}
