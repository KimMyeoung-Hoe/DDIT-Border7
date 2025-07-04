package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.BwVO;
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

@Mapper
public interface ICCAMapper {

	List<CCAVO> ccaList(); //관세사 전체 리스트 가져옴

	CCAVO detailCcaProfile(@Param("userNo") int ccaNo); // 관세사 상세

	int selectCCACount(PaginationInfoVO<CCAVO> pageVo); //페이지네이션 전체 관세사 수

	List<CCAVO> selectCCAList(PaginationInfoVO<CCAVO> pageVo);//페이지네이션 전체 관세사 리스트

	int checkSpecialTypCodeCount(@Param("pageVo") PaginationInfoVO<CCAVO> pageVo,  @Param("specialtyCode") List<String> specialtyCodes); //페이지네이션 주력분야 수
	
	List<CCAVO> checkSpecialtyCodeList(@Param("pageVo") PaginationInfoVO<CCAVO> pageVo , @Param("specialtyCode") List<String> specialtyCodes); //주력분야 관세사리스트

	int ccaContractCount(PaginationInfoVO<ContractVO> pageVo); //페이지네이션 관세사 의뢰내역 수

	List<ContractVO> ccaContractList(PaginationInfoVO<ContractVO> pageVo);//페이지네이션 관세사 의뢰내역 리스트

	List<ContractVO> selectNewContract(int userNo);// 관세사 신규 의뢰 내역

	int selectNewContractCount(int userNo); //관세사 신규 의뢰 개수
	
	ContractVO ccaDetailContract(String contractNo); //관세사 상세 의뢰내역

	UserVO selectServant(String contractNo);//관세사 의뢰 내역 담당 공무원

	KRNotationVO koreanLabelWrite(String contractNo); // 한글표시사항 작성

	int koreanLabelInsert(KRNotationVO krNotationVO); // 한글표시사항 DB 데이터 삽입

	KRNotationVO koreanLabelDetail(String contractNo);	// 한글표시사항 상세

	int checkContractNo(String contractNo);	// 한글표시사항 중복 유무

	ContractVO ccaNewContract(String contractNo);//관세사 신규 의뢰 상세 내역

	List<ContractRecord> selectRefusalList(String contractNo); //관세사 거절사유 리스트

	int contractRefusal(RefusalVO refusalVO); //관세사 신규 의뢰 거절
	
	int contractApproval(RefusalVO refusalVO); // 관세사 신규 의뢰 승인

	List<WarehouseVO> WarehouseList(); // 적재신청 - 뮬류창고 리스트

	List<ContainerVO> ContainerList();

	List<ContractVO> myContract(int userNo);

	int koreanLabelUpdate(KRNotationVO krNotationVO);	// 한글표시사항 수정

	ContractVO contractSelect(String contractNo);

	void stowageInsert(Map<String, Object> map);

	void contractRecordInsert(Map<String, Object> map);

	void contractLastCodeUp(Map<String, Object> map);

	int getLastStatusCode(String contractNo);

	void whDetailIst(Map<String, Object> map);


	double residualVolumeCheck(int whNo);

	void whUseYnUpdate(int whNo);


	int selectExportCount(int userNo);//수출 개수

	int selectImportCount(int userNo);//수입 개수

	int selectNewCount(int userNo);//신규 개수


	void containerDetailIst(Map<String, Object> map);

	void containerUseYnUpdate(int containerNo);

	double CresidualVolumeCheck(int containerNo);


	String selectTaxNo(String contractNo);//declNo검색

	TaxVO selectTaxList(String selectTaxNo);//세금 내역 리스트

	CDVO selectCdList(String selectTaxNo); //수출입신고 필증 리스트

	List<ContractVO> selectContractWithMe(@Param("ccaNo") int ccaNo,@Param("consignorNo") int consignorNo);//관세사 나와의 계약

	List<ContractRecord> selectOptionCategory(String data);//수입상태 카테고리 조회

	List<SanctionVO> selectSanctionScore(int ccaNo); //관세사 오류점수 부과 내역

	SanctionVO selectSanctionTotlaScore(int ccaNo); //관세사의 토탈 오류점수

	
	int wareHouseCount(PaginationInfoVO<WarehouseVO> warehousePagingVO);

	List<WarehouseVO> WarehouseList2(PaginationInfoVO<WarehouseVO> warehousePagingVO);

	int containerCount(PaginationInfoVO<ContainerVO> containerPagingVO);

	List<ContainerVO> ContainerList2(PaginationInfoVO<ContainerVO> containerPagingVO);

	MyItemLocationVO selectMyItemLocation(String contractNo);//내 보세창고 정보

	MyItemLocationVO selectMyContainerLocation(String contractNo);//내컨테이너정보

	
}
