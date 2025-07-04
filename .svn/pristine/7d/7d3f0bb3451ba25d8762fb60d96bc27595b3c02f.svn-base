package kr.or.ddit.vo;

import java.util.Date;

import jakarta.persistence.Convert;
import kr.or.ddit.config.BooleanToIntConverter;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/** 세금VO */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class TaxVO {
	private int taxNo;						// 세금 일련번호
	private String declNo;					// 신고서처리업무 일련번호
	private int taxAmount;					// 세금 금액
	private Date taxDestDate;				// 세금 고지일시
	private Date taxDeadlineDate;			// 세금 납부기한
	@Convert(converter = BooleanToIntConverter.class)
	private boolean taxYn;					// 세금 납부여부
	private int taxRealAmount;				// 세금 납부 금액
	private Date taxRealDate;				// 세금 납부일시
	
	// 추가 정보
	private String contractNo;				// 관세대리업무계약 번호
	private String declDNo;					// 수출입신고서 번호
	private String servantName;				// 담당공무원 이름
	private String servantTel;				// 담당공무원 연락처
	private String ccaName;					// 관세사 이름
	private String ccaRegistrationNumber;	// 관세사 등록번호
	private String consignorName;			// 화주 업체명
	private String businessNumber;			// 화주 업체 사업자번호
	
	private int taxAmountAfter;				// 세금 납기후금액
	
	// 카카오페이 결제준비
	private String tid;                  	// 결제 고유번호
    private String next_redirect_pc_url; 	// 카카오톡으로 결제 요청 메시지(TMS)를 보내기 위한 사용자 정보 입력화면 Redirect URL(카카오 측 제공)

    // 카카오페이 결제진행
    private String aid;                 	// 요청 고유 번호
    private String cid;                		// 가맹점 코드
    private String partner_order_id;    	// 가맹점 주문번호
    private String partner_user_id;     	// 가맹점 회원 id
    private String payment_method_type; 	// 결제 수단, CARD 또는 MONEY 중 하나
    private String item_name;           	// 상품 이름
    private String item_code;           	// 상품 코드
    private int quantity;               	// 상품 수량
    private String created_at;          	// 결제 준비 요청 시각
    private String approved_at;         	// 결제 승인 시각
    private String payload;             	// 결제 승인 요청에 대해 저장한 값, 요청 시 전달된 내용
}
