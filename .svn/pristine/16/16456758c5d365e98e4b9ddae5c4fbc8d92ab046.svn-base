package kr.or.ddit.contract.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.ContractVO;
import kr.or.ddit.vo.DeclDVO;
import kr.or.ddit.vo.HsCodeVO;
import kr.or.ddit.vo.ProductVO;
import kr.or.ddit.vo.TaxVO;

public interface IContractService {


	/**
	 * String hsSearchType, String hsSearchWord 
	 * 에서 맵으로 파리미터 변경
	 */
	public List<HsCodeVO> hsCodeSearch(Map<String, String> searchMap);

	public ServiceResult insertContract(ContractVO contractVO, ProductVO productVO);
	
	public ServiceResult updateContract(ContractVO contractVO, ProductVO productVO);

	public ContractVO selectContract(String contractNo);

	public ServiceResult insertDeclD(DeclDVO declDVO);

	/**
	 * 통관의뢰에 대한 수출입 신고서가 있는지 확인
	 * @param contractNo
	 * @return
	 */
	public int declDCehck(String contractNo);

	public ContractVO selectdeclDToContract(String contractNo);

	
	public ServiceResult updateContractWithAttachment(String contractNo, int attachedFileNo, String declDNo);

	/**
	 * 통관의뢰 마지막 상태코드 값 가져오기
	 * @param contractNo
	 * @return
	 */
	public int getStatusCode(String contractNo);

	/**
	 * 통관의뢰 이력에 추가
	 * @param contractNo
	 * @return
	 */
	public ServiceResult insertContractRecord(String contractNo);

	/**
	 * declDNo로 수출입신청서 정보 가져오기
	 * @param declDNo
	 * @return
	 */
	public DeclDVO selectdeclD(String declDNo);

	/**
	 * 수출입신고서 작성시 관세사기 입력해야 하는 값 업데이트
	 * @param declDVO
	 * @return
	 */
	public ServiceResult updateDeclD(DeclDVO declDVO);

	/**
	 * 과세가격 계산해서 가져오기
	 * @param productQty
	 * @param productPrice
	 * @return
	 */
	public int getCustomsValue(String productQty, int productPrice);
	
	/**
	 * 총송장금액 계산해서 가져오기
	 * @param customsValue
	 * @param hsTariffRate
	 * @return
	 */
	public int getTotalCost(int customsValue, int hsTariffRate);

	/**
	 * 작성중인 계약이 있으나 ci/pl을 작성하지않아 스테이터 코드가 null인게 있는지 확인
	 * @param userNO
	 * @return
	 */
	public ContractVO checkContract(int userNO);

	/**
	 * 계약 삭제
	 * @param contractNo
	 * @return
	 */
	public ServiceResult contractDel(String contractNo);

	/** 세금 정보 출력
	 * @param declNo (String)신고서처리업무 일련번호
	 * @return TaxVO 담당공무원, 관세사, 화주의 간단한 정보를 포함한 세금 정보
	 */
	public TaxVO taxDetail(String declNo);

	/** 카카오페이 결제준비
	 * @param taxNo (int)세금 일련번호
	 * @param taxAmount (int)납부금액
	 * @param contractNo (String)관세대리업무계약 번호
	 * @return TaxVO
	 */
	public TaxVO taxReady(int taxNo, int taxAmount, String declNo, String contractNo);

	/** 카카오페이 결제승인
	 * @param tid
	 * @param pgToken
	 * @return
	 */
	public TaxVO taxApprove(String tid, String pgToken);

	/** 세금 납부여부, 실제납부금액, 납부일시 업데이트
	 * @param taxVO
	 */
	public void updateTax(TaxVO taxVO);

}
