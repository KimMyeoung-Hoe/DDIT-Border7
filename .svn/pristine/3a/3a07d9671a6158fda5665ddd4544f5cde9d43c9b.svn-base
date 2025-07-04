package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.AppealVO;
import kr.or.ddit.vo.ComFileDetailVO;
import kr.or.ddit.vo.ComFileVO;
import kr.or.ddit.vo.ContainerDetailVO;
import kr.or.ddit.vo.FAQBoardVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Mapper
public interface IBoardMapper {

	List<FAQBoardVO> selectFaqList(PaginationInfoVO<FAQBoardVO> pageVo); //전체 faq리스트 가져옴

	List<FAQBoardVO> selectCategoryList(); // faq 카테고리 가져옴

	int selectFaqCount(PaginationInfoVO<FAQBoardVO> pageVo); //페이지네이션 faq 개수

	List<FAQBoardVO> categoryBoardList(String categoryValue);//faq 카테고리별 리스트

	int FaqInsert(FAQBoardVO boardVO);//faq insert

	FAQBoardVO faqDetail(int faqNo);//faq상세

	int faqRemove(int faqNo); //faq 삭제

	int faqModify(FAQBoardVO boardVO); //faq 수정

	int selectNoticeCount(PaginationInfoVO<NoticeVO> pageVo);//페이지네이션 notice개수

	List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pageVo); //페이지네이션 notice 리스트

	NoticeVO noticeDetail(int noticeNo); //공지사항 상세

	void incrementHit(int noticeNo); //공지사항 조회수 증가

	int noticeInsert(NoticeVO noticeVO); //공지사항 게시글 등록

	void noticeInsetComfile(ComFileVO comFileVO); //공지사항 게시글 파일

	void noticeInsertComfileDetail(ComFileDetailVO comFileDetailVO); //공지사항 게시글 상세

	String getPicture(int comFileDetailNo); //공지사항 파일 경로 가져오기

	ComFileDetailVO noticeFileDown(int comFileDetailNo); //공지사항 파일 다운

	int noticeUpdate(NoticeVO noticeVO); //공지사항 수정 게시글 수정

	void updateNoticeFileStatus(Integer integer); //공지사항 수정 - 파일 상태 업데이트

	Map<String, Object> selectComfileNo(int noticeNo); //공지사항 수정 -파일 번호

	void deleteComFileDetail(int comFileNo); //공지사항 파일 삭제 - 공통파일 detail

	void deleteComfile(int comFileNo); //공지사항 파일 삭제 - 공통파일

	int noticeRemove(int noticeNo);//공지사항 게시글 삭제 

	List<ComFileDetailVO> selectFilePath(int comFileNo); //공지사항 삭제 파일 리스트

	int ComfileNoSelect(int noticeNo);

	int getappealCount(PaginationInfoVO<AppealVO> pagingVO);

	List<AppealVO> appealList(PaginationInfoVO<AppealVO> pagingVO);

	int registAppeal(AppealVO appealVO);

	void registAppealWithFiles(Map<String, Object> params);


	AppealVO selectAppeal(int appealNo); // 민원사항 선택

	int deleteAppeal(int appealNo);


	int getappealSvtCount(PaginationInfoVO<AppealVO> pagingVO);

	List<AppealVO> appealSvtList(PaginationInfoVO<AppealVO> pagingVO);

	void callRegistAnswerAppealWithFiles(Map<String, Object> paramMap);

	int registAnswerAppeal(AppealVO appealVO);

}
