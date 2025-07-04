package kr.or.ddit.vo;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class DeclVO extends DeclDVO {
	private String declDNo;
	private String declNo;
	private int servantNo;
	private Date declReceptDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date declAntcDate;
	private Date declRealDate;
	private int declYn;
	private String contractNo;
	
	private DeclDVO declDVO;
	private ContractVO contractVO;
	private ProductVO productVO;
	private UserVO userVO;
}
