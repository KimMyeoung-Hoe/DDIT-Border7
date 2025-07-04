package kr.or.ddit.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/** 제재VO */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class SanctionVO {
	private int sanctionNo;					// 제재 일련번호
	private String declNo;					// 신고서접수 일련번호
	private int sanctionCode;				// 제재 코드
	private String sanctionDate;			// 제재 발생일시
	private int servantNo;					// (제재 담당)공무원 식별번호
	
	private String sanctionName;			// 제재 사유
	private int sanctionScore;				// 제재 점수
	
	private String empNo;					// (제재 담당)공무원 사원번호
	private String servantName;				// (제재 담당)공무원 이름
	private String declDNo;					// 신고서접수 일련번호
	
	private int ccaNo;						// 관세사식별번호
	private String ccaName;					// 관세사명
	private String ccaRegistrationNumber;	// 관세사등록번호
	private int ccaSanctionScore;			// 관세사누적오류점수
	private int ccaSanctionCount;			// 관세사오류발생건수
	private int ccaDeclCount;				// 관세사전체업무건수
	
	private String contractNo;  			// 관세사 접수 번호
}
