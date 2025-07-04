package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import io.micrometer.common.util.StringUtils;
import lombok.Data;

/** 메일VO
 * - DB의 메일 관련 테이블 3개 통합관리함
 * - 1. EMAILS(발송메일)
 * - 2. RECIP(수신자)
 * - 3. EMAIL_TEMP(템플릿)
 */
@Data
public class MyMailVO {
	// 공용
	private int emailNo;							// 발송메일 일련번호
	private String userId;							// (발송자 혹은 수신자) id
	private int userNo;								// (발송자 혹은 수신자) 식별번호
	private String emailDt;							// (발신 혹은 수신) 일시
	private String emailAcount;						// (발송자 혹은 수신자) 메일
	private String emailCategory;					// 메일함 구분
	private boolean starYn;							// 중요메일여부
	
	// EMAILS(발송메일)
	private String emailTitle;						// 메일 제목		
	private String emailContent;					// 메일 본문
	private String emailSender;						// 발송자 메일주소
    private String emailDate;						// 작성일시
    private String emailType;						// 메일함 구분
    private int emailExportCnt;						// 외부발송메일 수
    private boolean emailDelYn;						// 메일 삭제여부
    private int comFileNo;							// 공통첨부파일 일련번호
    
    // RECIP(수신자)
    private int recipNo;							// 메일수신 일련번호
    private int recipEmailNo;						// 발송메일 일련번호
    private String recipEmail;						// 수신자 메일주소
    private String recipType;						// 메일함 구분
    private boolean readYn;							// 읽음여부
    private boolean recipDelYn;						// 메일 삭제여부
    private int recipUserNo;						// 수신자 식별번호
    
    // EMAIL_TEMP(템플릿)
    private int emailTempNo;						// 템플릿 일련번호
    private String emailTempName;					// 템플릿 이름
    private String emailTempTitle;					// 메일 제목
    private String emailTempContent;				// 메일 본문
    private String emailTempRegDate;				// 템플릿 최종수정일시
    private int emailTempCnt;						// 템플릿 사용횟수
    
    // 메일 수
    private int starCount;							// 중요한 메일 수
    private int filesCount;							// 파일이 첨부된 메일 수
    private int unreadCount;						// 안읽은 메일 수
    private int recipCount;							// 받은 메일 수
    private int sendCount;							// 보낸 메일 수
    private int tempCount;							// 임시 메일 수
    private int trashCount;							// 버린 메일 수
    private int allCount;							// 전체 메일 수
    
    // 전체 메일 수 계산 (받은 메일 수 + 보낸 메일 수)
    public void setAllCount(int recipCount, int sendCount) {
    	this.allCount = recipCount + sendCount;
    }
    
    // 수신인 목록
    private String recipEmails;						// 쉼표로 나열된 수신인 목록
    private List<String> recipList;					// 수신인 리스트
    private List<Integer> recipUserNoList;			// 수신인 식별번호 리스트
    
    // 메일 선택
    private Integer[] selectEmailNoList;			// 선택한 메일 일련번호 배열
    
    // 메일 첨부파일
    private MultipartFile[] emailFile;
	private List<ComFileDetailVO> emailFileList;
	

}
