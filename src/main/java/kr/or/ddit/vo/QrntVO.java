package kr.or.ddit.vo;

import java.util.Date;

import jakarta.persistence.Convert;
import kr.or.ddit.config.BooleanToIntConverter;
import lombok.Data;

@Data		// 검사검역
public class QrntVO {
	

	/** 신고서접수일련번호 */
	private String declNo;	
	/** 현장공무원식별번호 */
	private int servantNo;
	/** 현장공무원이름 */
	private String userName;
	/** 검사검역 접수일시 */
	private Date qrntReceptDate;
	/** 검사검역 예정완료일시 */
	private Date qrntAntc;
	/** 검사검역 실제완료일시 */
	private Date qrntCompletion;
	/** 검사검역 진행코드 */
	private String qrntStatusCode;
	
	/** 검사검역 합격여부 */
	@Convert(converter = BooleanToIntConverter.class)
	private boolean qrntYn;
	/** 검사검역 유형 */
	private String qrntType;
	/** 수출입신고서 일련번호 */
	private String declDNo;
	
	private String contractNo;
	private String hcNo;
}
