package kr.or.ddit.vo;

import java.sql.Timestamp;
import java.time.ZonedDateTime;
import java.util.Date;

import lombok.Data;

@Data
public class ExRateVO {
	private int exRateNo;
	private String source;
	private String target;
	private double value;
	private long time;
	private String date;
	private String currencyCode;
	private double exchRate;
	private Date refDt;
	
	private String srcNationKrNm;
	private String tgtNationKrNm;
	private String srcCurrencyNm;
	private String tgtCurrencyNm;
}
