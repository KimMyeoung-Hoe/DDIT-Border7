package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.ContractVO;

public interface IMainService {

	int selectExportCount(); //수출 개수

	int selectImportCount();//수입 개수

	int selectHsCodeCount();//hs코드 개수

	int selectContractCount(); //최근 7일 신규등록 건수

	List<ContractVO> ccaContractList(int ccaNo);//cca의 contractNo 5개 가져옴 ㅇㅇ

	List<ContractVO> consignorContractList(int userNo);//화주의 contractNo 5개 ㅇㅇ

	
}
