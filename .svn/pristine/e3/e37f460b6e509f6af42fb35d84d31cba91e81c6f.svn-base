package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class KRNotationVO {
	
	private String contractNo;			// 계약 일련번호 1
	private String productNameKr;		// 제품명	2
	private String contentKr;			// 내용량 7
	private String ingredientsKr;		// 원재로 명 8
	private String meatTypePartKr;		// 부위명 14
	private String originKr;			// 원산지 5
	
	@DateTimeFormat(pattern = "yyyy-MM-dd") // YYYY-MM-DD 형식으로 바인딩
	private Date manufactureDateKr;		// 제조연월일 6

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date consumptionDeadlineKr;	// 소비기한 20
	
	private String packagingMaterialKr;	// 포장 용기 9
	private String storageMethodKr;		// 보관 방법 10
	private String consignorName;		// 사업장 소재지명 3
	private String consignorAddr;		// 사업장 주소
	private String consignorDetAddr;	// 사업장 상세주소
	private String consignorTel;		// 사업장 번호 4
	private String etcKr;				// 주의사항 13
	
	private Date regDate;		// 등록일
	
}
