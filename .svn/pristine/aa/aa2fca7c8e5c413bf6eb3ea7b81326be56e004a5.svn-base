package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.ComFileDetailVO;
import kr.or.ddit.vo.MyMailVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Mapper
public interface IMyMailMapper {
	// 템플릿 관련 기능 ---------------------------------------------------------
	public int mailTInsert(MyMailVO myMailVO);
	public int mailTDelete(int emailTempNo);
	
	// 메일 조회 기능 ---------------------------------------------------------
	public MyMailVO selectMailAllCount(int userNo);
	public List<Map<String, Object>> selectMailList(PaginationInfoVO<Map<String, Object>> pagingVO);
	public List<Map<String, Object>> selectTempMailList(PaginationInfoVO<Map<String, Object>> pagingVO);
	public List<Map<String, Object>> selectTrashMailList(PaginationInfoVO<Map<String, Object>> pagingVO);
	
	// 메일 상세 조회 기능 ---------------------------------------------------------
	public MyMailVO mailDetail(int emailNo);
	public List<ComFileDetailVO> mailDetailFiles(int comFileNo);
	public ComFileDetailVO mailDetailFileOne(int comFileDetailNo);
	
	// 메일 작성 기능 ---------------------------------------------------------
	public int mailTempInsert(MyMailVO myMailVO);
	public int mailTempUpdate(MyMailVO myMailVO);
	public int mailRecipListDelete(int emailNo);
	public void mailRecipListInsert(MyMailVO myMailVO);
	public int mailSendInsert(MyMailVO myMailVO);
	public int mailSendUpdate(MyMailVO myMailVO);
	
	// 메일 읽음/휴지통/삭제 기능 ---------------------------------------------------------
	public void mailRead(int recipNo);
	public void mailTrashRecip(int recipNo); // 받은 메일 휴지통으로
	public void mailTrashSend(Object emailNoObj); // 본인이 작성한 메일 휴지통으로
	public void mailDeleteRecip(int recipNo); // 받은 메일 삭제
	public void mailDeleteSend(int emailNo); // 본인이 작성한 메일 삭제
	
	// 중요한 메일 설정 기능 ---------------------------------------------------------
	public void updateStar(MyMailVO myMailVO); // 중요한 메일 설정
	
	// 메일 파일 발송 및 임시저장 기능 ---------------------------------------------------------
	public void mailComFileDetailDelete(int comFileNo);
	public void mailComFileDelete(MyMailVO myMailVO);
	public void mailComFileInsert(MyMailVO myMailVO);
	public void mailComFileDetailInsert(ComFileDetailVO comFileDetailVO);
	
	
}
