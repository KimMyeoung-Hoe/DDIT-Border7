package kr.or.ddit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.web.servlet.View;

import org.springframework.http.HttpHeaders;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import io.micrometer.common.util.StringUtils;
import kr.or.ddit.service.IBoardService;
import kr.or.ddit.service.ILogisticsService;
import kr.or.ddit.vo.AppealVO;
import kr.or.ddit.vo.ComFileDetailVO;
import kr.or.ddit.vo.ContainerDetailVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.FAQBoardVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StowageVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private IBoardService boardService;
	
	@Autowired
	private ILogisticsService logisticsService;
	
	// 고객지원페이지 메인
	@GetMapping("/main.do")
	public String main() {

		return "board/main";
	}

	// 공지사항게시판
	/**
	 * 
	 * @return
	 */
	 @PreAuthorize("true") 
	@RequestMapping("/noticeList.do")
	public String noticeList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchWord, Model model) {
		PaginationInfoVO<NoticeVO> pageVo = new PaginationInfoVO<>();
		log.info("넘어온 searchWord : {}",searchWord);
		
		if (StringUtils.isNotBlank(searchWord)) {
			pageVo.setSearchWord(searchWord);
			model.addAttribute("searchWord",searchWord);
		}
		
		pageVo.setCurrentPage(currentPage);
		
		int totalRecord = boardService.selectNoticeCount(pageVo);
		pageVo.setTotalRecord(totalRecord);
		List<NoticeVO> selectNoticeList = boardService.selectNoticeList(pageVo);
		pageVo.setDataList(selectNoticeList);
		model.addAttribute("pageVo",pageVo);
		
		return "board/noticeList";
	}

	// 공지사항 작성 공무원만 가능
	@PreAuthorize("hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')")
	@GetMapping("/noticeform.do")
	public String noticeform() {
		return "board/noticeForm";
	}
	
	//공지사항 등록
	@PreAuthorize("hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')")
	@PostMapping("/noticeInsert")
	public String noticeInsert(NoticeVO noticeVO , RedirectAttributes ra , ModelMap model) {
		String goPage = "";
		Map<String, String> errors = new HashMap<>();
		if(StringUtils.isBlank(noticeVO.getNoticeTitle())) {
			errors.put("noticeTitle", "제목 없삼");
		}
		if(StringUtils.isBlank(noticeVO.getNoticeContent())) {
			errors.put("noticeContent", "내용 없삼");
		}
		
		if(errors.size() > 0) {
			//에러가 있으면
			model.addAttribute("errors",errors);
			model.addAttribute("noticeVo",noticeVO);
			goPage = "board/noticeform.do"; //그 페이지로 다시 이동 시킴
		}else {
			//에러가 없으면
			CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
			UserVO user = userSec.getUser();
			
			if(user!=null) {
				noticeVO.setRegServantNo(user.getUserNo());//로그인한 공무원의 번호
				String result = boardService.noticeInsert(noticeVO);
				System.out.println(result);
				
				if (result.equals("SUCCESS")) {
					//게시글 등록 완
					ra.addFlashAttribute("message","게시글 등록 완");
					goPage = "redirect:/board/noticeList.do";
				}else {
					//실패
					ra.addFlashAttribute("message","실패");
					model.addAttribute("noticeVo",noticeVO);
					goPage = "board/noticeform.do";
				}
			}
		}
		return goPage;
	}

	// 공지사항 상세
	 @PreAuthorize("true") 
	@GetMapping("/noticeDetail/{noticeNo}") 
	public String noticeDetail(@PathVariable int noticeNo , Model model) {
		log.info("넘어온 noticeNo : {}",noticeNo);
		NoticeVO noticeDetail = boardService.noticeDetail(noticeNo);
		model.addAttribute("notice",noticeDetail);
		return "board/noticeDetail";
	}

	
	//파일 보기
	 @PreAuthorize("true") 
	@GetMapping("/display")
	public ResponseEntity<byte[]> displayFile(int comFileDetailNo){
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String fileName = boardService.getPicture(comFileDetailNo);
		
		String forMatName = fileName.substring(fileName.lastIndexOf(".")+1);
		MediaType mType = getMediaType(forMatName);
		HttpHeaders headers = new HttpHeaders();
		
		try {
			in = new FileInputStream(fileName);
			
			if (mType != null) {
				headers.setContentType(mType);
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers,HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return entity;
	}

	@PreAuthorize("true") 
	private MediaType getMediaType(String formatName) {
		if (formatName != null) {
			if (formatName.toUpperCase().equals("JPG")) {
				return MediaType.IMAGE_JPEG;
			}
			if (formatName.toUpperCase().equals("PNG")) {
				return MediaType.IMAGE_PNG;
			}
			if (formatName.toUpperCase().equals("GIF")) {
				return MediaType.IMAGE_GIF;
			}
		}
		return null;
	}
	
	
	//공지사항 다운
	 @PreAuthorize("true") 
	@GetMapping("download.do")
	public View noticeDownload(int comFileDetailNo , ModelMap model) {
		ComFileDetailVO comFileDetailVO = boardService.noticeFileDown(comFileDetailNo);
		
		Map<String, Object> noticeFileMap = new HashMap<>();
		noticeFileMap.put("fileName", comFileDetailVO.getComFileDetailOriginalName());
		noticeFileMap.put("fileSize", comFileDetailVO.getComFileDetailSize());
		noticeFileMap.put("fileSavepath", comFileDetailVO.getComFileDetailSavePath());
		model.addAttribute("noticeFileMap",noticeFileMap);
		
		return new NoticeDownloadView();
	}
	
	//공지사항 수정폼 이동
	@PreAuthorize("hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')")
	@GetMapping("/noticeUpdate")
	public String noticeUpdate(int noticeNo ,Model model) {
		NoticeVO noticeDetail = boardService.noticeDetail(noticeNo);
		model.addAttribute("notice",noticeDetail);
		model.addAttribute("status","u");//수정
		return "board/noticeForm";
	}

	
	//공지사항 수정
	@PreAuthorize("hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')")
	@PostMapping("/noticeUpdate")
	public String noticeUpdate(NoticeVO noticeVO , Model model , RedirectAttributes ra) {
		String goPage = "";
		
		CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		UserVO user = userSec.getUser();
		if(user!=null) {
			noticeVO.setUpdServantNo(user.getUserNo());//수정할 공무원 번호 넣어주기
			Map<String, Object> comFileNoMap = boardService.selectComfileNo(noticeVO.getNoticeNo());
			if (comFileNoMap != null) {

				Object objectValue = comFileNoMap.get("COM_FILE_NO");
				int comFileNo = Integer.parseInt(String.valueOf(objectValue));
				//파일 번호가 있으면 set 해줌
				//int comFileNo = (int) comFileNoMap.get("COM_FILE_NO");
				noticeVO.setComFileNo(comFileNo);
			}
			String result = boardService.noticeUpdate(noticeVO);
			
			if (result.equals("SUCCESS")) {
				//성공한다?
				ra.addFlashAttribute("message","수정완");
				goPage = "redirect:/board/noticeDetail/"+noticeVO.getNoticeNo();
			}else {
				model.addAttribute("notice",noticeVO);
				model.addAttribute("message","실패");
				model.addAttribute("status","u");
				goPage = "/board/noticeUpdate?noticeNo="+noticeVO.getNoticeNo();
			}
		}
		return goPage;
	}
	
	//공지사항 삭제
	@PreAuthorize("hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')")
	@PostMapping("/noticeRemove")
	public String noticeRemove(int noticeNo , Model model , RedirectAttributes ra) {
		String goPage = "";
		String result = boardService.noticeRemove(noticeNo);
		
		if (result.equals("SUCCESS")) {
			ra.addFlashAttribute("message","삭제 완");
			goPage = "redirect:/board/noticeList.do";
		}else {
			ra.addFlashAttribute("message","삭제 실패");
			goPage  = "redirect:/board/noticeDetail/"+noticeNo;
		}
		return goPage;
	}
	
	// FAQ 게시판
	 @PreAuthorize("true") 
	@RequestMapping("/faqList.do")
	public String selectFaqList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchWord, Model model) {
		PaginationInfoVO<FAQBoardVO> pageVo = new PaginationInfoVO<>();
		log.info("넘어온 searchWord : {}", searchWord);

		if (StringUtils.isNotBlank(searchWord)) {
			pageVo.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}

		pageVo.setCurrentPage(currentPage);
		int totalRecord = boardService.selectFaqCount(pageVo);
		pageVo.setTotalRecord(totalRecord);
		List<FAQBoardVO> faqVO = boardService.selectFaqList(pageVo);
		pageVo.setDataList(faqVO);

		List<FAQBoardVO> selectCategoryList = boardService.selectCategoryList();
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("categoryVo", selectCategoryList); // faq 카테고리
		return "board/faqList";
	}

	// faq카테고리 리스트
	 @PreAuthorize("true") 
	@GetMapping("/categoryBoardList")
	public ResponseEntity<List<FAQBoardVO>> categoryBoardList(String category) {
		log.info("category : {}", category);
		List<FAQBoardVO> categoryBoardList = boardService.categoryBoardList(category);
		return new ResponseEntity<List<FAQBoardVO>>(categoryBoardList, HttpStatus.OK);
	}

	// faq 작성 공무원만 가능
	 @PreAuthorize("hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')")
	@GetMapping("/faqform.do")
	public String FAQform(Model model) {
		List<FAQBoardVO> selectCategoryList = boardService.selectCategoryList();
		model.addAttribute("categoryVo", selectCategoryList);
		return "board/faqForm";
	}

	// faq insert
	 @PreAuthorize("hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')")
	@PostMapping("/faqInsert")
	public String FaqInsert(FAQBoardVO boardVO,RedirectAttributes ra) {
		String goPage = "";
		List<String> faqTypeList = boardVO.getFaqTypeList();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < faqTypeList.size(); i++) {
			sb.append(faqTypeList.get(i));
			if (i<faqTypeList.size()-1) {
				sb.append(",");
			}
		}
		
		String resultValue = sb.toString();
		boardVO.setFaqType(resultValue);
		
		System.out.println(resultValue);
		CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		UserVO user = userSec.getUser();
		if(user!=null) {
			
			int servantNo = user.getUserNo(); //현재 로그인한 공무원 번호
			
			boardVO.setRegServantNo(servantNo);
			
			int result  = boardService.FaqInsert(boardVO);
			
			if(result > 0) {
				System.out.println("성공");
				ra.addFlashAttribute("message","게시글 등록 완!");
				goPage = "redirect:/board/faqList.do";
			}else {
				System.out.println("실패");
				ra.addFlashAttribute("message","실패임ㅋ");
				goPage = "board/faqList.do";
			}
		}else {
			ra.addFlashAttribute("message","로그인 하셈");
		}

		return goPage;
	}

	// faq 상세 
	 @PreAuthorize("hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')")
	@GetMapping("/faqDetail/{faqNo}") 
	public String FAQdetail(@PathVariable int faqNo , Model model) {
		FAQBoardVO faqBoardVO = boardService.faqDetail(faqNo);
		model.addAttribute("faqVo",faqBoardVO);
		return "board/faqDetail";
	}
	
	//faq 삭제
	 @PreAuthorize("hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')")
	@PostMapping("/faqRemove")
	public String faqRemove(int faqNo) {
		String goPage = "";
		log.info("삭제할 번호 : {}" ,faqNo);
		int faqRemove = boardService.faqRemove(faqNo);
		if(faqRemove > 0) {
			goPage = "redirect:/board/faqList.do";
		}else {
			goPage = "board/faqList.do";
		}
		return goPage;
	}
	
	//faq 수정폼 이동
	 @PreAuthorize("hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')")
	@GetMapping("/modify")
	public String faqModifyForm(int faqNo , Model model) {
		FAQBoardVO faqDetail = boardService.faqDetail(faqNo);
		List<FAQBoardVO> selectCategoryList = boardService.selectCategoryList();
		model.addAttribute("categoryVo", selectCategoryList);
		model.addAttribute("faqVo",faqDetail);
		model.addAttribute("status","u");
		return "board/faqForm";
	}
	
	//faq 업데이트
	 @PreAuthorize("hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')")
	@PostMapping("/modify")
	public String faqModify(FAQBoardVO boardVO,Model model , RedirectAttributes ra) {
		String goPage="";
		List<String> faqTypeList = boardVO.getFaqTypeList();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < faqTypeList.size(); i++) {
			sb.append(faqTypeList.get(i));
			if (i<faqTypeList.size()-1) {
				sb.append(",");
			}
		}
		
		String resultValue = sb.toString();
		boardVO.setFaqType(resultValue);
		CustomUser userSec = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO user = userSec.getUser();
		
		if(user!=null) {
			
			int servantNo = user.getUserNo(); //현재 로그인한 공무원 번호
			
			boardVO.setUpdServantNo(servantNo);
			
			int result  = boardService.faqModify(boardVO);
			
			if(result > 0) {
				System.out.println("성공");
				ra.addFlashAttribute("message","게시글 수정 완!");
				goPage = "redirect:/board/faqList.do";
			}else {
				System.out.println("실패");
				ra.addFlashAttribute("message","실패임ㅋ");
				goPage = "board/modify?faqNo=" +boardVO.getFaqNo();
			}
		}else {
			ra.addFlashAttribute("message","로그인 하셈");
		}

	
		return goPage;
	}
	
	

	// 민원사항 게시판 조회
	@PreAuthorize("true")
	@GetMapping("/appealList.do")
	public String appealList(
			 @RequestParam(value = "searchType", required = false, defaultValue = "") String searchType // 검색 타입
			,@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord // 검색 키워드
			,@RequestParam(value = "sortColumn", required = false, defaultValue = "APPEAL_REG_DATE DESC") String sortColumn // 정렬 컬럼 (기본값: 적재일)
			,@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage // 현재 페이지 (기본값: 1)
			,Model model
			) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();	
		CustomUser userSec = (CustomUser) authentication.getPrincipal();
        UserVO user = userSec.getUser();
        Collection<? extends GrantedAuthority> authorities = userSec.getAuthorities();
        String loginAuth = authorities.stream()
                               .findFirst()
                               .map(GrantedAuthority::getAuthority)
                               .orElse(null);
        
        int userNo = user.getUserNo();
        
		PaginationInfoVO<AppealVO> pagingVO = new PaginationInfoVO<>();
		pagingVO.setUserNo(userNo);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setSortColumn(sortColumn);
		pagingVO.setCurrentPage(currentPage);
		
		if("ROLE_SVT_ADMIN".equals(loginAuth) || "ROLE_SVT_QUARANTINE".equals(loginAuth) || "ROLE_SVT_MANDARIN".equals(loginAuth)) {
			
			int totalRecord = boardService.getappealSvtCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			List<AppealVO> appealList = boardService.appealSvtList(pagingVO);
			log.info("appealList()-> SVT -> appealList : {}", appealList);
			
			model.addAttribute("appealList",appealList);
			model.addAttribute("paginationInfo",pagingVO);
		} else {
			
			int totalRecord = boardService.getappealCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			List<AppealVO> appealList = boardService.appealList(pagingVO);
			log.info("appealList()-> appealList : {}", appealList);
			
			model.addAttribute("appealList",appealList);
			model.addAttribute("paginationInfo",pagingVO);
		}
		
		// 검색값 리턴
		model.addAttribute("searchType",searchType);
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("sortColumn",sortColumn);
		
		return "board/appealList";
	}

	// 민원사항 작성
	@ResponseBody
	@PostMapping("/registAppeal.do")
	public int registAppeal(
			@ModelAttribute AppealVO appealVO
			,@RequestParam(value = "appealFiles", required = false) List<MultipartFile> files
			,Model model) {
		System.out.println(files);
		System.out.println(appealVO);
		
		int cnt = 0;
		List<ComFileDetailVO> fileList = new ArrayList<>();
		
		String uploadDir = "C:/upload/appeal/";
		
		File directory = new File(uploadDir);
	    if (!directory.exists()) {
	        directory.mkdirs(); // 디렉토리가 없으면 생성
	    }
		
	    if (files != null && !files.isEmpty()) {
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	                try {
	                    // 고유한 파일 이름 생성
	                    String originalFileName = file.getOriginalFilename();
	                    String fileExtension = ""; // 파일 확장자
	                    int dotIndex = originalFileName.lastIndexOf('.');
	                    if (dotIndex > 0 && dotIndex < originalFileName.length() - 1) {
	                        fileExtension = originalFileName.substring(dotIndex);
	                    }
	                    String saveFileName = UUID.randomUUID().toString() + fileExtension; // 고유한 이름
	                    String filePath = uploadDir + saveFileName; // 파일을 저장할 전체 경로
                     
	                    // 파일을 파일 시스템에 저장
	                    file.transferTo(new File(filePath));

	                    ComFileDetailVO fileVO = new ComFileDetailVO(); // 새로운 인스턴스 생성
	                    fileVO.setComFileDetailOriginalName(originalFileName);
	                    fileVO.setComFileDetailSaveName(saveFileName);
	                    fileVO.setComFileDetailSavePath(filePath); // 전체 경로 또는 상대 경로를 저장합니다.
	                    fileVO.setComFileDetailMime(fileExtension);
	                    fileVO.setComFileDetailType("민원");
	                    fileVO.setComFileDetailSize(file.getSize());
	                    fileVO.setComFileDetailUseYn(true);
	                    
	                    fileList.add(fileVO);

	                } catch (IOException e) {
	                    // 파일 저장 예외 처리 (예: 로깅, 사용자 정의 예외 발생)
	                    e.printStackTrace();
	                    // 오류를 반환하거나 더 우아하게 처리할 수 있습니다.
	                    return 0; // 실패를 나타냄
	                }
	            }
	        }

	        appealVO.setAppealFileList(fileList);
	        // 민원 및 파일 메타데이터 등록을 처리하는 서비스 메서드 호출
	        
	        cnt = boardService.registAppealWithFiles(appealVO); // 파일을 위한 새로운 서비스 메서드
	        
	    } else {
	    	
	        // 첨부된 파일이 없으면 민원만 등록합니다.
	        cnt = boardService.registAppeal(appealVO);
	        
	    }
	    	
	    return cnt;
	}
	
	// 민원사항 삭제
	@ResponseBody
	@PostMapping("/deleteAppeal.do")
	public int deleteAppeal(
			@RequestParam int appealNo
			,Model model
			) {
		int cnt = 0;
		
		cnt = boardService.deleteAppeal(appealNo);
		
		return cnt;
	}
	// 민원사항 답변
	@ResponseBody
	@PostMapping("/answerAppeal.do")
	public int answerAppeal(
			@ModelAttribute AppealVO appealVO
			,@RequestParam(value = "appealFiles", required = false) List<MultipartFile> files
			,Model model) {
		int res = 0;
			
		List<ComFileDetailVO> fileList = new ArrayList<>();
		
		String uploadDir = "C:/upload/appeal/";
		
		File directory = new File(uploadDir);
	    if (!directory.exists()) {
	        directory.mkdirs(); // 디렉토리가 없으면 생성
	    }
		
	    if (files != null && !files.isEmpty()) {
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	                try {
	                    // 고유한 파일 이름 생성
	                    String originalFileName = file.getOriginalFilename();
	                    String fileExtension = ""; // 파일 확장자
	                    int dotIndex = originalFileName.lastIndexOf('.');
	                    if (dotIndex > 0 && dotIndex < originalFileName.length() - 1) {
	                        fileExtension = originalFileName.substring(dotIndex);
	                    }
	                    String saveFileName = UUID.randomUUID().toString() + fileExtension; // 고유한 이름
	                    String filePath = uploadDir + saveFileName; 						// 파일을 저장할 전체 경로
                     
	                    // 파일을 파일 시스템에 저장
	                    file.transferTo(new File(filePath));

	                    ComFileDetailVO fileVO = new ComFileDetailVO();						// 새로운 인스턴스 생성
	                    fileVO.setComFileDetailOriginalName(originalFileName);
	                    fileVO.setComFileDetailSaveName(saveFileName);
	                    fileVO.setComFileDetailSavePath(filePath); 							// 전체 경로 또는 상대 경로를 저장합니다.
	                    fileVO.setComFileDetailMime(fileExtension);
	                    fileVO.setComFileDetailType("민원_답변");
	                    fileVO.setComFileDetailSize(file.getSize());
	                    fileVO.setComFileDetailUseYn(true);
	                    
	                    fileList.add(fileVO);

	                } catch (IOException e) {
	                    // 파일 저장 예외 처리 (예: 로깅, 사용자 정의 예외 발생)
	                    e.printStackTrace();
	                    return 0; 
	                }
	            }
	        }
	        appealVO.setAppealFileList(fileList);
		    // 민원 및 파일 메타데이터 등록을 처리하는 서비스 메서드 호출
		    res = boardService.registAnswerAppealWithFiles(appealVO);
	    } else {
		    // 첨부된 파일이 없으면 민원만 등록합니다.
		    res = boardService.registAnswerAppeal(appealVO);
	    }
		return res;
	}
		
	// 민원사항 상세조회
	@GetMapping("/appealDetail.do")
	public String ComplaintDetail() {
		return "board/appealDetail";
	}

}
