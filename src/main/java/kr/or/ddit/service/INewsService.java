package kr.or.ddit.service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import kr.or.ddit.vo.NewsVO;
import reactor.core.publisher.Mono;

public interface INewsService {
	public Mono<List<NewsVO>> getNews(int pageNo, int numOfRows) throws UnsupportedEncodingException;

	public int newsInsert(List<NewsVO> news);

	public List<NewsVO> getDBNews();
}
