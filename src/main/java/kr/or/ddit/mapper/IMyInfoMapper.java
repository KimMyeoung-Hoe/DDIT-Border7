package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.CCAVO;
import kr.or.ddit.vo.ConsignorVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.LogistMngVO;
import kr.or.ddit.vo.ServantVO;
import kr.or.ddit.vo.UserVO;

@Mapper
public interface IMyInfoMapper {
	// 내 정보 조회 기능 -----------------------------------------------------------
	public UserVO myInfoUser(int userNo);										// 유저 테이블 정보
	public ServantVO myInfoServant(int userNo);									// 공무원 테이블 정보
	public String selectJobGradeName(String jobGradeCode);						// 공무원의 직급 명칭
	public DeptVO selectDept(String deptCode);									// 공무원의 부서 정보
	public ConsignorVO myInfoConsignor(int userNo);								// 화주 테이블 정보
	public CCAVO myInfoCca(int userNo);											// 관세사 테이블 정보
	public List<String> myInfoCcaSpecialtyCodeList(int userNo);					// 관세사의 주력분야 코드 리스트
	public List<String> myInfoCcaSpecialtyNameList(int userNo);					// 관세사의 주력분야 이름 리스트
	public List<Map<String, Object>> myInfoCcaContractList(int userNo);			// 관세사의 업무이력 리스트
	public LogistMngVO myInfoLogistMng(int userNo);								// 물류관리자 테이블 정보
	
	// 내 정보 수정 기능 -----------------------------------------------------------
	public int myInfoUpdateSvt(UserVO userVO);									// 유저 테이블(공무원) 수정
	public void myInfoUserUpdate(UserVO userVO);								// 유저 테이블 수정
	public int myInfoConsignorUpdate(ConsignorVO consignorVO);					// 화주 테이블 수정
	public void myInfoCcaUpdate(CCAVO ccaVO);									// 관세사 테이블 수정
	public void myInfoCcaSpecialtyDelete(int userNo);							// 관세사 주력분야 삭제
	public void myInfoCcaSpecialtyInsert(Map<String, Object> map);				// 관세사 주력분야 추가
	public int myInfoLogistMngUpdate(LogistMngVO logistMngVO);					// 물류관리자 테이블 수정
	
	// 탈퇴 기능 -----------------------------------------------------------
	public int myInfoDelete(String userId);										// 유저 테이블 수정(탈퇴여부 및 탈퇴일자)
}