package kr.or.ddit.service;


import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriComponentsBuilder;

import kr.or.ddit.mapper.INewsMapper;
import kr.or.ddit.vo.NewsApiResponse;
import kr.or.ddit.vo.NewsVO;
import lombok.extern.slf4j.Slf4j;
import reactor.core.publisher.Mono;

@Slf4j
@Service
public class NewsServiceImpl implements INewsService{

    private final WebClient webClient;
    private static final String SERVICE_KEY = "xxx"; // API 키
    private static final String BASE_URL = "https://apis.data.go.kr/B410001/kotra_overseasMarketNews/ovseaMrktNews/ovseaMrktNews"; // KOTRA API 기본 URL
   
    
    @Autowired
    private INewsMapper newsMapper;
    
    public NewsServiceImpl(WebClient.Builder webClientBuilder) {
        this.webClient = webClientBuilder.baseUrl(BASE_URL).build();
    }

    	// 뉴스 리스트 출력
    	public Mono<List<NewsVO>> getNews(int pageNo, int numOfRows) throws UnsupportedEncodingException{
    		String encodedServiceKey = URLEncoder.encode(SERVICE_KEY, StandardCharsets.UTF_8.toString());
    	
    		URI uri = UriComponentsBuilder.fromUriString(BASE_URL)
    	            .queryParam("serviceKey", encodedServiceKey) // 이미 인코딩된 키 사용
    	            .queryParam("type", "json")
    	            .queryParam("numOfRows", numOfRows)
    	            .queryParam("pageNo", pageNo)
    	            .build(true) // 인코딩된 URI를 그대로 사용하겠다는 의미
    	            .toUri();
    		
    		//맵으로 key

    	    return webClient.get()
    	            .uri(uri) // 직접 구성한 URI 사용
    	            .accept(MediaType.APPLICATION_JSON)
    	            .retrieve()
    	            .bodyToMono(NewsApiResponse.class)
    	                .map(response -> {
    	                    log.info("Raw Rate API Response: {}", response); // response 객체 전체 로깅

    	                    // 뉴스 목록 추출 (null 대신 빈 리스트 반환)
    	                    return Optional.ofNullable(response)
    	                            .map(NewsApiResponse::getResponse)
    	                            .map(NewsApiResponse.Response::getBody)
    	                            .map(NewsApiResponse.Body::getItemList)
    	                            .map(NewsApiResponse.ItemList::getItem)
    	                            .orElse(Collections.emptyList()); 
    	                });
    	}

		@Override
		public int newsInsert(List<NewsVO> news) {
			
			return newsMapper.newsInsert(news);
		}

		@Override
		public List<NewsVO> getDBNews() {

			return newsMapper.getDBNews();
		}
}
