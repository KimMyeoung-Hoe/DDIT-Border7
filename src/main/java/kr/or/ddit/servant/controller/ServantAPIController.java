package kr.or.ddit.servant.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
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
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.servant.service.IServantService;
import kr.or.ddit.vo.BwVO;
import kr.or.ddit.vo.DeclVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/servant/api")
public class ServantAPIController {
	
	@Autowired
	private IServantService servantService;
	
	// 공무원의 캘린더 기능 . 웹메일기능은 mypage로 연결
	@GetMapping("/myCalendar.do")
	public String servantMyCalendar() {
		return "mypage/myCalendar";
	}
	@GetMapping("/myMail.do")
	public String servantMyMail() {
		return "mypage/myMail";
	}
	

	//  기존 react page 컨트롤러
//	// 상위공무원 업무 페이지
//	@GetMapping("/mandarinWork.do")
//	public String servantMandarinWork() {
//		return "servant/mandarinWork";
//	}
	
//	// 행정공무원 업무 페이지
//	@PostMapping("/adminWorkList.do")
//	public ResponseEntity<PaginationInfoVO<DeclVO>> servantAdminWork(HttpServletRequest request, int page) {
//		
//		PaginationInfoVO<DeclVO> pagingVO = new PaginationInfoVO<>(8,8);
//		pagingVO.setCurrentPage(page);
//		
//		// 헤더에서 token값 추출
//		String token = request.getHeader("Authorization").replace("Bearer ", "");
//		
//		//token값에서 회원정보를 받아 배정된 업무의 수를 조회
//		int totalRecord = servantService.selectWorkCount(token);
//		pagingVO.setTotalRecord(totalRecord);
//		
//		// token값에서 회원정보를 받아 배정된 업무 내역을 페이징하여 출력
//		List<DeclVO> declList = servantService.selectWorkList(pagingVO, token);
//		pagingVO.setDataList(declList);
//		
//		return ResponseEntity.ok().body(pagingVO);
//	}
//	
//	// 검사/검역공무원 업무 페이지
//	@GetMapping("/quarantineWork.do")
//	public String servantQuarantineWork() {
//		return "servant/quarantineWork";
//	}
	
	// 입고된 모든 물품
		@PreAuthorize("hasAnyRole('ROLE_SVT_ADMIN', 'ROLE_SVT_QUARANTINE', 'ROLE_SVT_MANDARIN')")
		@ResponseBody
		@GetMapping("/ajaxcurrentBwList.do")
		public ResponseEntity<Map<String, Object>> currenctBwList(
				@RequestParam(required = false) String searchType,
				@RequestParam(required = false) String searchWord,
				@RequestParam(required = false, defaultValue = "BW_ARRIVAL_DATE") String sortColumn,
				@RequestParam(required = false, defaultValue = "desc") String sortDirection,
				@RequestParam(required = false, defaultValue = "1") int currentPage,
				Model model) {

	

			PaginationInfoVO<Map<String, Object>> pagingVO = new PaginationInfoVO<>();
			
		
			if(StringUtils.isNotBlank(searchWord)) {
				if(StringUtils.isNotBlank(searchType)) {
					pagingVO.setSearchType(searchType);
					pagingVO.setSearchWord(searchWord);
				}
			}
			
			if(StringUtils.isNotBlank(sortColumn)) {
				pagingVO.setSortColumn(sortColumn);
			}
				
			if(StringUtils.isNotBlank(sortDirection)) {
				pagingVO.setSortDirection(sortDirection);
			}
			
			
			pagingVO.setCurrentPage(currentPage);

			
			Map<String, Object> map = new HashMap<>();

			int shipmentTotalRecode = servantService.AllTotalRecode(pagingVO);
			pagingVO.setTotalRecord(shipmentTotalRecode);
			List<BwVO> crtBw = servantService.bwAwaiteAll(pagingVO);
			model.addAttribute("crtBw", crtBw);
			
			map.put("crtBw", crtBw);
			map.put("paginationInfo", pagingVO);
			return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}
	
	// 반입
	@PreAuthorize("hasAnyRole('ROLE_SVT_ADMIN', 'ROLE_SVT_QUARANTINE', 'ROLE_SVT_MANDARIN')")
	@ResponseBody
	@GetMapping("/bwAwaitReceive.do")
	public  ResponseEntity<Map<String, Object>> bwAwaitReceive(
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchWord,
			@RequestParam(required = false, defaultValue = "decl_recept_date") String sortColumn,
			@RequestParam(required = false, defaultValue = "desc") String sortDirection,
			@RequestParam(required = false, defaultValue = "1") int currentPage,
			Model model) {
	
		log.info("searchType {}" , searchType);
		log.info("searchWord {}" , searchWord);
		PaginationInfoVO<Map<String, Object>> pagingVO = new PaginationInfoVO<>();
		
		
		if(StringUtils.isNotBlank(searchWord)) {
			if(StringUtils.isNotBlank(searchType)) {
				pagingVO.setSearchType(searchType);
				pagingVO.setSearchWord(searchWord);
			}
		}
		
		if(StringUtils.isNotBlank(sortColumn)) {
			pagingVO.setSortColumn(sortColumn);
		}
			
		if(StringUtils.isNotBlank(sortDirection)) {
			pagingVO.setSortDirection(sortDirection);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int ReceiveTotalRecode = servantService.ReceiveTotalRecode(pagingVO);
		pagingVO.setTotalRecord(ReceiveTotalRecode);
		model.addAttribute("pagingVO", pagingVO);
		
		List<DeclVO> bwAwaitlist = servantService.bwAwaitReceive(pagingVO);
		model.addAttribute("bwAwaitlist",bwAwaitlist);

		Map<String, Object> map = new HashMap<>();
		map.put("bwAwait", bwAwaitlist);
		map.put("paginationInfo", pagingVO);
		
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		
	
	}
	
	// 반출
	@PreAuthorize("hasAnyRole('ROLE_SVT_ADMIN', 'ROLE_SVT_QUARANTINE', 'ROLE_SVT_MANDARIN')")
	@ResponseBody
	@GetMapping("/bwAwaitshipment.do")
	public ResponseEntity<Map<String, Object>> bwAwaitshipment(
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchWord,
			@RequestParam(required = false, defaultValue = "cd_date") String sortColumn,
			@RequestParam(required = false, defaultValue = "desc") String sortDirection,
			@RequestParam(required = false, defaultValue = "1") int currentPage,
			Model model) {
	
		PaginationInfoVO<Map<String, Object>> pagingVO = new PaginationInfoVO<>();
		
		
		if(StringUtils.isNotBlank(searchWord)) {
			if(StringUtils.isNotBlank(searchType)) {
				pagingVO.setSearchType(searchType);
				pagingVO.setSearchWord(searchWord);
			}
		}
		
		if(StringUtils.isNotBlank(sortColumn)) {
			pagingVO.setSortColumn(sortColumn);
		}
			
		if(StringUtils.isNotBlank(sortDirection)) {
			pagingVO.setSortDirection(sortDirection);
		}
	
		pagingVO.setCurrentPage(currentPage);
		
		int shipmentTotalRecode = servantService.shipmentTotalRecode(pagingVO);
		pagingVO.setTotalRecord(shipmentTotalRecode);
		
		
		List<BwVO> crtBw = servantService.bwAwaitshipment(pagingVO);
		
		Map<String, Object> map = new HashMap<>();
		map.put("crtBw", crtBw);
		map.put("paginationInfo", pagingVO);
		
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}
		
	
}
