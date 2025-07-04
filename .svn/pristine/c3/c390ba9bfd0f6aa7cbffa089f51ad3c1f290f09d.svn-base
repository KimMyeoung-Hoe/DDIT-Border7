package kr.or.ddit.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Currency;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.itextpdf.text.pdf.PdfStructTreeController.returnType;

import kr.or.ddit.mapper.NationMapper;
import kr.or.ddit.vo.AllExchangeRateVO;
import kr.or.ddit.vo.CurrencyVO;
import kr.or.ddit.vo.ExRateVO;
import kr.or.ddit.vo.NationVO;
import lombok.extern.slf4j.Slf4j;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Slf4j
@Service
public class ExRateServiceImpl implements IExRateService{

	@Autowired
	private WebClient webClient;

	@Autowired
	private NationMapper mapper; 
	
	private RestTemplate restTemplate;

	public ExRateServiceImpl(WebClient webClient, RestTemplateBuilder builder) {
        this.webClient = webClient;
        this.restTemplate = builder.build();
    }
	
	
	
	public Mono<List<ExRateVO>> getExRate(String na1, String na2) {
		ZoneId zoneid = ZoneId.of("Asia/Seoul");
		
		return webClient.get()
				.uri("/rates/history+live?source="+na1+"&target="+na2+"&length=30&resolution=hourly&unit=day")
				.retrieve()
				.bodyToFlux(ExRateVO.class)
				.map(data -> {
					Date date = new Date(data.getTime());
					SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH");
					String newdate =formatDate.format(date);
					data.setDate(newdate);
					
					/*
					 * // 귝가 번호 가져오기 int srcNo = mapper.selectnationNo(na1); int tgtNo =
					 * mapper.selectnationNo(na2);
					 * 
					 * data.setSrcCurrencyNm(mapper.getCurrencyNm(na1));
					 * data.setTgtCurrencyNm(mapper.getCurrencyNm(na2));
					 * data.setSrcNationKrNm(mapper.getNationtNm(srcNo));
					 * data.setTgtNationKrNm(mapper.getNationtNm(tgtNo));
					 */
					
					
					
					return data;
				})
				.collectList();
	}

	public String getCurrencyCode(int target) {

		return mapper.getCurrencyCode(target);
	}
	


	public void insertRate(String currencyCode) {

			webClient.get()
			 	.uri("/rates/history+live?source=KRW&target="+currencyCode+"&length=1&unit=day")
			 	.retrieve()
			 	.bodyToFlux(ExRateVO.class)
			 	.map(data -> {
					Date date = new Date(data.getTime());
					SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH");
					String newdate =formatDate.format(date);
					data.setDate(newdate);
					return data;
				})
			 	.collectList()
			 	.subscribe(list -> {
				 	   ExRateVO	exRate = list.getFirst();
				 	   log.info("exRate insert : {}",exRate);
				 	   mapper.insertRate(exRate);
				 	   
				 	});
			
			
		}
	

	public List<String> getCurrencyCodeList() {
		return mapper.getCurrencyCodeList();
	}



	@Override
	public List<CurrencyVO> getCurrencyList() {
		return mapper.getCurrencyList();
	}



	@Override
	public List<NationVO> nationSearch(Map<String, String> searchMap) {
		return mapper.nationSearch(searchMap);
	}


//https://oapi.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=4qY5viu9U8mr4lp0oOSVm0gu0gq2CXfC&searchdate=20250701&data=AP01
	@Override
	public List<AllExchangeRateVO> allExchangeRate(String date) {
		/* restTemplate. */
		String uri = UriComponentsBuilder
				.fromHttpUrl("https://oapi.koreaexim.go.kr/site/program/financial/exchangeJSON")
				.queryParam("authkey", "4qY5viu9U8mr4lp0oOSVm0gu0gq2CXfC")
				.queryParam("searchdate", date)
				.queryParam("data", "AP01")
				.build()
				.toUriString();
		log.info("Calling Korea Exim API with URI: {}", uri);	
		  AllExchangeRateVO[] responseArray = restTemplate.getForObject(uri, AllExchangeRateVO[].class);
		  log.info("Calling Korea Exim API with URI: {}", responseArray);
		  if (responseArray != null) {
              // 배열을 List로 변환하여 반환
              return Arrays.asList(responseArray);
          }
		
		return null;
	}
	
	
	
}
