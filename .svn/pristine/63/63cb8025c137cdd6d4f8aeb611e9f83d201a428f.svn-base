package kr.or.ddit.service;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Array;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.itextpdf.styledxmlparser.jsoup.select.Evaluator.IsEmpty;

import kr.or.ddit.mapper.IBoardMapper;
import kr.or.ddit.vo.AppealVO;
import kr.or.ddit.vo.ComFileDetailVO;
import kr.or.ddit.vo.ComFileVO;
import kr.or.ddit.vo.ContainerDetailVO;
import kr.or.ddit.vo.FAQBoardVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import oracle.jdbc.OracleConnection;


import java.sql.SQLException;


@Service
public class BoardServiceImpl implements IBoardService {
	
	@Autowired
	private DataSource dataSource;
	
	@Value("${kr.or.ddit.upload.path}")
	private String uploadPath;

	@Autowired
	private IBoardMapper boardMapper;

	@Override // 페이지네이션 faq 개수
	public int selectFaqCount(PaginationInfoVO<FAQBoardVO> pageVo) {
		return boardMapper.selectFaqCount(pageVo);
	}

	@Override // 페이지네이션 faq리스트
	public List<FAQBoardVO> selectFaqList(PaginationInfoVO<FAQBoardVO> pageVo) {
		return boardMapper.selectFaqList(pageVo);
	}

	@Override // faq 카테고리 가져오기
	public List<FAQBoardVO> selectCategoryList() {
		return boardMapper.selectCategoryList();
	}

	@Override // faq 카테고리별 리스트
	public List<FAQBoardVO> categoryBoardList(String categoryValue) {
		return boardMapper.categoryBoardList(categoryValue);
	}

	@Override // faq insert
	public int FaqInsert(FAQBoardVO boardVO) {
		return boardMapper.FaqInsert(boardVO);
	}

	@Override // faq상세
	public FAQBoardVO faqDetail(int faqNo) {
		return boardMapper.faqDetail(faqNo);
	}

	@Override
	public int faqRemove(int faqNo) {
		return boardMapper.faqRemove(faqNo);
	}

	@Override
	public int faqModify(FAQBoardVO boardVO) {
		return boardMapper.faqModify(boardVO);
	}

	@Override
	public int selectNoticeCount(PaginationInfoVO<NoticeVO> pageVo) {
		return boardMapper.selectNoticeCount(pageVo);
	}

	@Override
	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pageVo) {
		return boardMapper.selectNoticeList(pageVo);
	}

	@Override
	public NoticeVO noticeDetail(int noticeNo) {
		boardMapper.incrementHit(noticeNo);
		return boardMapper.noticeDetail(noticeNo);
	}

	@Override
	public String noticeInsert(NoticeVO noticeVO) {
		String result = "";

		if (noticeVO.getNoticeFileList().size() > 0 && noticeVO.getNoticeFileList() != null) {
			//파일이 있을때
			ComFileVO comFileVO = new ComFileVO();
			comFileVO.setUserNo(noticeVO.getRegServantNo()); //현재 로그인한 공무원번호 넣어줌
			
			boardMapper.noticeInsetComfile(comFileVO);//comfile 테이블에 insert
			noticeVO.setComFileNo(comFileVO.getComFileNo());//comfileNo를 noticeVo에 넣어줌
		}

		int status = boardMapper.noticeInsert(noticeVO);// 공지 등록함

		if (status > 0) {
			// 공지사항 등록완
			
			List<ComFileDetailVO> noticeFileList = noticeVO.getNoticeFileList();
			
			if (noticeFileList.size() > 0 && noticeFileList != null) {
				try {
					// 파일업로드
					noticeFileUpload(noticeFileList, noticeVO.getComFileNo());
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			
			result = "SUCCESS";
		}else {
			result = "FAIL";
		}
		

		return result;
	}

	// 파일 업로드 메소드
	private void noticeFileUpload(List<ComFileDetailVO> noticeFileList, int comfileNo) throws Exception {
		if (noticeFileList != null && !noticeFileList.isEmpty()) {
			// 파일이 있으면
			for (ComFileDetailVO comFileDetailVO : noticeFileList) {
				String saveName = UUID.randomUUID().toString(); // 랜덤 파일명 생성
				saveName += "_" + comFileDetailVO.getComFileDetailOriginalName().replaceAll(" ", "_");// 공백은 _로 연결
				String saveLocate = uploadPath + "/notice/" + comfileNo;

				File file = new File(saveLocate);
				if (!file.exists()) {
					// 파일이 없으면
					file.mkdirs(); // 만들어라
				}

				saveLocate += "/" + saveName;
				
				//파일 db저장
				comFileDetailVO.setComFileNo(comfileNo);//공지 게시글 번호
				comFileDetailVO.setComFileDetailSavePath(saveLocate);//파일 업로드 경로
				boardMapper.noticeInsertComfileDetail(comFileDetailVO);//db 저장
				
				File saveFile = new File(saveLocate);//완성된 경로를 이용해 file객체 생성
				comFileDetailVO.getItem().transferTo(saveFile); //파일 복사

			}
		}
	}

	@Override//공지사항 경로 가져오기
	public String getPicture(int comFileDetailNo) {
		return boardMapper.getPicture(comFileDetailNo);
	}

	@Override//공지사항 파일 다운
	public ComFileDetailVO noticeFileDown(int comFileDetailNo) {
		return boardMapper.noticeFileDown(comFileDetailNo);
	}

	@Override//공지사항 업데이트
	public String noticeUpdate(NoticeVO noticeVO) {
		String result = null;
		
		if (noticeVO.getNoticeFileList().size() > 0 && noticeVO.getNoticeFileList() != null) {
			//파일이 있을때
			ComFileVO comFileVO = new ComFileVO();
			comFileVO.setUserNo(noticeVO.getUpdServantNo()); //현재 로그인한 공무원번호 넣어줌
			
			boardMapper.noticeInsetComfile(comFileVO);//comfile 테이블에 insert
			noticeVO.setComFileNo(comFileVO.getComFileNo());//comfileNo를 noticeVo에 넣어줌
		}
		int status = boardMapper.noticeUpdate(noticeVO);
		
		if (status > 0) {
			//게시글만 수정이 완료됨
			List<ComFileDetailVO> noticeFileList = noticeVO.getNoticeFileList();
			if (noticeFileList.size() > 0 && noticeFileList != null ) {
				try {
					noticeFileUpload(noticeFileList, noticeVO.getComFileNo());
					Integer[] delFileNo = noticeVO.getDelFileNo();
					
					if(delFileNo != null) {
						for (int i = 0; i < delFileNo.length; i++) {
							//파일의 상태값을 업데이트
							boardMapper.updateNoticeFileStatus(delFileNo[i]);
						}
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			result = "SUCCESS";
		}else {
			result = "FAIL";
		}
		return result;
	}

	@Override //공지사항 파일넘버 가져옴
	public Map<String, Object> selectComfileNo(int noticeNo) {
		return boardMapper.selectComfileNo(noticeNo);
	}

	@Override//공지사항 삭제
	public String noticeRemove(int noticeNo) {
		String result = ""; 
		//게시글 번호에 해당하는 com_file_no 를 가져옴
		Map<String,Object> selectComfileNo = boardMapper.selectComfileNo(noticeNo);
		
		
		List<ComFileDetailVO> selectFilePath = null;
		//게시글 번호에 해당하는 게시글 삭제
		int noticeRemove = boardMapper.noticeRemove(noticeNo);
		
		if (selectComfileNo != null) {
			Object objectValue = selectComfileNo.get("COM_FILE_NO");
			int comFileNo = Integer.parseInt(String.valueOf(objectValue));
		
//		if (comFileNo > 0) {
			//삭제할 데이터 가져옴 파일 경로
			selectFilePath = boardMapper.selectFilePath(comFileNo);
			//게시글 번호에 해당하는 com_file_detail 삭제
			boardMapper.deleteComFileDetail(comFileNo);
			//게시글 번호에 해당하는 com_file 삭제
			boardMapper.deleteComfile(comFileNo);
			
			//삭제 성공
			try {
				String fileSavePath = selectFilePath.get(0).getComFileDetailSavePath();
				int pathIndex = fileSavePath.lastIndexOf("/");
				//UUID 제외한 나머지 경로 가져옴
				String path = selectFilePath.get(0).getComFileDetailSavePath().substring(0,pathIndex+1);
				
				deleteFolder(path);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	
		if (noticeRemove > 0) {
			result = "SUCCESS";
		}else {
			result = "FAIL";
		}
		
		return result;
	}

	//파일 삭제 메소드
	private void deleteFolder(String path) {
		//UUID_원본파일명 전 파일 경로를 folder 파일 객체로 잡음 ㅇㅇ
		File folder = new File(path);
		
		try {
			if(folder.exists()) {
				//경로 존재시
				File[] fileList = folder.listFiles();
				
				for (int i = 0; i < fileList.length; i++) {
					if (fileList[i].isFile()) {
						fileList[i].delete();//폴더안에 파일 삭제
					}else {
						deleteFolder(fileList[i].getPath()); //파일이 아니라 폴더면 재귀로 돌림
					}
				}
				folder.delete();//막으로 폴더 삭제
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int getappealCount(PaginationInfoVO<AppealVO> pagingVO) {
		
		return boardMapper.getappealCount(pagingVO);
	}

	@Override
	public List<AppealVO> appealList(PaginationInfoVO<AppealVO> pagingVO) {
		
		return boardMapper.appealList(pagingVO);
	}

	@Override
	public int registAppeal(AppealVO appealVO) {
		
		return boardMapper.registAppeal(appealVO);
	}

	@Override
	public int registAppealWithFiles(AppealVO appealVO) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("appealTitle", appealVO.getAppealTitle());
		params.put("appealType", appealVO.getAppealType());
		params.put("appealContent", appealVO.getAppealContent());
		params.put("userNo", appealVO.getUserNo());
		params.put("declNo", appealVO.getDeclNo()); 
		params.put("servantNo", appealVO.getServantNo());

		// 파일 리스트에서 각 속성 추출
		List<ComFileDetailVO> fileList = appealVO.getAppealFileList();
		
			try(Connection conn = dataSource.getConnection()){
			OracleConnection oracleConn = conn.unwrap(OracleConnection.class); // OracleConnection 추출
	
			// 배열로 변환
			String[] fileNamesArr = fileList.stream().map(ComFileDetailVO::getComFileDetailOriginalName).toArray(String[]::new);
			String[] saveNamesArr = fileList.stream().map(ComFileDetailVO::getComFileDetailSaveName).toArray(String[]::new);
			String[] filePathsArr = fileList.stream().map(ComFileDetailVO::getComFileDetailSavePath).toArray(String[]::new);
			String[] mimeTypesArr = fileList.stream().map(ComFileDetailVO::getComFileDetailMime).toArray(String[]::new);
			BigDecimal[] fileSizesArr = fileList.stream()
			    .map(vo -> BigDecimal.valueOf(vo.getComFileDetailSize())) // Long → BigDecimal
			    
			    .toArray(BigDecimal[]::new);
	
			// Oracle SQL 배열 타입으로 변환
			Array fileNames = oracleConn.createOracleArray("SYS.ODCIVARCHAR2LIST", fileNamesArr);
			Array saveNames = oracleConn.createOracleArray("SYS.ODCIVARCHAR2LIST", saveNamesArr);
			Array filePaths = oracleConn.createOracleArray("SYS.ODCIVARCHAR2LIST", filePathsArr);
			Array mimeTypes = oracleConn.createOracleArray("SYS.ODCIVARCHAR2LIST", mimeTypesArr);
			Array fileSizes = oracleConn.createOracleArray("SYS.ODCINUMBERLIST", fileSizesArr);
	
			// 파라미터 맵에 저장
			params.put("fileNames", fileNames);
			params.put("saveNames", saveNames);
			params.put("filePaths", filePaths);
			params.put("mimeTypes", mimeTypes);
			params.put("fileSizes", fileSizes);
	
			// OUT 파라미터 초기화
			params.put("result", 0);
			// 호출
			boardMapper.registAppealWithFiles(params);
	
			// 결과값 VO에 주입
			appealVO.setResult((Integer) params.get("result"));
			return appealVO.getResult();
		} catch (SQLException e){
			e.printStackTrace();
			throw new RuntimeException("민원등록 파일 업로드중 오류발생",e);
		}
	
	}

	@Override
	public int deleteAppeal(int appealNo) {
		// 반환할 인트 값
		int cnt = 0;
		// appealNo에 맞는 appeal 호출 
		AppealVO appealVO = boardMapper.selectAppeal(appealNo);
		// appealVO에 파일이있는지 없는지 판단
		if(appealVO.getAppealAttch() == 0 ) {
			cnt = boardMapper.deleteAppeal(appealNo);
		}else {
			boardMapper.deleteComFileDetail(appealVO.getAppealAttch());
			cnt = boardMapper.deleteAppeal(appealNo);
			boardMapper.deleteComfile(appealVO.getAppealAttch());		
		}
		
		return cnt;
	}


	@Override
	public int getappealSvtCount(PaginationInfoVO<AppealVO> pagingVO) {
		return boardMapper.getappealSvtCount(pagingVO);
	}

	@Override
	public List<AppealVO> appealSvtList(PaginationInfoVO<AppealVO> pagingVO) {
		return boardMapper.appealSvtList(pagingVO);
	}
	
	@Override
	public int registAnswerAppeal(AppealVO appealVO) {
		return boardMapper.registAnswerAppeal(appealVO);
	}
	
	@Override
	public int registAnswerAppealWithFiles(AppealVO appealVO) {
	    int result = 0;

	    List<ComFileDetailVO> fileList = appealVO.getAppealFileList();
	    List<String> fileNames = new ArrayList<>();
	    List<String> saveNames = new ArrayList<>();
	    List<String> savePaths = new ArrayList<>();
	    List<String> mimeTypes = new ArrayList<>();
	    List<Long> fileSizes = new ArrayList<>();

	    for (ComFileDetailVO fileVO : fileList) {
	        fileNames.add(fileVO.getComFileDetailOriginalName());
	        saveNames.add(fileVO.getComFileDetailSaveName());
	        savePaths.add(fileVO.getComFileDetailSavePath());
	        mimeTypes.add(fileVO.getComFileDetailMime());
	        fileSizes.add(fileVO.getComFileDetailSize());
	    }

	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("p_appeal_no", appealVO.getAppealNo());
	    paramMap.put("p_answer", appealVO.getAppealAnswer());
	    paramMap.put("p_user_no", appealVO.getUserNo());

	    paramMap.put("p_file_names", fileNames);
	    paramMap.put("p_save_names", saveNames);
	    paramMap.put("p_file_paths", savePaths);
	    paramMap.put("p_mime_types", mimeTypes);
	    paramMap.put("p_file_sizes", fileSizes);
	    paramMap.put("o_result", 0); // OUT 파라미터

	    boardMapper.callRegistAnswerAppealWithFiles(paramMap);
	    result = (Integer) paramMap.get("o_result");

	    return result;
	}
}
