package kr.or.ddit.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ContractRecord {
	private String contractStatusCode;
	private Date contractRecordRegDate;
	private String statusCodeMediumCategoryName;
	private String statusCodeName;
	private int statusCode;
}
