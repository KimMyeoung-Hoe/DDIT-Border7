package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.HsStatResult;

@Mapper
public interface IStatisticsMapper {

	public List<Map<String, Object>> qrntAgree(Map<String, Object> startEnd);		// HS 코드 검사 합격율 통계 리스트

	public List<Map<String, Object>> qrntDisAgree(Map<String, Object> startEnd);	// HS 코드 검사 불합율 통계 리스트

	public List<Map<String,Object>>  selectSanctionList(int sanctionCode);//제재내역 통계
	// 물류관리자의 HS코드별 기간 통계
	public List<HsStatResult> logisticsStatisticsHsCodeAndPeriod(int userNo);
	// 화주의 HS코드별 기간 통계
	public List<HsStatResult> consignorStatisticsHsCodeAndPeriod(int userNo);
	// 관세사의 HS코드별 기간 통계
	public List<HsStatResult> ccaStatisticsHsCodeAndPeriod(int userNo);
	// 전체 HS코드별 기간 통계
	public List<HsStatResult> allStatisticsHsCodeAndPeriod();

	public List<Map<String, Object>> servantWorkCount(); //공무원의 업무처리량 통계 리스트
	
	public List<Map<String, Object>> selectAppealList(String appealType); // 민원항목 * 기간 민원발생건수 통계

	/** 기간 * 회원 가입/탈퇴건수 통계 */
	public List<Map<String, Object>> selectUserCountList();
}
