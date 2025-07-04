package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ExchangeRatesResponseVO {
	private List<AllExchangeRateVO> yesterdayRates;
    private List<AllExchangeRateVO> todayRates;

}
