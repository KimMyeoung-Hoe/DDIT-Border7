package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.MyCalendarVO;

public interface IMyCalendarService {
	
	/** 로그인사용자의 본인 일정 리스트 추출 기능
	 * @param userNo 로그인사용자 유저식별번호
	 * @return 로그인사용자 일정 리스트
	 * @throws Exception
	 */
	public List<MyCalendarVO> calendarList(int userNo) throws Exception;
	
	/** 로그인사용자의 본인 일정 추가 기능
	 * @param vo
	 * @throws Exception
	 */
	public void calendarInsert(MyCalendarVO vo) throws Exception;
	
	/** 로그인사용자의 본인 일정 수정 기능
	 * @param vo
	 */
	public void calendarUpdate(MyCalendarVO vo);
	
	/** 로그인사용자의 본인 일정 삭제 기능
	 * @param no
	 */
	public void calendarDelete(int no);

}
