package kr.or.ddit.vo;

import lombok.Data;

@Data
public class NationVO extends CurrencyVO{
	private int nationNo;
	private String nationKrName;
	private String nationEnName;
	private String nationCode;
	
//	private CurrencyVO currencyVO;
//	private ExRateVO exRateVO;
}
