package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.MyCalendarVO;

@Mapper
public interface IMyCalendarMapper {
	public List<MyCalendarVO> calendarList(int userNo) throws Exception;
	public void calendarInsert(MyCalendarVO vo) throws Exception;
	public void calendarUpdate(MyCalendarVO vo);
	public void calendarDelete(int no);
}
