package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.CurrencyVO;
import kr.or.ddit.vo.ExRateVO;
import kr.or.ddit.vo.NationVO;
import reactor.core.publisher.Mono;


@Mapper
public interface NationMapper {


	public String getCurrencyCode(int target);

	public List<String> getCurrencyCodeList();

	public int insertRate(ExRateVO rate);

	public List<CurrencyVO> getCurrencyList();

	public int selectnationNo(String na1);

	public String getCurrencyNm(String na1);

	public String getNationtNm(int tgtNo);

	/**
	 * 국가검색
	 * @param searchMap
	 * @return
	 */
	public List<NationVO> nationSearch(Map<String, String> searchMap);
	
}
