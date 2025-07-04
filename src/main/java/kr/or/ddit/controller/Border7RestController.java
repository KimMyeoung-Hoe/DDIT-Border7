package kr.or.ddit.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestClient; // Spring 6 (Spring Boot 3.2)부터 권장
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServlet;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.contract.service.IContractService;
import kr.or.ddit.service.ExRateServiceImpl;
import kr.or.ddit.service.IExRateService;
import kr.or.ddit.service.ILogisticsService;
import kr.or.ddit.service.INewsService;
import kr.or.ddit.vo.AllExchangeRateVO;
import kr.or.ddit.service.IStatisticsService;
import kr.or.ddit.vo.CurrencyVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.ExRateVO;
import kr.or.ddit.vo.ExchangeRatesResponseVO;
import kr.or.ddit.vo.HsCodeVO;
import kr.or.ddit.vo.NationVO;
import kr.or.ddit.vo.NewsVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PeriodStat;
import kr.or.ddit.vo.ShipsVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;
import reactor.core.publisher.Mono;

@Slf4j
@RestController
@RequestMapping("/api") // api로 시작하는 요청들은 rest컨트롤러가 관리하게끔함
public class Border7RestController {
	
	@Autowired
	private ILogisticsService logisticsService;

	@Autowired
	public IContractService contractService;
	
	// 외부 Unipass API의 기본 URL
	private static final String UNIPASS_API_BASE_URL = "https://unipass.customs.go.kr:38010";

	// Unipass API의 특정 엔드포인트 경로
	private static final String UNIPASS_API_PATH = "/ext/rest/lcaLstInfoQry/retrieveLcaBrkd";

	// Unipass API에 필요한 고정 쿼리 파라미터 (실제 API 문서 확인 후 정확히 입력)
	private static final String CRKY_CN = "xxxx"; // 예시, 실제 키로 변경

	private final RestClient restClient; // RestClient 주입

	public Border7RestController(RestClient.Builder restClientBuilder) {
		// RestClient.Builder를 사용하여 RestClient 인스턴스를 생성
		// 기본 URL 설정 및 기타 필요한 구성 추가 가능
		this.restClient = restClientBuilder.baseUrl(UNIPASS_API_BASE_URL).build();
	}

	@GetMapping(value = "/unipass/checkCustomsBroker", // GET 요청으로 변경
			produces = MediaType.APPLICATION_XML_VALUE) // 클라이언트로 XML을 생산
	public ResponseEntity<String> checkCustomsBroker(@RequestParam("lcaSgn") String lcaSgn,
			@RequestParam("lcaNm") String lcaNm) { // 쿼리 파라미터로 받음
		System.out.println("클라이언트로부터 받은 lcaSgn: " + lcaSgn);
		System.out.println("클라이언트로부터 받은 lcaNm: " + lcaNm);

		// Unipass API 호출을 위한 URI 구성
		// lcaSgn을 쿼리 파라미터로 포함
		String unipassApiUrl = UriComponentsBuilder.fromPath(UNIPASS_API_PATH).queryParam("crkyCn", CRKY_CN)
				.queryParam("lcaSgn",lcaSgn) // lcaSgn을 쿼리 파라미터로 추가dj
				.queryParam("lcaNm",lcaNm) // lcaSNm을 쿼리 파라미터로 추가
				.build().toUriString();  // lcaNm을 쿼리 파라미터로 추가

		System.out.println("Unipass API 호출 URL: " + unipassApiUrl);

		try {
			// RestClient를 사용하여 Unipass API로 GET 요청 전송
			ResponseEntity<String> unipassResponse = restClient.get() // GET 요청으로 변경
					.uri(unipassApiUrl).retrieve().toEntity(String.class);

			System.out.println("Unipass API로부터 받은 응답 상태: " + unipassResponse.getStatusCode());
//			System.out.println("Unipass API로부터 받은 응답 본문:\n" + unipassResponse.getBody());

			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_XML); // Unipass API의 응답이 XML이라고 가정

			return new ResponseEntity<>(unipassResponse.getBody(), headers, unipassResponse.getStatusCode());

		} catch (Exception e) {
			System.err.println("Unipass API 호출 중 오류 발생: " + e.getMessage());
			e.printStackTrace();

			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_XML);
			String errorXml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><error><message>프록시 서버 오류: " + e.getMessage()
					+ "</message></error>";
			return new ResponseEntity<>(errorXml, headers, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping("/userInfo")
	public ResponseEntity<Map<String, String>> getUserInfo(){
		
		
		
		Map<String, String> userInfo = new HashMap<>();
        userInfo.put("name", "김관세"); // 실제로는 로그인된 사용자 정보에서 가져와야 함
        userInfo.put("userType", "관세사"); // 실제로는 로그인된 사용자 정보에서 가져와야 함
        userInfo.put("email", "kim@customs.com");
        userInfo.put("completedRequests", "458");
        userInfo.put("errorRate", "97.4%"); // 무료 오류 처리 비율
		
		return ResponseEntity.ok(userInfo);
	}
	
	//----------------------------------- 환율 start --------------------------------------------------------------------------------------
	

	@Autowired
	private IExRateService exRateService;
	
	// 선택한 국가의 환율 정보 30일치 가져오기
	@GetMapping("/exchangeRate")
	public Mono<List<ExRateVO>>  exchangRate(
			@RequestParam(value="source", 
		    required = false, defaultValue="205")int source, 
			@RequestParam(value="target", 
		    required = false, defaultValue="63")int target) { // 선택된 국가 번호 가져옴

		log.info("source : {}, target : {}", source, target);
		// 국가 번호랑 매칭된  currency code 가져옴
		String srcNation = exRateService.getCurrencyCode(source);
		String tarNation = exRateService.getCurrencyCode(target);
		
		log.info("tarNation : {}",tarNation);
		// currency code를 통한 api 환율
		Mono<List<ExRateVO>> result = exRateService.getExRate(srcNation, tarNation);
		
		return result;
	}
	

	// 통화코드 VO 리스트 가져오기
	@GetMapping("/nationlist")
	public List<CurrencyVO> getCurrencyList(){
		List<CurrencyVO> currencyList =  exRateService.getCurrencyList();
		return currencyList;
	}
	
	// 환율 15시마다 Insert
	@Scheduled(cron = "0 00 15 * * *")
	public void insertRate() {
		
		List<String> currencyList =  exRateService.getCurrencyCodeList();
		for(String currencyCode : currencyList) {
			exRateService.insertRate(currencyCode);
		}

	}
	
	
	@GetMapping("/allExchangeRate")
	public ExchangeRatesResponseVO allExchangeRate() {
		
	    Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);
        Date yesterday = cal.getTime();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String yesterdayStr = sdf.format(yesterday);

        System.out.println("어제 날짜: " + yesterdayStr);
        
        LocalDate today = LocalDate.now();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
        String todateStr = today.format(dtf);
        
        System.out.println("오늘 날짜: " + todateStr);
        
        
		List<AllExchangeRateVO> ystRateList = exRateService.allExchangeRate(yesterdayStr);
		List<AllExchangeRateVO> tdyRateList = exRateService.allExchangeRate(todateStr);
	
		ExchangeRatesResponseVO rateResp = new ExchangeRatesResponseVO();
		rateResp.setTodayRates(tdyRateList);
		rateResp.setYesterdayRates(ystRateList);
		return rateResp;
	}
	//----------------------------------- 환율 end --------------------------------------------------------------------------------------
	
	//-------------------------------------------------------- 뉴스 start ------------------------------------------------------------
	
	@Autowired
	private INewsService newsService;
	
	private int pageNo = 1;
	private int numOfRows = 5;
	
	@GetMapping("/news")
	public Mono<List<NewsVO>> News() throws UnsupportedEncodingException {
		//News->pageNo : 1
		log.info("News->pageNo : " + pageNo);
		//News->numOfRows : 5
		log.info("News->numOfRows : " + numOfRows);
		
		// 비동기적으로 데이터를 처리하기 위해 Mono 사용
		Mono<List<NewsVO>> result = newsService.getNews(pageNo, numOfRows);
		//News->result : MonoMapFuseable
		log.info("News->result : " + result);
		
		return result;
	}
	

	/*
	 * // 뉴스 db 저장
	 * 
	 * @Scheduled(cron = "0 00 15 * * *") public void newsInsert() throws
	 * UnsupportedEncodingException { Mono<List<NewsVO>> result =
	 * newsService.getNews(pageNo, numOfRows); List<NewsVO> news = result.block();
	 * int res = newsService.newsInsert(news); log.info(" news res : " , res);
	 * 
	 * }
	 */
	
	@GetMapping("/dbNews")
	public List<NewsVO> getDBNews() {
		
		return newsService.getDBNews();
	}
	 
	//-------------------------------------------------------- 뉴스 end ------------------------------------------------------------
	

	//-------------------------------------------------------- 선박위치? start ------------------------------------------------------------
	@GetMapping("/logistics/shipList")
    public PaginationInfoVO<ShipsVO> getShipList(
            // 필요하다면 @RequestParam으로 검색/정렬 조건을 받습니다.
    		@RequestParam(value = "searchType", required = false, defaultValue = "") String searchType // 검색 타입
		    ,@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord // 검색 키워드
		    ,@RequestParam(value = "sortColumn", required = false, defaultValue = "SHIP_SCHEDULE_DEPARTURE DESC") String sortColumn 
		    ,@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage // 현재 페이지 (기본값: 1)
		    ,Model model
    ) {
		
        System.out.println("searchType : " + searchType);
        System.out.println("searchWord : " + searchWord);
        System.out.println("sortColumn : "+  sortColumn);
		
		PaginationInfoVO<ShipsVO> pagingVO = new PaginationInfoVO<>();
        pagingVO.setScreenSize(10); // 한 페이지에 보여줄 개수
        pagingVO.setBlockSize(5);  // 페이징 블록 개수
        pagingVO.setSearchType(searchType);
        pagingVO.setSortColumn(sortColumn);
        pagingVO.setCurrentPage(currentPage);
        pagingVO.setSearchWord(searchWord);
        // 필요하다면 다른 검색 조건들도 설정합니다.
        
        // 1. 전체 선박 수 조회
        int totalRecord = logisticsService.selectShipCount(pagingVO); // 서비스에 맞는 메소드명 사용
        pagingVO.setTotalRecord(totalRecord);
        
        // 2. 현재 페이지에 해당하는 선박 목록 조회
        List<ShipsVO> dataList = logisticsService.selectShipList(pagingVO); // 서비스에 맞는 메소드명 사용
        pagingVO.setDataList(dataList);
        System.out.println("pagingVO : " + pagingVO);
        // 3. 페이징 정보가 담긴 VO 객체를 그대로 반환하면 Spring이 JSON으로 변환해줍니다.
        return pagingVO;
    }
	//-------------------------------------------------------- 선박위치? end ------------------------------------------------------------
	
	//-------------------------------------------------------- hscodeSearch start ------------------------------------------------------------
	/**
	 * hs코드 검색 ajax
	 * @param searchMap
	 * @return
	 */
	@ResponseBody
	@PostMapping("/hsCodeSearch.do")
	public ResponseEntity<List<HsCodeVO>> hsCodeSearch(@RequestBody Map<String, String> searchMap) {
		String hsSearchType = searchMap.get("hsSearchType");
		String hsSearchWord = searchMap.get("hsSearchWord");
		
		List<HsCodeVO> searchAnswer = contractService.hsCodeSearch(searchMap);
		return new ResponseEntity<List<HsCodeVO>>(searchAnswer,HttpStatus.OK);
	}
	//-------------------------------------------------------- hscodeSearch end ------------------------------------------------------------
	//-------------------------------------------------------- 국가Search start ------------------------------------------------------------
	/**
	 * 국가 검색
	 * @param searchMap
	 * @return
	 */
	@ResponseBody
	@PostMapping("/nationSearch.do")
	public ResponseEntity<List<NationVO>> nationSearch(@RequestBody Map<String, String> searchMap) {
		List<NationVO> searchAnswer = exRateService.nationSearch(searchMap);
		
		return new ResponseEntity<List<NationVO>>(searchAnswer,HttpStatus.OK);
	}
	
	//-------------------------------------------------------- 국가Search end ------------------------------------------------------------
	//-------------------------------------------------------- 차트정보불러오기 start --------------------------------------------------------
   
	@Autowired
	private IStatisticsService statisticsService;
	
	@ResponseBody
    @PostMapping("/chartInfo.do")
	public Map<String,Object> chartInfo(){
    	
		CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserVO user = userSec.getUser();	 
        
		Map<HsCodeVO , Map<String, PeriodStat>> myStatistics = statisticsService.myStatisticsHsCodeAndPeriod(user);
		Map<HsCodeVO , Map<String, PeriodStat>> allStatistics = statisticsService.allStatisticsHsCodeAndPeriod();
		 
		Map<String, Object> result = new HashMap<>();
		result.put("myStatistics", myStatistics);
		result.put("allStatistics", allStatistics);
		
		return result;
	 }

	 //----------------------------------------------------------------------------------------------------------------------------

    @GetMapping("/ApiExplorer")
	public void ApiExplorer() {
		
	  }
	

}
