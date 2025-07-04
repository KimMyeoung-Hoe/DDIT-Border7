package kr.or.ddit.vo;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Convert;
import kr.or.ddit.config.BooleanToIntConverter;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CDVO {
	
	/** 수출입신고필증번호 */
	private String cdNo;
	
	private String declNo;
	/** 수출입신고필증 발급일시*/
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date cdDate;
	/** 수출입신고필증 유효여부*/
	@Convert(converter = BooleanToIntConverter.class)
	private boolean cdValidityYn;
	
	private int sealNo;
	
	private String declDNo;
	private String contractNo;
}
