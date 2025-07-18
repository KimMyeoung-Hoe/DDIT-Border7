package kr.or.ddit.pl.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.contract.service.IContractService;
import kr.or.ddit.pl.service.IPLService;
import kr.or.ddit.vo.ContractVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.PLVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/pl")
public class PLController {

	@Autowired
	public IPLService plService;
	/**
	 * 통관의뢰 서비스
	 */
	@Autowired
	public IContractService contractService;
	
	@GetMapping("/form.do")
	public String PLform(String contractNo, Model model) {
		String goPage = "";
		Map<String, String> errors = new HashMap<>();
		if(contractNo == null) {
			errors.put("contractNo", "contractNo 가없음");
			model.addAttribute("errors",errors);
			goPage = "/";
		}else {
			ContractVO contractVO = contractService.selectdeclDToContract(contractNo);
			model.addAttribute("contractVO", contractVO);
			model.addAttribute("contractNo", contractNo);
			goPage="pl/plform";
		}
		return goPage;
	}
	
	/**
	 * 
	 * @param req
	 * @param contractNo
	 * @param plVO
	 * @param model
	 * @param ra
	 * @return
	 */
	@PostMapping("/insert.do")
	public String PlInsert(HttpServletRequest req, HttpSession session, String contractNo,
			PLVO plVO , ModelMap model, RedirectAttributes ra) {
		String goPage = "";
		log.info("plinsert실행 plVO : {}" + plVO);
		Map<String, String> errors = new HashMap<>();
		if(StringUtils.isBlank(plVO.getShipper())) {
			errors.put("shipper", "발송인을 입력해 주세요");
		}
		
		if(StringUtils.isBlank(plVO.getConsignee())) {
			errors.put("getConsignee", "수하인을 입력해주세요");
		}
		
		if(errors.size()>0) {//에러가 발생
			model.addAttribute("errors",errors);
			model.addAttribute("plVO",plVO);
			//작성중인 정보 다시뿌려줘야하나?
			goPage = "pl/plform";
		}else {
			//로그인 처리 후 세션정보에서 얻어 온 회원정보를 가용
			/*
			int userNo = (int) session.getAttribute("userNo");
			plVO.setConsignorNo(userNo);
			*/
			CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			UserVO user = userSec.getUser();
			plVO.setConsignorNo(user.getUserNo());
			
			
			ServiceResult result = plService.insertPL(plVO);
			
			if(result.equals(ServiceResult.OK)) {//PL 등록
				//해당 contract에 업데이트
				int plNo = plVO.getPlNo();
				log.info("plNo : {}" + plNo);
				result = plService.updateContractPL(contractNo, plNo);
				
				//완료후
				if(result.equals(ServiceResult.OK)) {
					ra.addFlashAttribute("message","PL 작성 완료");
					
					int lastStatusCode = contractService.getStatusCode(contractNo);
					log.info("lastStatusCode : {}" + lastStatusCode);
					//ci, pl 모두 작성되었을때 lastStatusCode에 값추가하여 완료 처리가 되고 0보다 큰값이올거임
					//이력에 추가
					if(lastStatusCode > 0) {
						
						result = contractService.insertContractRecord(contractNo);
						if(result.equals(ServiceResult.OK)) {
							
							//goPage = "redirect:/contract/contractdetail.do?contractNo="+contractNo;//상세페이지
							//goPage = "redirect:/consignor/detailContract/"+contractNo;//상세페이지
							goPage = "redirect:/contract/contractdocform.do?contractNo="+contractNo;
						}else {
							
							model.addAttribute("message", "이력등록 중 서버에러, 다시 시도해 주세요");
							goPage = "redirect:/contract/contractdocform.do?contractNo="+contractNo;
						}
						
					}else {
						goPage = "redirect:/contract/contractdocform.do?contractNo="+contractNo;						
					}
				
					//확인페이지
					//goPage = "redirect:/pl/detail.do?plNo="+plVO.getPlNo();
				}
				
			}else{//PL 등록 실패
				model.addAttribute("message", "서버에러, 다시 시도해 주세요");
				goPage = "pl/plform";
			}
		}
		return goPage;
	}
	
	
	@GetMapping("/detail.do")
	public String PLDetail(int plNo,Model model) {
		PLVO plVO = plService.selectPL(plNo);
		model.addAttribute("pl",plVO);
		return "pl/pldetail";
	}
	
}
