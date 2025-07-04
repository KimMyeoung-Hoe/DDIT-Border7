package kr.or.ddit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IMyCalendarMapper;
import kr.or.ddit.user.mapper.IUserMapper;
import kr.or.ddit.vo.MyCalendarVO;

@Service
public class MyCalendarServiceImpl implements IMyCalendarService {

	@Autowired
	private IMyCalendarMapper myCalendarMapper;
	
//	달력 일정 조회
	@Override
	public List<MyCalendarVO> calendarList(int userNo) throws Exception {
		return myCalendarMapper.calendarList(userNo);
	}

//	달력 일정 추가
	@Override
	public void calendarInsert(MyCalendarVO vo) throws Exception {
		myCalendarMapper.calendarInsert(vo);
	}

//	달력 일정 수정
	@Override
	public void calendarUpdate(MyCalendarVO vo) {
		myCalendarMapper.calendarUpdate(vo);
	}

//	달력 일정 삭제
	@Override
	public void calendarDelete(int no) {
		myCalendarMapper.calendarDelete(no);
	}
}
