package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

/**
 * 관세대리업무계약 VO 통관의뢰 VO
 * 
 */
@Data
public class ContractVO {
	private String contractNo;
	private int consignorNo;
	private int ccaNo;
	private int productNo;
	private int ciNo;
	private int plNo;
	private String contractType;
	private String contractDate;
	private String contractReceptDate;
	private int contractApprovalYn;
	private int comFileNo;
	private int lastStatusCode;
	
	List<ContractFileAttachVO> contractFileList; // 파일
	List<ContractRecord> contractRecordList; // 상태값들
	
	private ProductVO productVO;
	private CIVO ciVO;
	private PLVO plVO;
	private ConsignorVO consignorVO;
	private CCAVO ccaVO;
	private DeclDVO declDVO;
	private UserVO userVO;
	
	// 사용자 정보 (u_con, u_cca 조인으로 가져온 필드)
	private String consignorName; // u_con.user_name
	private String ccaName; // u_cca.user_name

	// Consignor (위탁자) 상세 정보 (con_detail 조인으로 가져온 필드)
	private String consignorCompanyName; // con_detail.consignor_name
	private String consignorTel; // con_detail.consignor_tel
	private String consignorUserTel; // u_con.user_tel
	private String consignorUserFax; // u_con.user_fax
	private String consignorUserEmail; // u_con.user_email

	// CCA (관세대리인) 상세 정보 (cca_detail 조인으로 가져온 필드)
	private String ccaCompanyName; // cca_detail.cca_name
	private String ccaTel; // cca_detail.cca_tel
	private String ccaUserTel; // u_cca.user_tel
	private String ccaUserFax; // u_cca.user_fax
	private String ccaUserEmail; // u_cca.user_email
	
	private int hsTariffRate;
	
	
	// 나의 대리업무 내역을 위한 필드
	private String userName;
	private String userEmail;
	private String hsCode;
	private String productName;
	private String productQty;
	private String productVolume;
	private int whNo =-1;
	private int containerNo =-1;
	

	

}
