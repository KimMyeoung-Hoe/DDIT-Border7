package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BwVO {

	private int bwNo;
	private String bwTransportNo;
	private int whSectionNo;
	private String exportCarrier;
	private String importCarrier;
	private int servantNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date bwArrivalDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date bwDepartureDate;
	private int bwSporageDuration;
	private String declNo;
	private String contractNo;
	private int bwhNo;
	
	
	private BwhVO bwhVO;
	private WhSetionVO whSectionVO;
	private CDVO cdVO;
	private DeclVO declVO;
	private DeclDVO declDVO;
	private ContractVO contractVO;
	private ProductVO productVO;
	private UserVO userVO;
}
