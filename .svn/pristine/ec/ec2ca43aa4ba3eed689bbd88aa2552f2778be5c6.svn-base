package kr.or.ddit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IConsignorMapper;
import kr.or.ddit.vo.ContractFileAttachVO;
import kr.or.ddit.vo.ContractRecord;
import kr.or.ddit.vo.ContractVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ShipsVO;

@Service
public class ConsignorServiceImpl implements IConsignorSerivce {

	@Autowired
	private IConsignorMapper consignorMapper;
	
	@Override //userNo 조회
	public int selectUserNo(String userId) {
		return consignorMapper.selectUserNo(userId);
	}

	@Override // 페이지네이션 화주의 관세대리업무 신청내역 수
	public int selectContract(PaginationInfoVO<ContractVO> pageVo) {
		return consignorMapper.selectContract(pageVo);
	}

	@Override //페이지네이션 화주의 관세대리업무 신청내역 리스트
	public List<ContractVO> selectContractList(PaginationInfoVO<ContractVO> pageVo) {
		return consignorMapper.selectContractList(pageVo);
	}

	@Override //화주의 관세대리업무 상세
	public ContractVO detailContract(String contractNo) {
		return consignorMapper.detailContract(contractNo);
	}

	@Override// 관세대리업무 카테고리 바
	public List<ContractRecord> categoryBar(String contractNo) {
		return consignorMapper.categoryBar(contractNo);
	}

	@Override // 카테고리바 상세내역
	public List<ContractRecord> findStatusCode(String param , String contractNo) {
		return consignorMapper.findStatusCode(param,contractNo);
	}

	@Override//화주의 상세 파일들
	public List<ContractFileAttachVO> selectDeclNo(String contractNo) {
		return consignorMapper.selectDeclNo(contractNo);
	}

	@Override
	public ShipsVO selectShip(String contractNo) {
		return consignorMapper.selectShip(contractNo);
	}

}
