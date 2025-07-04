package kr.or.ddit.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.ICCAMapper;
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

@Service
public class CCAServiceImpl implements ICCAService {

	@Autowired
	ICCAMapper ccaMapper;
	
	//전체 관세사 리스트 가져옴
	@Override
	public List<CCAVO> ccaList() {
		return ccaMapper.ccaList();
	}

	//관세사 상세보기
	@Override
	public CCAVO detailCcaProfile(int ccaNo) {
		return ccaMapper.detailCcaProfile(ccaNo);
	}

	// 페이지네이션 관세사 수 
	@Override
	public int selectCCACount(PaginationInfoVO<CCAVO> pageVo) {
		return ccaMapper.selectCCACount(pageVo);
	}

	//페이지네이션 관세사 리스트
	@Override
	public List<CCAVO> selectCCAList(PaginationInfoVO<CCAVO> pageVo) {
		return ccaMapper.selectCCAList(pageVo);
	}

	// 페이지네이션 주력분야 수
	@Override
	public int checkSpecialTypCodeCount(PaginationInfoVO<CCAVO> pageVo, List<String> specialtyCodes) {
		return ccaMapper.checkSpecialTypCodeCount(pageVo , specialtyCodes);
	}
	
	
	//페이지네이션 주력분야 리스트
	@Override
	public List<CCAVO> checkSpecialtyCodeList(PaginationInfoVO<CCAVO> pageVo , List<String> specialtyCodes) {
		return ccaMapper.checkSpecialtyCodeList(pageVo , specialtyCodes);
	}

	 //페이지네이션 관세사 의뢰내역 수
	@Override
	public int ccaContractCount(PaginationInfoVO<ContractVO> pageVo) {
		return ccaMapper.ccaContractCount(pageVo);
	}

	//페이지네이션 관세사 의뢰내역 리스트
	@Override
	public List<ContractVO> ccaContractList(PaginationInfoVO<ContractVO> pageVo) {
		return ccaMapper.ccaContractList(pageVo);
	}

	@Override// 관세사 신규의뢰내역
	public List<ContractVO> selectNewContract(int userNo) {
		return ccaMapper.selectNewContract(userNo);
	}

	@Override//관세사 상세 의뢰내역
	public ContractVO ccaDetailContract(String contractNo) {
		return ccaMapper.ccaDetailContract(contractNo);
	}

	@Override//관세사 의뢰 내역 담당 공무원
	public UserVO selectServant(String contractNo) {
		return ccaMapper.selectServant(contractNo);
	}

	@Override//관세사 신규 의뢰 개수
	public int selectNewContractCount(int userNo) {
		return ccaMapper.selectNewContractCount(userNo);
	}

	@Override // 한글 표시사항 작성 페이지
	public KRNotationVO koreanLabelWrite(String contractNo) {
		return ccaMapper.koreanLabelWrite(contractNo);
	}

	@Override // 한글표시사항 데이터 삽입
	public ServiceResult koreanLabelInsert(KRNotationVO krNotationVO) {
		ServiceResult result = null;
		
		// 삽입 전 contractNo의 존재 여부를 먼저 확인
		// checkContractNo 메서드를 활용
		if (ccaMapper.checkContractNo(krNotationVO.getContractNo()) > 0) {
			return ServiceResult.EXIST; // 이미 존재하면 EXIST 반환
		}

		// 존재하지 않을 시 삽입 진행
		int status = ccaMapper.koreanLabelInsert(krNotationVO);

		if (status > 0) { 	// 처리 완료 == 1
			result = ServiceResult.OK;
		} else { 			//처리 실패 == 0
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override // 한글표시사항 상세조회
	public KRNotationVO koreanLabelDetail(String contractNo) {
		return ccaMapper.koreanLabelDetail(contractNo);
	}

	@Override // 한글표시사항 데이터 중복 확인
	public boolean checkContractNo(String contractNo) {
		return ccaMapper.checkContractNo(contractNo) > 0;
	}
	@Override//관세사 신규 의뢰 상세 내역
	public ContractVO ccaNewContract(String contractNo) {
		return ccaMapper.ccaNewContract(contractNo);
	}

	@Override//관세사 거절사유 리스트
	public List<ContractRecord> selectRefusalList(String contractNo) {
		return ccaMapper.selectRefusalList(contractNo);
	}

	@Override//관세사 신규 의뢰 거절
	public int contractRefusal(RefusalVO refusalVO) {
		return ccaMapper.contractRefusal(refusalVO);
	}


	@Override //적재신청 - 물류창고 리스트
	public List<WarehouseVO> WarehouseList() {
		return ccaMapper.WarehouseList();
	}

	@Override//관세사 신규 의뢰 승인
	public int contractApproval(RefusalVO refusalVO) {
		return ccaMapper.contractApproval(refusalVO);
	}


	@Override
	public List<ContainerVO> ContainerList() {
		return ccaMapper.ContainerList();
	}

	@Override
	public List<ContractVO> myContract(int userNo) {
		return ccaMapper.myContract(userNo);
	}

	@Override
	public ContractVO contractSelect(String contractNo) {
		return ccaMapper.contractSelect(contractNo);
	}

	@Override // 한글표시사항 데이터 수정
	public ServiceResult koreanLabelUpdate(KRNotationVO krNotationVO) {
		
		ServiceResult result = null;
		
		if (ccaMapper.checkContractNo(krNotationVO.getContractNo()) == 0) {
			return ServiceResult.EXIST; // 존재하지 않으면 EXIST 반환
		}
		
		int status = ccaMapper.koreanLabelUpdate(krNotationVO);


		if (status > 0) { 	// 처리 완료 == 1
			result = ServiceResult.OK;
		} else { 			//처리 실패 == 0
			result = ServiceResult.FAILED;

		}
		
		return result;
	}

	@Override
	public void selectContract(String contractNo) {
		// TODO Auto-generated method stub
		
	}
 
	// 셀렉트 한 창고의 정보 가져옴
	@Override
	public WarehouseVO getSelectWh(List<Integer> whNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override //관세사 수출 개수
	public int selectExportCount(int userNo) {
		return ccaMapper.selectExportCount(userNo);
	}

	@Override//관세사 수입 개수
	public int selectImportCount(int userNo) {
		return ccaMapper.selectImportCount(userNo);
	}

	@Override//관세사 신규 개수
	public int selectNewCount(int userNo) {
		return ccaMapper.selectNewCount(userNo);
	}

	@Override//declNo검색
	public String selectTaxNo(String contractNo) {
		return ccaMapper.selectTaxNo(contractNo);
	}

	@Override//세금 고지서 내역
	public TaxVO selectTaxList(String selectTaxNo) {
		return ccaMapper.selectTaxList(selectTaxNo);
	}

	@Override//수출입신고필증 내역
	public CDVO selectCdList(String selectTaxNo) {
		return ccaMapper.selectCdList(selectTaxNo);
	}

	@Override //관세사 나와의 계약
	public List<ContractVO> selectContractWithMe(int ccaNo, int consignorNo) {
		return ccaMapper.selectContractWithMe(ccaNo,consignorNo);
	}

	@Override//수입상태 카테고리 조회
	public List<ContractRecord> selectOptionCategory(String data) {
		return ccaMapper.selectOptionCategory(data);
	}

	@Override//관세사 오류 점수 부과 내역
	public List<SanctionVO> selectSanctionScore(int ccaNo) {
		return ccaMapper.selectSanctionScore(ccaNo);
	}

	@Override//관세사의 토탈 오류점수
	public SanctionVO selectSanctionTotlaScore(int ccaNo) {
		return ccaMapper.selectSanctionTotlaScore(ccaNo);
	}

	/**
	 * 창고 리스트 페이지 네이션을 위한 메서드 
	 */
	@Override
	public int wareHouseCount(PaginationInfoVO<WarehouseVO> warehousePagingVO) {
		return ccaMapper.wareHouseCount(warehousePagingVO);
	}

	@Override
	public List<WarehouseVO> WarehouseList2(PaginationInfoVO<WarehouseVO> warehousePagingVO) {
		return ccaMapper.WarehouseList2(warehousePagingVO);
	}

	@Override
	public int containerCount(PaginationInfoVO<ContainerVO> containerPagingVO) {
		return ccaMapper.containerCount(containerPagingVO);
	}

	@Override
	public List<ContainerVO> ContainerList2(PaginationInfoVO<ContainerVO> containerPagingVO) {
		return ccaMapper.ContainerList2(containerPagingVO);
	}

	@Override//내보세창고정보
	public MyItemLocationVO selectMyItemLocation(String contractNo) {
		return ccaMapper.selectMyItemLocation(contractNo);
	}

	@Override//내컨테이너
	public MyItemLocationVO selectMyContainerLocation(String contractNo) {
		return ccaMapper.selectMyContainerLocation(contractNo);
	}
}
