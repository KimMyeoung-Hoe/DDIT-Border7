package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class PaginationInfoVO<T> {
	private int totalRecord;		// 총 row수
	private int totalPage;			// 총 페이지 
	private int currentPage;		// 현재 페이지
	private int screenSize = 10;	// 페이지 당 게시글 수
	private int blockSize = 5;		// 페이지 블럭 수
	private int startRow;			// 시작 row
	private int endRow;				// 끝 row
	private int startPage;			// 시작페이지
	private int endPage;			// 끝페이지
	private List<T> dataList;		// 결과를 넣을 데이터 리스트
	
	private String searchType;		// 검색 타입
	private String searchWord;		// 검색 단어
	private String searchStrDate;	// 검색 시작일자
	private String searchEndDate;	// 검색 종료일자

	private String searchStatus;    // 검색 상태
	private String searchCategory;  // 검색 카테고리
	
	private String sortColumn;		// 정렬 기준이 될 컬럼
	private int sortColumnNum;		// 정렬 기준이 될 컬럼(컬럼 순서에 따른 숫자 처리)
	private String sortDirection;	// 정렬 방향
	
	private int userNo;				// 사용자식별번호
	private int searchUserNo;		// 검색할 사용자식별번호
	
	private int whNo;				// 물류창고식별번호
	private int containerNo;		// 컨테이너식별번호
	private String userId;			// 사용자 식별아이디
	private String waitting; 		// 검색조건용 컬럼
	
	public PaginationInfoVO() {}
	
	// PaginationInfoVO 객체를 만들 때, 한 페이지당 게시글 수와 페이지 블록 수를 원하는 값으로 초기화 할 수 있다.
	public PaginationInfoVO(int screenSize, int blockSize) {
		this.screenSize = screenSize;
		this.blockSize = blockSize;	
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage; // 현재 페이지 설정
		// 끝 row = 현제 페이지 * 한페이지당 게시글 수
		this.endRow = currentPage * screenSize;
		// 시작 row = 끝 row - *(한 페이지당 게시글 수 -1)
		this.startRow = endRow - (screenSize - 1);
		// 마지막 = (페이지 현재 페이지 + (페이지 블록 사이즈-1))/ 페이즈 블록사이즈 * 페이지 블록사이즈
		this.endPage = (currentPage + (blockSize - 1)) / blockSize * blockSize;
		// 시작 페이지 = 마지막 페이지 - (페이지 블록사이즈 - 1)
		this.startPage = endPage - (blockSize -1 );
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		// ceil = 올림
		totalPage = (int) Math.ceil(totalRecord / (double)screenSize);
	}
	
	public String getPagingHTML() {
		StringBuffer html = new StringBuffer();
		html.append("<ul class='pagination pagination-sm m-0 float-right'>");
		// prev 1 2 3 4 5 Next
		if(startPage>1) {
			html.append("<li class='page-item'><a href='' class='page-link page-link-Prev' data-page='"
					+(startPage - blockSize)+"'>Prev</a></li>");
		}
		
		// 부트스트랩 기반 클래스 지정
		for(int i = startPage; i <=(endPage < totalPage ? endPage : totalPage); i++) {
			if(i == currentPage){
				html.append("<li class='page-item active'><span class='page-link'>"+i+"</span></li>");
			}else {
				html.append("<li class='page-item'><a href='' class='page-link' data-page='"+i+"'>"+i+"</a></li>");
			}
		}
		
		if(endPage< totalPage) {
			html.append("<li class='page-item'><a href='' class='page-link page-link-Next' data-page='"
					+(endPage+1)+"'>Next</a></li>");
		}
		html.append("</ul>");
		
		return html.toString();
	}
}