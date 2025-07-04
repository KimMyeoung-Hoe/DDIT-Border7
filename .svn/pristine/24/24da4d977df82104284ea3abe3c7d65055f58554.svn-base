package kr.or.ddit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IMainMapper;
import kr.or.ddit.vo.ContractVO;

@Service
public class MainServiceImpl implements IMainService {

	@Autowired
	private IMainMapper mainMapper;
	
	@Override//수출개수
	public int selectExportCount() {
		return mainMapper.selectExportCount();
	}

	@Override//수입개수
	public int selectImportCount() {
		return mainMapper.selectImportCount();
	}

	@Override//hs코드개수
	public int selectHsCodeCount() {
		return mainMapper.selectHsCodeCount();
	}

	@Override//최근 7일 신규등록 건수
	public int selectContractCount() {
		return mainMapper.selectContractCount();
	}

	@Override//ccaContract 5개
	public List<ContractVO> ccaContractList(int ccaNo) {
		return mainMapper.ccaContractList(ccaNo);
	}

	@Override//consignor의 Contract5개
	public List<ContractVO> consignorContractList(int userNo) {
		return mainMapper.consignorContractList(userNo);
	}

}
