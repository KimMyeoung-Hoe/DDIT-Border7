package kr.or.ddit.contract.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.ContractVO;
import kr.or.ddit.vo.DeclDVO;
import kr.or.ddit.vo.DeclVO;
import kr.or.ddit.vo.HsCodeVO;
import kr.or.ddit.vo.ProductVO;
import kr.or.ddit.vo.TaxVO;

@Mapper
public interface IContractMapper {
	
	/**
	 * hs코드 조회 ajax
	 * @Param("hsSearchType") String hsSearchType,@Param("hsSearchWord") String hsSearchWord
	 * map으로 변경
	 * @param hsSearchType
	 * @param hsSearchWord
	 * @return
	 */
	public List<HsCodeVO> hsCodeSearch(Map<String, String> searchMap);
	
	/**
	 * 통관의뢰 신청 정보 넣기
	 * @param productVO
	 * @return
	 */
	public int insertContract(ContractVO contractVO);

	/**
	 * 통관의뢰 신청 중 물건정보 넣기
	 * @param productVO
	 * @return
	 */
	public int insertProduct(ProductVO productVO);

	/**
	 * 통관의뢰 이력 등록
	 * @param map
	 * @return
	 */
	public int insertContractRecord(Map<String,Object> map);
	
	/**
	 * 계약의 물품 정보 수정
	 * @param productVO
	 * @return
	 */
	public int updateProduct(ProductVO productVO);
	
	/**
	 * 계약의 정보 수정
	 * @param contractVO
	 * @return
	 */
	public int updateContract(ContractVO contractVO);
	
	/**
	 * 통관의뢰 1차 ci/pl 작성전
	 * @param contractNo
	 * @return
	 */
	public ContractVO selectContract(String contractNo);
	
	//
	/**
	 * 수입신고서 쓰기하면 바로 생성 
	 * 작성버튼 누르면 번호 할당되게 해야함
	 * @param declDVO
	 * @return
	 */
	public int insertDeclD(DeclDVO declDVO);
	
	/**
	 * 수출입신고서 있는지 체크
	 * @param contractNo
	 * @return
	 */
	public int declDCehck(String contractNo);
	
	/**
	 * contractNo 로 ContractVO 정보 가져오기
	 * @param contractNo
	 * @return
	 */
	public ContractVO selectdecld(String contractNo);
	
	/**
	 * 
	 * @param contractNo
	 * @param attachedFileNo
	 */
	public int updateContractAttachment(Map<String,Object> map);

	/**
	 * 통관의뢰 마지막 상태코드 값 가져오기
	 * @param contractNo
	 * @return
	 */
	public int getStatusCode(String contractNo);

	/**
	 * declDNo로 수출입신청서 정보가져오기
	 * @param declDNo
	 * @return
	 */
	public DeclDVO selectdeclD(String declDNo);

	/**
	 * 수출입신고서 작성시 관세사가 입력해야 하는 값 업데이트
	 * @param declDVO
	 * @return
	 */
	public int updateDeclD(DeclDVO declDVO);

	/**
	 * 신고서 인서트
	 * @param declVO
	 * @return
	 */
	public int insertDecl(DeclVO declVO);

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
	public int contractDel(String contractNo);

	/**
	 * decl이 있는지 확인하기위해
	 * @param contractNo
	 * @return
	 */
	public DeclVO selectDecl(String contractNo);

	/**
	 * decl이 있을때 는 업데이트로 변경
	 * @param declVO
	 * @return
	 */
	public int updateDecl(DeclVO declVO);


	//통관의뢰 중간 저장 하기 ---------------------대기
	
	
	/** 세금 정보 출력
	 * @param declNo (String)신고서처리업무 일련번호
	 * @return TaxVO 담당공무원, 관세사, 화주의 간단한 정보를 포함한 세금 정보
	 */
	public TaxVO taxDetail(String declNo);

	/** 세금 납부여부, 실제납부금액, 납부일시 업데이트
	 * @param taxVO
	 */
	public void updateTax(TaxVO taxVO);

	public void updateStatusCode(TaxVO taxVO);

	public void insertContractRecode(TaxVO taxVO);

}
