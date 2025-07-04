package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.CCAVO;
import kr.or.ddit.vo.ConsignorVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.LogistMngVO;
import kr.or.ddit.vo.ServantVO;
import kr.or.ddit.vo.UserVO;

public interface IMyInfoService {
	// 내 정보 조회 기능 -----------------------------------------------------------
	/** 유저정보 읽기
	 * @param userNo
	 * @return (UserVO)사용자VO
	 */
	public UserVO myInfoUser(int userNo);
	
	/** 공무원정보 읽기
	 * @param userNo
	 * @return (ServantVO)공무원VO
	 */
	public ServantVO myInfoServant(int userNo);
	
	/** 공무원직급명칭 읽기
	 * @param jobGradeCode (int)공무원직급코드
	 * @return (String)공무원직급명칭
	 */
	public String selectJobGradeName(String jobGradeCode);
	
	/** 공무원부서정보 읽기
	 * @param deptCode
	 * @return (DeptVO)부서VO
	 */
	public DeptVO selectDept(String deptCode);

	/** 화주정보 읽기
	 * @param userNo
	 * @return (ConsignorVO)화주VO
	 */
	public ConsignorVO myInfoConsignor(int userNo);
	
	/** 관세사정보 읽기
	 * @param userNo
	 * @return (CCAVO)관세사VO
	 */
	public CCAVO myInfoCca(int userNo);
	
	/** 관세사주력분야코드 읽기
	 * @param userNo
	 * @return (List<Integer>)주력분야코드List
	 */
	public List<String> myInfoCcaSpecialtyCodeList(int userNo);
	
	/** 관세사주력분야이름 읽기
	 * @param userNo
	 * @return (List<String>)주력분야이름List
	 */
	public List<String> myInfoCcaSpecialtyNameList(int userNo);

	/** 관세사 업무이력
	 * @param userNo
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> myInfoCcaContractList(int userNo);
	
	/** 물류관리자정보 읽기
	 * @param userNo
	 * @return (LogistMngVO)물류관리자VO
	 */
	public LogistMngVO myInfoLogistMng(int userNo);
	
	// 내 정보 수정 기능 -----------------------------------------------------------
	/** 공무원 정보 수정
	 * @param userVO
	 * @return ServiceResult
	 */
	public ServiceResult myInfoUpdateSvt(UserVO userVO);
	
	/** 화주 정보 수정
	 * @param userVO 화주정보VO를 포함한 유저정보VO
	 * - 유저 테이블 UPDATE
	 * - 화주 테이블 UPDATE
	 * @return ServiceResult
	 */
	public ServiceResult myInfoConsignorUpdate(UserVO userVO);
	
	/** 관세사 정보 수정
	 * - 유저 테이블 UPDATE
	 * - 관세사 테이블 UPDATE
	 * - 주력분야 테이블 DELETE
	 * - 주력분야 테이블 INSERT
	 * @param userVO 관세사정보VO를 포함한 유저정보VO
	 * @return ServiceResult
	 */
	public ServiceResult myInfoCcaUpdate(UserVO userVO);

	/** 물류관리자 정보 수정
	 * - 유저 테이블 UPDATE
	 * - 물류관리자 테이블 UPDATE
	 * @param userVO 물류관리자
	 * @return ServiceResult
	 */
	public ServiceResult myInfoLogistMngUpdate(UserVO userVO);
	
	// 탈퇴 기능 -----------------------------------------------------------
	/** 유저테이블 탈퇴 처리
	 * - USER_STATUS : 0 → 1로 수정
	 * - WITHDRAW_DATE : SYSDATE
	 * @param userId (String)로그인사용자Id
	 * @return ServiceResult
	 */
	public ServiceResult myInfoDelete(String userId);
}
