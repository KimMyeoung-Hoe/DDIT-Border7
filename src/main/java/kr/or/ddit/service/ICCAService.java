package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.CCAVO;
import kr.or.ddit.vo.CDVO;
import kr.or.ddit.vo.ContainerVO;
import kr.or.ddit.vo.ContractRecord;
import kr.or.ddit.vo.ContractVO;
import kr.or.ddit.vo.KRNotationVO;
import kr.or.ddit.vo.MyItemLocationVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.RefusalVO;
import kr.or.ddit.vo.SanctionVO;
import kr.or.ddit.vo.TaxVO;
import kr.or.ddit.vo.UserVO;
import kr.or.ddit.vo.WarehouseVO;

public interface ICCAService {
	
	public List<CCAVO> ccaList(); // 관세사 전체 리스트 조회
	
	public CCAVO detailCcaProfile(int ccaNo); // 관세사 상세보기

	public int selectCCACount(PaginationInfoVO<CCAVO> pageVo); //페이지네이션 총 관세사 수

	public List<CCAVO> selectCCAList(PaginationInfoVO<CCAVO> pageVo); //페이지네이션 총 관세사

	public int checkSpecialTypCodeCount(PaginationInfoVO<CCAVO> pageVo , List<String> specialtyCodes);//페이지네이션 주력분야 수 
	
	public List<CCAVO> checkSpecialtyCodeList(PaginationInfoVO<CCAVO> pageVo , List<String> specialtyCodes); //페이지네이션 주력분야 리스트

	public int ccaContractCount(PaginationInfoVO<ContractVO> pageVo); //페이지네이션 관세사 의뢰내역 수

	public List<ContractVO> ccaContractList(PaginationInfoVO<ContractVO> pageVo); //페이지네이션 관세사 의뢰내역 리스트

	public List<ContractVO> selectNewContract(int userNo); // 관세사 신규 의뢰 내역
	
	public int selectNewContractCount(int userNo); //관세사 신규 의뢰 개수

	public ContractVO ccaDetailContract(String contractNo); //관세사 상세 의뢰내역

	public UserVO selectServant(String contractNo); //관세사 의뢰 내역 담당 공무원

	public KRNotationVO koreanLabelWrite(String contractNo);	// 한글표시사항 작성

	public ServiceResult koreanLabelInsert(KRNotationVO krNotationVO);	// 한글표시사항 DB에 데이터 입력
	
	public KRNotationVO koreanLabelDetail(String contractNo);		// 한글표시사항 상세

	public boolean checkContractNo(String contractNo);		// 한글표시사항 중복 확인

	public ServiceResult koreanLabelUpdate(KRNotationVO krNotationVO);	// 한글표시사항 수정
	

	public ContractVO ccaNewContract(String contractNo); //관세사 신규 의뢰 상세 내역

	public List<ContractRecord> selectRefusalList(String contractNo); //관세사 거절사유 리스트

	public int contractRefusal(RefusalVO refusalVO); //관세사 신규 의뢰 거절

	public int contractApproval(RefusalVO refusalVO); // 관세사 신규 의뢰 승인


	//적재신청을 위한 물류창고, 컨테이너 조회
	public List<WarehouseVO> WarehouseList();
	public List<ContainerVO> ContainerList();

	// 자신의 대리업무 내역
	public List<ContractVO> myContract(int userNo);

	public ContractVO contractSelect(String contractNo);

	public void selectContract(String contractNo);

	public WarehouseVO getSelectWh(List<Integer> whNo);

	public int selectExportCount(int userNo);//수출 개수

	public int selectImportCount(int userNo);//수입 개수

	public int selectNewCount(int userNo);//신규 개수

	public String selectTaxNo(String contractNo);//declNo검색

	public TaxVO selectTaxList(String selectTaxNo); //세금 고지서 내역

	public CDVO selectCdList(String selectTaxNo);//수/출입신고 필증 내역

	public List<ContractVO> selectContractWithMe(int ccaNo, int consignorNo);//관세사 - 나와계약 내용

	public List<ContractRecord> selectOptionCategory(String data);//수입상태 카테고리 조회

	public List<SanctionVO> selectSanctionScore(int ccaNo);//관세사의 오류점수 부과 내역

	public SanctionVO selectSanctionTotlaScore(int ccaNo);//관세사의 토탈 오류점수

	/**
	 * 창고 토탈 계수 가져오기
	 * @param warehousePagingVO
	 * @return
	 */
	public int wareHouseCount(PaginationInfoVO<WarehouseVO> warehousePagingVO);

	/**
	 * 창고 리스트 가져오기
	 * @param warehousePagingVO
	 * @return
	 */
	public List<WarehouseVO> WarehouseList2(PaginationInfoVO<WarehouseVO> warehousePagingVO);

	/**
	 * 컨테이너 토탈 계수 가저오기
	 * @param containerPagingVO
	 * @return
	 */
	public int containerCount(PaginationInfoVO<ContainerVO> containerPagingVO);

	/**
	 * 컨테이너 리스트 가져오기
	 * @param containerPagingVO
	 * @return
	 */
	public List<ContainerVO> ContainerList2(PaginationInfoVO<ContainerVO> containerPagingVO);

	public MyItemLocationVO selectMyItemLocation(String contractNo); //내 보세창고 정보

	public MyItemLocationVO selectMyContainerLocation(String contractNo);//내 컨테이너
}
