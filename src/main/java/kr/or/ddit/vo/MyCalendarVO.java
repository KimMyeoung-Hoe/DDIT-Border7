package kr.or.ddit.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

/** 일정VO */
@Data
public class MyCalendarVO {
//	public static final String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
	private int calendarNo;					// 일정 번호
    private String calendarTitle;			// 일정 제목
    private String calendarStrDate;			// 일정 시작일시
    private String calendarEndDate;			// 일정 종료일시
    private boolean calendarAllYn;			// 종일일정 여부
    private String calendarType;			// 일정 구분
    private String calendarColor;			// 일정 지정색상
    private String calendarRegDate;			// 일정 최종수정일시
    
    private int userNo;						// 사용자 식별번호
    
    private Date calendarStrDt;
    private Date calendarEndDt;
    
//    public String getCalendarStrDate() {
//    	String result = "";
//    	if(this.calendarStrDt != null) {
//    		result = new SimpleDateFormat(DATE_TIME_FORMAT).format(calendarStrDt);
//    	}
//    	return result;
//    }
//    
//    public String getCalendarEndDate() {
//    	String result = "";
//    	if(this.calendarEndDt != null) {
//    		result = new SimpleDateFormat(DATE_TIME_FORMAT).format(calendarEndDt);
//    	}
//    	return result;
//    }
    
    
}
