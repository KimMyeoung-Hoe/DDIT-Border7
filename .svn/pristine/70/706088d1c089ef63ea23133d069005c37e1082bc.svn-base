package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.HsCodeVO;
import kr.or.ddit.vo.PeriodStat;
import kr.or.ddit.vo.UserVO;

public interface IStatisticsService {

	public List<Map<String, Object>> hsCodeQrntAgree(Map<String, Object> startEnd);			// HS 코드 검사 합격율 통계 리스트

	public List<Map<String, Object>> hsCodeQrntDisAgree(Map<String, Object> startEnd);			// HS 코드 검사 불합율 통계 리스트
	
	public List<Map<String,Object>>  selectSanctionList(int sanctionCode);//제재내역 통계 리스트

	public Map<HsCodeVO, Map<String, PeriodStat>> myStatisticsHsCodeAndPeriod(UserVO user); // HS코드별 기간 통계 (자신의것)

	public Map<HsCodeVO, Map<String, PeriodStat>> allStatisticsHsCodeAndPeriod(); // HS코드별 기간 통계 전체

	public List<Map<String, Object>> servantWorkCount(); //공무원의 업무처리량 통계 리스트
	
	public List<Map<String, Object>> selectAppealList(String appealType);	// 민원항목 * 기간 민원발생건수 통계

	/** 기간 * 회원 가입/탈퇴건수 통계 */
	public List<Map<String, Object>> selectUserCountList();
}
