package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.ContractFileAttachVO;
import kr.or.ddit.vo.ContractRecord;
import kr.or.ddit.vo.ContractVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ShipsVO;

public interface IConsignorSerivce {

	public int selectUserNo(String userId); //user_no 조회

	public int selectContract(PaginationInfoVO<ContractVO> pageVo); //페이지네이션 화주의 관세대리업무 신청내역 수

	public List<ContractVO> selectContractList(PaginationInfoVO<ContractVO> pageVo);  //페이지네이션 화주의 관세대리업무 신청내역 리스트

	public ContractVO detailContract(String contractNo); //화주의 관세대리업무 상세

	public List<ContractRecord> categoryBar(String contractNo); // 관세대리업무 카테고리 바

	public List<ContractRecord> findStatusCode(String param , String contractNo); //카테고리바 상세내역

	public List<ContractFileAttachVO> selectDeclNo(String contractNo); // 화주의 상세 파일들

	public ShipsVO selectShip(String contractNo); // 화주의 배정보

	

}
