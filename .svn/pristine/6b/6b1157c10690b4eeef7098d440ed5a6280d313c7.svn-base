package kr.or.ddit.servant.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.servant.service.IServantService;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("doc")
public class DocumentController {

	@Autowired
	private IServantService servantService;
	
	@PreAuthorize("true")
	@GetMapping("taxBill.do")
	public String docTaxDetail(
			@RequestParam String declNo,
			Model model) {
		log.info("docTaxDetail() -> declNo : {}", declNo);
		Map<String, Object> taxMap = servantService.getTaxBill(declNo);
		model.addAttribute("taxMap", taxMap);
		return "doc/taxBill";
	}
}
