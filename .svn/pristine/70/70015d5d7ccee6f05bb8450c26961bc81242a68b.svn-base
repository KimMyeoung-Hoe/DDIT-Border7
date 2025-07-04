package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import io.micrometer.common.util.StringUtils;
import lombok.Data;

@Data
public class NoticeVO {
	private int noticeNo;
	private String noticeRegDate;
	private int regServantNo;
	private String noticeUpdDate;
	private int updServantNo;
	private String noticeTitle;
	private String noticeContent;
	private int noticeHit;
	private int comFileNo;
	private String empNo;
	private String deptName;
	private String userName;
	private String regServantName;
	private String updServantName;
	
	private int rnum; // 페이지네이션에서 결과값 넘버
	

	private Integer[] delFileNo;//삭제할 파일들
	private MultipartFile[] noticeFile;
	private List<ComFileDetailVO> noticeFileList;
	
	public void setNoticeFile(MultipartFile[] noticeFile) {
		this.noticeFile = noticeFile;
		
		if(noticeFile != null) {
			//파일이 존재해서 noticeFile로 매칭이 되면 noticeVO가 만들어지는 순간에 
			//set으로 이걸 넣어줌 ㅇㅇ
			List<ComFileDetailVO> noticeFileList = new ArrayList<>();
			for (MultipartFile item : noticeFile) {
				if(StringUtils.isBlank(item.getOriginalFilename())) {
					continue; //이름 없을때까지 돌린다
				}
				
				ComFileDetailVO comFileDetailVO = new ComFileDetailVO(item);
				noticeFileList.add(comFileDetailVO);
			}
			this.noticeFileList = noticeFileList;
			
		}
		
		
		
	}
	
}
