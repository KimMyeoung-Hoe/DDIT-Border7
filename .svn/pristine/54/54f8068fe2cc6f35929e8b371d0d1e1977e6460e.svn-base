package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.ComFileDetailVO;
import kr.or.ddit.vo.MyMailVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IMyMailService {
	// 템플릿 관련 기능 ---------------------------------------------------------
	/** 템플릿 저장
	 * @param myMailVO
	 * @return ServiceResult
	 */
	public ServiceResult mailTInsert(MyMailVO myMailVO);

	/** 템플릿 삭제
	 * @param emailTempNo 삭제할 템플릿 일련번호
	 * @return ServiceResult
	 */
	public ServiceResult mailTDelete(int emailTempNo);

	// 메일 목록 조회 기능 ---------------------------------------------------------
	/** 전체 메일함 각 row COUNT
	 * @param userNo
	 * @return int
	 */
	public MyMailVO selectMailAllCount(int userNo);

	/** 전체메일함, 보낸메일함, 받은메일함 리스트 */
	public List<Map<String, Object>> selectMailList(PaginationInfoVO<Map<String, Object>> pagingVO);

	/** 임시보관함 리스트 */
	public List<Map<String, Object>> selectTempMailList(PaginationInfoVO<Map<String, Object>> pagingVO);

	/** 휴지통 리스트 */
	public List<Map<String, Object>> selectTrashMailList(PaginationInfoVO<Map<String, Object>> pagingVO);
	
	// 메일 상세 조회 ---------------------------------------------------------
	/** 메일 상세 조회 */
	public MyMailVO mailDetail(int emailNo);
	/** 메일 상세 파일 조회 */
	public List<ComFileDetailVO> mailDetailFiles(int comFileNo);
	/** 메일 상세 파일 1개 조회 */
	public ComFileDetailVO mailDetailFileOne(int comFileDetailNo);
	
	// 메일 작성 기능 ---------------------------------------------------------
	/** 임시보관함 추가 기능 */
	public ServiceResult mailTempSave(MyMailVO myMailVO);
	/** 발송 기능 */
	public ServiceResult mailSend(MyMailVO emailData);

	// 메일 기타 처리 ---------------------------------------------------------
	/** 읽음 처리 기능 */
	public ServiceResult mailRead(List<Map<String, Object>> selectMailList);

	/** 휴지통 이동 기능 */
	public ServiceResult mailTrash(List<Map<String, Object>> selectMailList);

	/** 삭제 기능 */
	public ServiceResult mailDelete(List<Map<String, Object>> selectMailList);

	/** 중요한 메일 설정 기능 */
	public ServiceResult updateStar(MyMailVO myMailVO);

	/** 외부메일 발송 */
	public ServiceResult mailGmailSend(MyMailVO myMailVO);







}
