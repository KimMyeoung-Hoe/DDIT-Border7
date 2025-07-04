package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AppealVO;
import kr.or.ddit.vo.ComFileDetailVO;
import kr.or.ddit.vo.ContainerDetailVO;
import kr.or.ddit.vo.FAQBoardVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IBoardService {

	int selectFaqCount(PaginationInfoVO<FAQBoardVO> pageVo); // 페이지네이션 faq 개수

	List<FAQBoardVO> selectFaqList(PaginationInfoVO<FAQBoardVO> pageVo); // 전체 faq 가져오기

	List<FAQBoardVO> selectCategoryList(); // faq 카테고리 가져오기

	List<FAQBoardVO> categoryBoardList(String categoryValue);// faq 카테고리별 리스트

	int FaqInsert(FAQBoardVO boardVO); // faq 등록

	FAQBoardVO faqDetail(int faqNo); // 상세 faq 조회

	int faqRemove(int faqNo); // faq 삭제

	int faqModify(FAQBoardVO boardVO); // faq 수정

	int selectNoticeCount(PaginationInfoVO<NoticeVO> pageVo);// 페이지네이션 notice 개수

	List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pageVo);// 페이지네이션 notice 리스트

	NoticeVO noticeDetail(int noticeNo); // 공지사항 상세

	String noticeInsert(NoticeVO noticeVO); // 공지사항 등록

	String getPicture(int comFileDetailNo); // 공지사항 파일 경로 가져오기

	ComFileDetailVO noticeFileDown(int comFileDetailNo); // 공지사항 파일 다운

	String noticeUpdate(NoticeVO noticeVO); // 공지사항 업데이트

	Map<String, Object> selectComfileNo(int noticeNo); // 공지사항 업데이트 파일 번호

	String noticeRemove(int noticeNo); // 공지사항 삭제
	/** 민원 리스트 호출을 위한 총 컬럼갯수 */ 
	int getappealCount(PaginationInfoVO<AppealVO> pagingVO);
	/** 민원 리스트 */
	List<AppealVO> appealList(PaginationInfoVO<AppealVO> pagingVO);
	/** 민원 등록 메서드 */
	int registAppeal(AppealVO appealVO);
	/** 민원등록 메서드(파일포함)*/
	int registAppealWithFiles(AppealVO appealVO);
	/** 민원 삭제 메서드 */
	int deleteAppeal(int appealNo);

	int getappealSvtCount(PaginationInfoVO<AppealVO> pagingVO);

	List<AppealVO> appealSvtList(PaginationInfoVO<AppealVO> pagingVO);

	int registAnswerAppealWithFiles(AppealVO appealVO);

	int registAnswerAppeal(AppealVO appealVO);

}
