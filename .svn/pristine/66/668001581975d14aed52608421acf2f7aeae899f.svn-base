package kr.or.ddit.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.Convert;
import kr.or.ddit.config.BooleanToIntConverter;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/** 공통첨부파일상세 VO
 * 
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ComFileDetailVO {
	private MultipartFile item;
	private int comFileDetailNo;						// 첨부파일상세 일련번호
	private int comFileNo;								// 첨부파일 일련번호
	private String comFileDetailType;					// 공통첨부파일상세 분류
	private String comFileDetailOriginalName;			// 공통첨부파일상세 원본파일명
	private String comFileDetailMime;					// 공통첨부파일상세 원본확장자
	private long comFileDetailSize;						// 공통첨부파일상세 원본크기
	private String comFileDetailSavePath;				// 공통첨부파일상세 저장파일경로
	private String comFileDetailSaveName;				// 공통첨부파일상세 저장파일명
	private Date comFileDetailSaveDate;					// 공통첨부파일상세 저장일시
	@Convert(converter = BooleanToIntConverter.class)
	private boolean comFileDetailUseYn;						// 공통첨부파일상세 사용여부
	
	
	public ComFileDetailVO(MultipartFile item) {
		this.item = item;
		this.comFileDetailType = item.getContentType();
		this.comFileDetailOriginalName = item.getOriginalFilename();
		this.comFileDetailSize = item.getSize();
	}
}
