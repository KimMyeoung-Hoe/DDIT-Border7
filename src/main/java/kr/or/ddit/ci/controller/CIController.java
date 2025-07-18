package kr.or.ddit.ci.controller;

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
import kr.or.ddit.ci.service.ICIService;
import kr.or.ddit.contract.service.IContractService;
import kr.or.ddit.vo.CIVO;
import kr.or.ddit.vo.ContractVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/ci")
public class CIController {
	
	@Autowired
	public ICIService CIService;
	/**
	 * 통관의뢰 서비스
	 */
	@Autowired
	public IContractService contractService;
	
	/**
	 * ci 작성 폼
	 * @param contractNo 통관의뢰 번호
	 * @param model
	 * @return 작성페이지로가즈앙
	 */
	@GetMapping("/form.do")
	public String CIform(String contractNo, Model model) {
		String goPage = "";
		Map<String, String> errors = new HashMap<>();
		if(contractNo == null) {
			errors.put("contractNo", "contractNo 가없음");
			model.addAttribute("errors",errors);
			goPage = "/";
		}else {
			ContractVO contractVO = contractService.selectdeclDToContract(contractNo);
			model.addAttribute("contractNo", contractNo);
			model.addAttribute("contractVO", contractVO);
			goPage="ci/ciform";
		}
		return goPage;
	}

	/**
	 * 
	 * @param req HttpServletRequest 뭐엿지;
	 * @param ciVO
	 * @param model
	 * @param ra 리다이렉트 대상
	 * @return
	 */
	@PostMapping("/insert.do")
	public String CIInsert(HttpServletRequest req, HttpSession session, String contractNo,
			CIVO ciVO, ModelMap model, RedirectAttributes ra) {
		String goPage = "";
		
		log.info("contractNo {}" + contractNo);
		log.info("ciVO {}" + ciVO);
		
		Map<String, String> errors = new HashMap<>();
		if(StringUtils.isBlank(ciVO.getShipper())) {
			errors.put("shipper", "발송인을 입력해 주세요");
		}
		
		if(StringUtils.isBlank(ciVO.getConsignee())) {
			errors.put("getConsignee", "수하인을 입력해주세요");
		}
		
		if(errors.size()>0) {//에러가 발생
			model.addAttribute("errors",errors);
			model.addAttribute("ciVO",ciVO);
			//작성중인 정보 다시뿌려줘야하나?
			goPage = "ci/ciform";
		}else {
			//로그인 처리 후 세션정보에서 얻어 온 회원정보를 가용
			/*
			int userNo = (int) session.getAttribute("userNo");
			ciVO.setConsignorNo(userNo);
			*/
			CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			UserVO user = userSec.getUser();
			ciVO.setConsignorNo(user.getUserNo());
			
			ServiceResult result = CIService.insertCI(ciVO);
			
			if(result.equals(ServiceResult.OK)) {//CI 등록
				//해당 contract에 업데이트
				int ciNo = ciVO.getCiNo();
				log.info("ciNo : {}" + ciNo);
				result = CIService.updateContractCI(contractNo, ciNo);

				//완료후
				if(result.equals(ServiceResult.OK)) {
					ra.addFlashAttribute("message","CI 작성 완료");
					
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
						
					}else {//ci 만 작성되었을때
						goPage = "redirect:/contract/contractdocform.do?contractNo="+contractNo;
					}
					//확인페이지
					//goPage = "redirect:ci/detail.do?ciNo="+ciVO.getCiNo();
				}
			}else{//CI 등록 실패
				model.addAttribute("message", "서버에러, 다시 시도해 주세요");
				goPage = "ci/ciform";
			}
		}
		
		return goPage;
	}
	
	//CI 페이지 요청
	@GetMapping("/detail.do")
	public String CIDetail(int ciNo,Model model) {
		CIVO ciVO = CIService.selectCI(ciNo);
		model.addAttribute("ci",ciVO);
		return "ci/cidetail";
	}
	
	/**
	 * CI 수정 폼으로 이동
	 * @param ciNo
	 * @param model
	 * @return
	 */
	@GetMapping("/update.do")
	public String CIUpdateForm(int ciNo,Model model) {
		CIVO ciVO = CIService.selectCI(ciNo);
		model.addAttribute("ci",ciVO);
		model.addAttribute("status","u");
		return "ci/ciform";
	}
	
	
	@PostMapping("/update.do")
	public String CIUpdate(CIVO ciVO,Model model, RedirectAttributes ra) {
		String goPage="";
		ServiceResult result = CIService.updateCI(ciVO);
		if(result.equals(ServiceResult.OK)) {//수정 성공
			ra.addFlashAttribute("message","수정이 완료되었습니다.");
			goPage = "redirect:/ci/detail.do?ciNo="+ciVO.getCiNo();
		}else {				//수정 실패
			ra.addFlashAttribute("message","수정에 실패했습니다. 다시 시도해 주세요");
			model.addAttribute("ciVO",ciVO);
			model.addAttribute("status","u");
			goPage = "ci/ciform";
		}
		
		return goPage;
	}

}
