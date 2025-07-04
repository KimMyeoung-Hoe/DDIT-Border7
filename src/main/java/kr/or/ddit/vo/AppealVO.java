package kr.or.ddit.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AppealVO {
	/** 민원신청 번호*/
	private int appealNo;
	/** 민원 종류 */
	private String appealType;
	/** 관세대리업무 번호  */
	private String declNo;
	/** 민원 제목*/
	private String appealTitle;
	/** 민원 내용*/
	private String appealContent;
	/** 민원 첨부파일 일련번호*/
	private int appealAttch;
	/** 민원작성자 식별번호*/
	private int userNo;
	/** 민원 작성일시 */
	private Date appealRegDate;
	/** 담당 공무원 식별번호*/
	private int servantNo;
	/** 민원 답변내용*/
	private String appealAnswer;
	/** 민원 답변 일시*/
	private Date appealAnswerDate;
	/** 민원 답변 첨부파일 일련번호*/
	private int appealAnswerFile;
	/** 민원 프로시저 결과값을 받기위한 컬럼*/
	private int result;
	/** 민원 첨부파일 저장을 위한 컬럼*/
	private List<ComFileDetailVO> appealFileList; 
	/** 답변 첨부파일 저장을 위한 컬럼*/
	private List<ComFileDetailVO> answerFileList; 
}
	