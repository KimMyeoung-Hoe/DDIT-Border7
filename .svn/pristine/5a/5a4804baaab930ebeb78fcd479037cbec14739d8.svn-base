package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import jakarta.persistence.Convert;
import kr.or.ddit.config.BooleanToIntConverter;
import lombok.Data;

@Data
public class HCVO {
	
	/** 검역증명서 발행번호 */
	private String hcNo; 
	/** 신고서접수 일련번호 */
	private String declNo; 
	/** 검역증명서 신청인 성명 */
	private String hcName; 
	/** 검역증명서 신청인 주소 */
	private String hcAddr; 
	/** 검역증명서 물품 품종 */
	private String hcCommonName; 
	/** 검역증명서 신청인 전화번호 */
	private String hcTel;
	
	/** 검역증명서 물품 무게 */
	private double hcWeight; 
	/** 검역증명서 물품 학명 */
	private String hcSn; 
	/** 검역증명서 물품 수량 */
	private String hcQty; 
	/** 검역증명서 물품 원산지 */
	private String hcOrigin; 
	@Convert(converter = BooleanToIntConverter.class)
	/** 검역증명서 판정결과 */	
	private boolean hcYn; 
	/** 한글표시사항 합격 유무 */	
	@Convert(converter = BooleanToIntConverter.class)
	private boolean hcKrNotation; 
	//1. hcKrNotation : true -> hcKrNotationNum : 1
	//2. hcKrNotation : false -> hcKrNotationNum : 0
	
	/** 검역증명서 발행일시 */
	private Date dateOfIssue; 
	/** 검역증명서 신청 회사명 */
	private String hcConsignorName; 
	/** 검역증명서 결격 사유 */
	private String hcEtc; 
	/** 검역증명서 물품명 */
	private String hcProductName; 
	/** 검역증명서 물품 대상 질병 */
	//private List<DiseaseVO> targetDiseases;
	
	
	/** 포장상자 개봉파손 확인 */
	private String hcPackagingCondition;
	/** 보존.보관상태 */
	private String hcStorageCondition;
	/** 성상.색깔.냄새.육질 등 확인 */
	private String hcSensoryProperties;
	/** 부패.변질 확인 */
	private String hcSpoilageCheck;
	/** 이물질 확인 */
	private String hcForeignSubstanceCheck;
	
	
}
