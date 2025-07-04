package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import io.micrometer.common.util.StringUtils;
import kr.or.ddit.contract.service.IContractService;
import kr.or.ddit.service.ICCAService;
import kr.or.ddit.service.IConsignorSerivce;
import kr.or.ddit.vo.CCAVO;
import kr.or.ddit.vo.CDVO;
import kr.or.ddit.vo.ContractFileAttachVO;
import kr.or.ddit.vo.ContractRecord;
import kr.or.ddit.vo.ContractVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.KRNotationVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.SanctionVO;
import kr.or.ddit.vo.ShipsVO;
import kr.or.ddit.vo.TaxVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/consignor")
public class ConsignorController {

	@Autowired
	private ICCAService ccaService;
	
	@Autowired
	private IConsignorSerivce consignorService;
	

	/**통관의뢰 서비스*/
	@Autowired
	public IContractService contractService;
	
	// 화주 컨트롤러

	
	// 화주의 내 관세업무계약 조회 페이지
	@PreAuthorize("hasRole('ROLE_CONSIGNOR')")
	@RequestMapping("/myContract.do")
	public String myContract(
							@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
							@RequestParam(required = false )String searchType,
							@RequestParam(required = false) String searchWord,
							@RequestParam(required = false) String searchStatus,
							@RequestParam(required = false) String searchCategory,
							@RequestParam(required = false) String sortDirection, 
							Model model) {

		PaginationInfoVO<ContractVO> pageVo = new PaginationInfoVO<>();
		log.info("넘어온 searchWord : {}" , searchWord);
		log.info("넘어온 searchType : {}" , searchType);
		log.info("넘어온 searchStatus : {}" , searchStatus);
		log.info("넘어온 searchCategory : {}" , searchCategory);
		log.info("넘어온 sortDirection : {}",sortDirection);

		
		if (StringUtils.isNotBlank(searchType)) { // searchType이 비어있지 않다면 (null이나 공백이 아닐 때)
		    pageVo.setSearchType(searchType);
		    model.addAttribute("searchType", searchType);
		}

		// searchWord는 별도로 처리합니다.
		if (StringUtils.isNotBlank(searchWord)) { // searchWord가 비어있지 않다면
		    pageVo.setSearchWord(searchWord);
		    model.addAttribute("searchWord" , searchWord);
		}
		
		if (StringUtils.isNotBlank(searchStatus)) {
			pageVo.setSearchStatus(searchStatus);
			model.addAttribute("searchStatus",searchStatus);
		}
		
		if (StringUtils.isNotBlank(searchCategory)) {
			pageVo.setSearchCategory(searchCategory);
			model.addAttribute("searchCategory",searchCategory);
		}
		
		if (StringUtils.isNotBlank(sortDirection)) {
			pageVo.setSortDirection(sortDirection);
			model.addAttribute("sortDirection",sortDirection);
		}
		
		CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		UserVO user = userSec.getUser();
		
		if (user != null) {
			int userNo = user.getUserNo();
			pageVo.setCurrentPage(currentPage);
			pageVo.setUserNo(userNo);
			int totalRecord = consignorService.selectContract(pageVo);// 총 수
			pageVo.setTotalRecord(totalRecord); // 총 게시글수 전달 후 , 총 페이지 수 설정
			List<ContractVO> selectCCAList = consignorService.selectContractList(pageVo);
			pageVo.setDataList(selectCCAList);

			

			model.addAttribute("pageVo", pageVo);
		}else {
			System.out.println("없음");
		}
		return "consignor/myContract";
	}

	
	// 관세업무계약 작성 페이지
	@GetMapping("/writeContract.do")
	public String writeContract(int ccaNo, Model model) {
		String goPage = null;
		CCAVO ccaVO = ccaService.detailCcaProfile(ccaNo);
		model.addAttribute("ccaVO", ccaVO);
		
		goPage = "consignor/writeContract";
		log.info("ccaVO : {}" +ccaVO);
		return goPage;
	}
	
	// 화주의 관세업무계약 상세 페이지
	@PreAuthorize("hasRole('ROLE_CONSIGNOR')")
	@GetMapping("/detailContract/{contractNo}")
	public String detailContract(@PathVariable String contractNo , Model model) {
		log.info("넘겨받은 contractNo : {}" , contractNo);
		ContractVO detailContract = consignorService.detailContract(contractNo);
		List<ContractRecord> categoryBar = consignorService.categoryBar(contractNo);
		List<ContractFileAttachVO> selectDeclNo = consignorService.selectDeclNo(contractNo);
		KRNotationVO krnotationVO = ccaService.koreanLabelWrite(contractNo);	// 한글표시사항 추가
		ShipsVO shipVO = consignorService.selectShip(contractNo); // 배정보 추가
		
		String selectTaxNo = ccaService.selectTaxNo(contractNo); //delNo
		if (selectTaxNo != null) {
			TaxVO selectTaxList = ccaService.selectTaxList(selectTaxNo); //세금에 대한 결과
			CDVO selectCdList = ccaService.selectCdList(selectTaxNo); //수출입신고필증에 대한 결과
		
			model.addAttribute("TaxVO", selectTaxList);
			model.addAttribute("CDVO", selectCdList);
		}
		
		model.addAttribute("contractVo",detailContract);
		model.addAttribute("categoryBar",categoryBar);
		model.addAttribute("contractDelNo",selectDeclNo);
		model.addAttribute("krNotationVO", krnotationVO);
		model.addAttribute("shipVO",shipVO);
		
		return "consignor/detailMyContract";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_CONSIGNOR','ROLE_CCA')")
	@GetMapping("/findStatusCode/{contractNo}")
	public ResponseEntity<List<ContractRecord>> findStatusCode(@PathVariable String contractNo ,@RequestParam Map<String, String> value){
		String param = value.get("paramName");
		log.info("넘겨받은 contractNo : {}",contractNo);
		log.info("넘어온 값 : " + value.get("paramName"));
		
		List<ContractRecord> statusCode = consignorService.findStatusCode(param , contractNo);
		return new ResponseEntity<List<ContractRecord>>(statusCode,HttpStatus.OK);
	}


	// 관세사 전체 리스트 조회
	@PreAuthorize("hasRole('ROLE_CONSIGNOR')")
	@RequestMapping("/ccaList.do")
	public String ccaList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchWord,
			@RequestParam(required = false) String searchType,Model model) {
		String goPage = null; 
		PaginationInfoVO<CCAVO> pageVo = new PaginationInfoVO<>();
		log.info("넘어온 searchWord {} ", searchWord);
		log.info("넘어온 searchType {} ", searchType);

		if (StringUtils.isNotBlank(searchWord)) {
			pageVo.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}

		if (StringUtils.isNotBlank(searchType)) {
			pageVo.setSearchType(searchType);
			model.addAttribute("searchType", searchType);
		}

		pageVo.setCurrentPage(currentPage);
		int totalRecord = ccaService.selectCCACount(pageVo);// 총 관세사 수
		pageVo.setTotalRecord(totalRecord); // 총 게시글수 전달 후 , 총 페이지 수 설정
		List<CCAVO> selectCCAList = ccaService.selectCCAList(pageVo);
		pageVo.setDataList(selectCCAList);

		model.addAttribute("pageVo", pageVo);
		
		//CI/PL 까지 작성하지 않았을때 임시저장되는 느낌스
		//CI/PL 임시저장은 아직
		CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO user = userSec.getUser();
		int userNO = user.getUserNo();
		ContractVO contractVO = contractService.checkContract(userNO);
		
		if(contractVO != null) {//작성중인 계약이있을때
			String contractNo = contractVO.getContractNo();
			contractVO = contractService.selectContract(contractNo);
			//이어쓰기하기위한 문자열
			String cont = "u";
			goPage = "redirect:/contract/contractdocform.do?contractNo="+contractNo+"&cont="+cont;
		}else {//작성중인 계약없을때;
			goPage="consignor/findcca";
		}
		model.addAttribute("contractVO", contractVO);
		return goPage;
	}

	// 관세사 주력업무 검색
	@PreAuthorize("hasRole('ROLE_CONSIGNOR')")
	@RequestMapping("/checkSpecialtyCodeList")
	public ResponseEntity<PaginationInfoVO<CCAVO>> checkSpecialtyCodeList(
			@RequestBody Map<String, Object> param) {
		log.info("# param1 : " + param.get("pageNo"));
		log.info("# param2 : " + ((List<String>)param.get("specialtyNameList")).get(0));
	
		int pageNo = 1;
		Object obj = param.get("pageNo");	// 타입이 Object 이고, null안경우 toString() 과 같은 메서드 활용 불가
		if(obj != null) {
			pageNo = Integer.parseInt(obj.toString());
		}
		List<String> specialtyCodes = (List<String>) param.get("specialtyNameList");
		PaginationInfoVO<CCAVO> pageVo = new PaginationInfoVO<>();

		pageVo.setCurrentPage(pageNo);
		int totalRecord = ccaService.checkSpecialTypCodeCount(pageVo, specialtyCodes);// 총 관세사 수
		pageVo.setTotalRecord(totalRecord); // 총 게시글수 전달 후 , 총 페이지 수 설정
		List<CCAVO> selectCCAList = ccaService.checkSpecialtyCodeList(pageVo , specialtyCodes);
		pageVo.setDataList(selectCCAList);

		return new ResponseEntity<PaginationInfoVO<CCAVO>>(pageVo,HttpStatus.OK);
	}

	// 관세사 상세조회
	@PreAuthorize("hasRole('ROLE_CONSIGNOR')")
	@GetMapping("/detailCcaProfile/{ccaNo}")
	public String detailCcaProfile(@PathVariable int ccaNo, Model model) {
		log.info("detailCcaProfile 호출");
		CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO user = userSec.getUser();
		
		if (user!= null) {
			int consignorNo = user.getUserNo();
			List<ContractVO> selectContractWithMe = ccaService.selectContractWithMe(ccaNo,consignorNo);
			List<SanctionVO> sanctionScoreList = ccaService.selectSanctionScore(ccaNo);
			SanctionVO selectSanctionTotlaScore = ccaService.selectSanctionTotlaScore(ccaNo);
			model.addAttribute("withMeContract",selectContractWithMe);//이관세사가 나랑 계약한 내역ㅇㅇ
			model.addAttribute("sanctionScoreList",sanctionScoreList);//관세사의 오류 부과 내역
			model.addAttribute("totalScore",selectSanctionTotlaScore);//관세사의 토탈 오류 점수
			
		}
		CCAVO ccavo = ccaService.detailCcaProfile(ccaNo);
		model.addAttribute("ccavo", ccavo);
		return "cca/ccaProfile";
	}

}
