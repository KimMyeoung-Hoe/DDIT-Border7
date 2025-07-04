package kr.or.ddit.vo;

import lombok.Data;

@Data
public class CurrencyVO extends ExRateVO{

	private String nationKrName;
	private String currencyCode;
	private int nationNo;
	private String currencyName;
	private String currencySymbol;
}
