package kr.or.ddit.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.eclipse.tags.shaded.org.apache.xalan.templates.ElemValueOf;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.actuate.autoconfigure.observation.ObservationProperties.Http;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.annotation.JacksonInject.Value;
import com.google.gson.Gson;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.ILogisticsService;
import kr.or.ddit.vo.ContainerDetailVO;
import kr.or.ddit.vo.ContainerVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StowageVO;
import kr.or.ddit.vo.UserVO;
import kr.or.ddit.vo.WarehouseVO;
import kr.or.ddit.vo.WhDetailVO;
import lombok.extern.slf4j.Slf4j;

@CrossOrigin("*")
@Slf4j
@Controller
@RequestMapping("/logistics")
public class LogisticsController {
	
	@Autowired
	private ILogisticsService logisticsService;

	// 통계를 위한(?) 전체 물류창고 목록 호출
	@GetMapping("/allWarehouse.do")
	public String allWarehouse(Model model) {		
		// 전체목록 
		List<WarehouseVO> warehouseListAll = logisticsService.warehouseListAll();
		model.addAttribute("warehouseListAll",warehouseListAll);
	
		return "";
	}
	
	// 물류관리자의 물류창고 관리페이지
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@GetMapping("/myWarehouse.do")
	public String logisticsMyWarehouse(
			@RequestParam("userId") String userId
		    ,@RequestParam(value = "searchType", required = false, defaultValue = "") String searchType // 검색 타입
		    ,@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord // 검색 키워드
		    ,@RequestParam(value = "sortColumn", required = false, defaultValue = "WH_REG_DATE DESC") String sortColumn // 정렬 컬럼 (기본값: 적재일)
		    ,@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage // 현재 페이지 (기본값: 1)
		    ,Model model
			) {
		
		PaginationInfoVO<WarehouseVO> pagingVO = new PaginationInfoVO<>();
		pagingVO.setUserId(userId);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setSortColumn(sortColumn);
		pagingVO.setCurrentPage(currentPage);
		
		System.out.println("pagingVO : "+pagingVO);
		
		int totalCount = logisticsService.getWhCount(pagingVO);
		
		pagingVO.setTotalRecord(totalCount);
		System.out.println("totalCount : "+totalCount);
		
		
		List<WarehouseVO> warehouseList = logisticsService.warehouseList(pagingVO);
		
		model.addAttribute("warehouseList",warehouseList);
		model.addAttribute("paginationInfo", pagingVO);
		
		// 검색어 저장시켜서 리턴
		model.addAttribute("searchType",searchType);
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("sortColumn",sortColumn);
		
		System.out.println("warehouseList : "+warehouseList);
		System.out.println("pagingVO : "+pagingVO);
		
		return "logistics/myWarehouse";
	}
	
	// 물류관리자의 물류창고 상세 페이지 호출 (정렬, 검색, 페이지네이션 기능 추가)
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@GetMapping("/warehouseDetail.do")
	public String warehouseDetail(
	        @RequestParam("whNo") int whNo, // 필수 파라미터: 창고 번호
	        @RequestParam(value = "searchType", required = false, defaultValue = "") String searchType, // 검색 타입
	        @RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord, // 검색 키워드
	        @RequestParam(value = "sortColumn", required = false, defaultValue = "WH_LOADING_DATE DESC") String sortColumn, // 정렬 컬럼 (기본값: 적재일)
	        @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage, // 현재 페이지 (기본값: 1)
	        Model model
	) {
		
		// 기본정보를 담은 객체 생성
		WarehouseVO warehouseVO = logisticsService.warehouseBasicInfo(whNo);
		model.addAttribute("warehouseVO",warehouseVO);
		System.out.println("warehouseVO : "+warehouseVO);
	    // PaginationInfoVO 객체 생성 및 파라미터 설정
	    PaginationInfoVO<WhDetailVO> pagingVO = new PaginationInfoVO<>();
	    pagingVO.setWhNo(whNo); // 특정 창고 번호 설정 (추가된 필드)
	    pagingVO.setSearchType(searchType);
	    pagingVO.setSearchWord(searchWord);
	    pagingVO.setSortColumn(sortColumn);
	    pagingVO.setCurrentPage(currentPage); // currentPage 설정 시 startRow, endRow 자동 계산
	    // 총 개수 조회
	    int totalCount = logisticsService.getWhDetailCount(pagingVO);
	    pagingVO.setTotalRecord(totalCount); // totalRecord 설정 시 totalPage 자동 계산
	    /** 페이지네이션 한 페이지에 보일 갯수*/
	    pagingVO.setScreenSize(5);
	    
	    System.out.println("totalCount : "+totalCount);
	    // 물류창고 상세 항목 목록 조회 (페이지네이션, 정렬, 검색 적용)
	    List<WhDetailVO> whDetList = logisticsService.warehouseDetail(pagingVO);
	    
	    if (whDetList == null || whDetList.isEmpty()) {
	        model.addAttribute("whDetListMessage", "해당 창고에는 아직 적재된 상품이 없습니다.");
	    } else {
	    	model.addAttribute("whDetList", whDetList);
	    }

	    
	    // Model에 데이터 추가
	    model.addAttribute("whNo",whNo);
	    model.addAttribute("paginationInfo", pagingVO); // PaginationInfoVO 객체 자체를 전달
	    // 나머지 개별 페이지네이션 정보는 pagingVO에서 가져올 수 있음
	    // 검색조건 리턴
	    model.addAttribute("searchType",searchType);
	    model.addAttribute("searchWord",searchWord);
	    model.addAttribute("sortColumn",sortColumn);
	    
	    System.out.println("whDetList : "+whDetList);
	    System.out.println("paginationInfo : "+pagingVO);
	    
		return "logistics/warehouseDetail";
	}
	// 물류창고 상세물품상태 변경 
	@ResponseBody
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@PostMapping("/updateWhDetailStatus.do")
	public int updateWhDetailStatus(@RequestBody WhDetailVO whDetailVO , Model model) {
		
		log.info("updateWhDetailStatus->whDetailVO : " + whDetailVO);
		
		ServiceResult result = null;
		
		int cnt = 0;
		
		if(whDetailVO.getWhDetailStatusCode().equals("입고완료")) {
			
			cnt = logisticsService.updateWhDetailStatus(whDetailVO); 
			
			log.info("updateWhDetailStatus->cnt : " + cnt);
			
			if(cnt == 0) {
				result = ServiceResult.FAILED;
			}else if(cnt > 0) {
				result = ServiceResult.OK;
			}
			
		} else {
			
			cnt = logisticsService.updateWhDetail(whDetailVO);
			
			log.info("updateWhDetailStatus->cnt : " + cnt);
			
			if(cnt == 0) {
				result = ServiceResult.FAILED;
			}else if(cnt > 0) {
				result = ServiceResult.OK;
			}
		}

		model.addAttribute("result",result);
		
		return cnt;
	}
	
	// 물류관리자의 물류창고 등록
	@ResponseBody
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@PostMapping("/warehouseRegist.do")
	public int warehouseRegistForm(WarehouseVO warehouseVO,Model model) {
			
		int cnt = logisticsService.registWh(warehouseVO);

		if(cnt > 0) {
			model.addAttribute("msg","등록 성공");
		}else {
			model.addAttribute("msg","등록 실패");
		}
		
		return cnt;
	}
	
	// 물류창고 기본정보 수정
	@ResponseBody
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@PostMapping(value = "/updateWh.do", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<String> updateWh(WarehouseVO warehouseVO){
		ServiceResult result = null;		
		log.info("updateWh-> warehouseVO : " , warehouseVO);
		
		int cnt = logisticsService.updateWh(warehouseVO);
		

		if(cnt > 0) {
			result = result.OK;
		}else if(cnt==0) {
			result = result.FAILED;
		}
		
		return new ResponseEntity<>(new Gson().toJson(result), HttpStatus.OK);
	}
	
	// 물류창고 삭제 (폐업 컬럼 업데이트)
	@ResponseBody
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@PostMapping("/deleteWh.do")
	public int deleteWh(@RequestBody WarehouseVO warehouseVO,Model model) {
		
		int cnt = logisticsService.deleteWh(warehouseVO);
		String msg = "";
		
		if(cnt>0) {
			msg = "삭제 성공";
		}else {
			msg = "삭제 실패";
		}
		
		model.addAttribute("msg",msg);
		
		return cnt;
	}
	
	// 통계를 위한(?) 전체 컨테이너 목록 호출
	@GetMapping("/allContainer.do")
	public String allContainer(Model model) {		
		// 전체목록 
		List<ContainerVO> containerListAll = logisticsService.containerListAll();
		model.addAttribute("containerListAll",containerListAll);
	
		return "";
	}
	
	// 물류관리자의 컨테이너 관리페이지
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@GetMapping("/myContainer.do")
	public String logisticsMyContainer(
			 @RequestParam("userNo") int userNo
			,@RequestParam(value = "searchType", required = false, defaultValue = "") String searchType // 검색 타입
		    ,@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord // 검색 키워드
		    ,@RequestParam(value = "sortColumn", required = false, defaultValue = "CONTAINER_NO DESC") String sortColumn // 정렬 컬럼 (기본값: 적재일)
		    ,@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage // 현재 페이지 (기본값: 1)
		    ,Model model
			) {
		PaginationInfoVO<ContainerVO> pagingVO = new PaginationInfoVO<>();
		pagingVO.setUserNo(userNo);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setSortColumn(sortColumn);
		pagingVO.setCurrentPage(currentPage);
		
		System.out.println("pagingVO : "+pagingVO);
		
		int totalCount = logisticsService.getContainerCount(pagingVO);
		
		pagingVO.setTotalRecord(totalCount);
	
		List<ContainerVO> containerList = logisticsService.containerList(pagingVO);
		
		
		model.addAttribute("containerList",containerList);
		model.addAttribute("paginationInfo", pagingVO);
		// 검색 조건 반환
		model.addAttribute("searchType",searchType);
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("sortColumn",sortColumn);
		
		System.out.println("containerList : "+containerList);
		
		return "logistics/myContainer";
	}
	
	// 물류관리자의 컨테이너 등록페이지
	@ResponseBody
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@GetMapping("/containerRegist.do")
	public String containerRegist(Model model) {
		
		CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserVO user = userSec.getUser();
        
        String userId = user.getUserId();
        
        PaginationInfoVO<WarehouseVO> pagingVO = new PaginationInfoVO<WarehouseVO>();
        
        pagingVO.setUserId(userId);
        
        List<WarehouseVO> whVO = logisticsService.warehouseList(pagingVO);
        
        model.addAttribute("whVO",whVO);
		
		return "logistics/containerRegist";
	}
	
	// 물류창고 등록시 실행할 메서드
	@ResponseBody
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@PostMapping("/registContainer.do")
	public int registContainer(ContainerVO containerVO,Model model){
			
		// 컨테이너 사용가능 세팅
		int size = containerVO.getContainerSize();
		String type = containerVO.getContainerType();
		if(type.equals("냉동")) {
			type="FZ";
		}else {
			type="NM";
		}
		containerVO.setSztpCode(String.valueOf(size) + type);
		containerVO.setContainerUseYn(true);
		
		System.out.println("containerVO : " + containerVO);
		
		ServiceResult result = null;

		int cnt = logisticsService.registContainer(containerVO);
		
		if(cnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		model.addAttribute("result",result);
		
		return cnt;
	}

	// 물류관리자의 컨테이너 상세페이지
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@GetMapping("/containerDetail.do")
	public String containerDetail(
			@RequestParam("containerNo") int containerNo
			,@RequestParam(value = "searchType", required = false, defaultValue = "") String searchType // 검색 타입
		    ,@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord // 검색 키워드
		    ,@RequestParam(value = "sortColumn", required = false, defaultValue = "a.CONTAINER_DETAIL_NO DESC") String sortColumn // 정렬 컬럼 (기본값: 적재일)
		    ,@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage // 현재 페이지 (기본값: 1)
		    ,Model model
			) {
		
		// 컨테이너 기본정보
		ContainerVO containerVO = logisticsService.containerBasicInfo(containerNo);
		
		model.addAttribute("containerVO",containerVO);
		
		PaginationInfoVO<ContainerDetailVO> pagingVO = new PaginationInfoVO<>();
		pagingVO.setContainerNo(containerNo);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setSortColumn(sortColumn);
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = logisticsService.getContainerDetailCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ContainerDetailVO> containerDetailList = logisticsService.containerDetail(pagingVO);
		
		model.addAttribute("containerNo",containerNo);
		model.addAttribute("pagingVO",pagingVO);
		model.addAttribute("containerDetailList",containerDetailList);
		
		System.out.println("pagingVO : " + pagingVO);
		
		return "logistics/containerDetail";		
	}
	
	
	// 적재신청 관리페이지
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@GetMapping("/myOrder.do")
	public String myOrder(
			@RequestParam(value="waitting", required = false, defaultValue = "") String waitting
			,@RequestParam(value = "searchType", required = false, defaultValue = "") String searchType // 검색 타입
		    ,@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord // 검색 키워드
		    ,@RequestParam(value = "sortColumn", required = false, defaultValue = "") String sortColumn // 정렬 컬럼 (기본값: 적재일)
		    ,@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage // 현재 페이지 (기본값: 1)
			,Model model
			) {
		
		CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserVO user = userSec.getUser();
		
		int userNo = user.getUserNo();
		
		PaginationInfoVO<StowageVO> pagingVO = new PaginationInfoVO<>();
		pagingVO.setUserNo(userNo);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setSortColumn(sortColumn);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setWaitting(waitting);
		
		log.info("waitting",waitting);
		
		int totalRecord = logisticsService.getStowageCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
				
		List<StowageVO> stowageList = logisticsService.stowageList(pagingVO);
		
		model.addAttribute("paginationInfo",pagingVO);
		model.addAttribute("stowageList",stowageList);
		// 검색 조건 리턴
		model.addAttribute("searchType",searchType);
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("sortColumn",sortColumn);
		model.addAttribute("waitting",waitting);
		
		
		System.out.println("waitting : "+ waitting);
		System.out.println("paginationInfo : "+ pagingVO);
		System.out.println("stowageList : "+ stowageList);

		return "logistics/myOrder";
	}
	
	
	
	@ResponseBody
	@PreAuthorize("hasRole('ROLE_LOGISTICS')")
	@PostMapping("/updateContainerDetailStatus.do")
	public int updateContainerDetailStatus(@RequestBody ContainerDetailVO containerDetailVO , Model model) {
		
		log.info("updateContainerDetailStatus->containerDetailVO : " + containerDetailVO);
		
		ServiceResult result = null;
		
		int cnt = 0;
		
		if(containerDetailVO.getContainerDetailStatusCode().equals("입고완료")) {
			
			cnt = logisticsService.updateContainerDetailStatus(containerDetailVO); 
			
			log.info("updateContainerDetailStatus->cnt : " + cnt);
			
			if(cnt == 0) {
				result = ServiceResult.FAILED;
			}else if(cnt > 0) {
				result = ServiceResult.OK;
			}
			
		} else {
			
			cnt = logisticsService.updateContainerDetail(containerDetailVO);
			
			log.info("updateContainerDetail->cnt : " + cnt);
			
			if(cnt == 0) {
				result = ServiceResult.FAILED;
			}else if(cnt > 0) {
				result = ServiceResult.OK;
			}
		}

		model.addAttribute("result",result);
		
		return cnt;
	}
	
	
// 배의 현재 위치 불러오는 크롤링...	
	@PreAuthorize("true")
	@PostMapping("/shipLocation.do")
	public ResponseEntity<Object> start(@RequestParam int shipId) throws Exception{
		String urlName = "https://www.marinetraffic.com/en/ais/get_info_window_json?asset_type=ship&id="+shipId;
		System.out.println("urlName");
		System.out.println(urlName);
		URL url = new URL(urlName);
		HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("User-Agent", "Mozilla/5.0");
		conn.setRequestProperty("access-control-allow-origin", "*");
		conn.addRequestProperty("access-control-allow-credentials", "true");
		Object obj = conn.getContent();
		String message = conn.getResponseMessage();
		System.out.println("message");
		System.out.println(message);
		
		int respCode = conn.getResponseCode();	// 요청의 응답 코드를 받을 수 있다.
		System.out.println("배 목록 요청->상태코드 : " + respCode);

		if(respCode == HttpsURLConnection.HTTP_OK) {
			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuilder jsonBuilder = new StringBuilder();
			String line;
			while((line = reader.readLine()) != null) {
				jsonBuilder.append(line);
				log.info("shipData : " , line);
			}
			reader.close();
			
			String jsonString = jsonBuilder.toString();
			System.out.println("jsonString");
			System.out.println(jsonString);
			return new ResponseEntity<>(jsonString, HttpStatus.OK);

		}
		
		return new ResponseEntity<Object>("데이터 요청 실패", HttpStatus.BAD_REQUEST);
	}

	// 컨테이너 기본정보 수정
		@ResponseBody
		@PreAuthorize("hasRole('ROLE_LOGISTICS')")
		@PostMapping(value = "/updateContainer.do", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
		public ResponseEntity<String> updateContainer(ContainerVO conatainerVO){
			ServiceResult result = null;		
			log.info("updateContainer-> conatainerVO : " , conatainerVO);
			
			int cnt = logisticsService.updateContainer(conatainerVO);
			

			if(cnt > 0) {
				result = result.OK;
			}else if(cnt==0) {
				result = result.FAILED;
			}
			
			return new ResponseEntity<>(new Gson().toJson(result), HttpStatus.OK);
		}
	
//		// 컨테이너 삭제 (컨테이너는 진짜삭제)
//		@ResponseBody
//		@PreAuthorize("hasRole('ROLE_LOGISTICS')")
//		@PostMapping("/deleteContainer.do")
//		public int deleteContainer(@RequestBody int containerNo,Model model) {
//			
//			int cnt = logisticsService.deleteContainer(containerNo);
//			String msg = "";
//			
//			if(cnt>0) {
//				msg = "삭제 성공";
//			}else {
//				msg = "삭제 실패";
//			}
//			
//			model.addAttribute("msg",msg);
//			
//			return cnt;
//		}
}
