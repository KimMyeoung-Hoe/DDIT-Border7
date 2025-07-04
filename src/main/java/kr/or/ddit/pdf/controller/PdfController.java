package kr.or.ddit.pdf.controller;

import java.io.File;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.pdf.service.PdfService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/pdf")
public class PdfController {
	
	@Autowired
	private PdfService pdfService;

//	private static final String pdfuploadPath = "C://upload/pdf_output/";
	@Value("${kr.or.ddit.upload.pdf.path}")
	private String pdfuploadPath;
	
	@GetMapping("/download/{docType}/{docNo}") // 다운로드용 새 엔드포인트
    public ResponseEntity<Resource> download(
    		@PathVariable String docType, // docType 경로 변수를 String 타입으로 받음
            @PathVariable String docNo) {   // docNo 경로 변수를 String 타입으로 받음
		 // docType과 docNo 값을 여기에서 사용할 수 있습니다.
		System.out.println("[DownloadController] PDF 다운로드 요청: docType=" + docType + ", docNo=" + docNo);

        try {
            // 1. PdfService를 호출하여 PDF 파일 생성
            String pdfCreationResult = pdfService.createPdf(docType, docNo);
            System.out.println("[PdfService] PDF 생성 결과: " + pdfCreationResult);

            File file = new File(pdfuploadPath);
    		if(!file.exists()) {
    			file.mkdirs();
    		}
    		
            // PdfServiceImpl에서 정한 파일 경로 규칙에 따라 파일 객체 생성
            String pdfFilePath = pdfuploadPath + docType + "_" + docNo + ".pdf"; // 서비스와 동일한 경로 규칙 사용
            File pdfFile = new File(pdfFilePath);

            // 2. 생성된 PDF 파일의 존재 여부 및 유효성 검사
            if (!pdfFile.exists() || !pdfFile.isFile() || pdfFile.length() == 0) {
                System.err.println("[DownloadController] PDF 파일을 찾을 수 없거나 유효하지 않습니다: " + pdfFilePath);
                return ResponseEntity.status(404).body(null); // 404 Not Found
            }

            // 3. Resource 객체 생성 및 파일명 인코딩
            Resource resource = new FileSystemResource(pdfFile);
            // 한글 파일명을 위해 인코딩
            String encodedFileName = URLEncoder.encode(pdfFile.getName(), StandardCharsets.UTF_8.toString())
                                             .replaceAll("\\+", "%20"); // 공백은 + 대신 %20으로 인코딩

            // 4. HTTP 응답 헤더 설정 및 파일 반환
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFileName + "\"")
                    .contentType(MediaType.APPLICATION_PDF)
                    .contentLength(pdfFile.length())
                    .body(resource);

        } catch (Exception e) {
            System.err.println("[DownloadController] PDF 다운로드 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body(null); // 500 Internal Server Error
        }
    }
	
	
	/**
	 * 
	 * @param url
	 * @return
	 */
	@GetMapping("/download2.do") // 다운로드용 새 엔드포인트
    public ResponseEntity<Resource> download2(String url) {
		System.out.println("[DownloadController] PDF 다운로드 요청: url=" + url);

        try {
            // 1. PdfService를 호출하여 PDF 파일 생성
            String pdfCreationResult = pdfService.createPdf2(url);
            System.out.println("[PdfService] PDF 생성 결과: " + pdfCreationResult);
            File file = new File(pdfuploadPath);
    		if(!file.exists()) {
    			file.mkdirs();
    		}
    		
            // PdfServiceImpl에서 정한 파일 경로 규칙에 따라 파일 객체 생성
            String pdfFilePath = pdfuploadPath +"/"+ url.substring(url.lastIndexOf("=")+1) + ".pdf"; // 서비스와 동일한 경로 규칙 사용
            File pdfFile = new File(pdfFilePath);

            // 2. 생성된 PDF 파일의 존재 여부 및 유효성 검사
            if (!pdfFile.exists() || !pdfFile.isFile() || pdfFile.length() == 0) {
                System.err.println("[DownloadController] PDF 파일을 찾을 수 없거나 유효하지 않습니다: " + pdfFilePath);
                return ResponseEntity.status(404).body(null); // 404 Not Found
            }

            // 3. Resource 객체 생성 및 파일명 인코딩
            Resource resource = new FileSystemResource(pdfFile);
            // 한글 파일명을 위해 인코딩
            String encodedFileName = URLEncoder.encode(pdfFile.getName(), StandardCharsets.UTF_8.toString())
                                             .replaceAll("\\+", "%20"); // 공백은 + 대신 %20으로 인코딩

            // 4. HTTP 응답 헤더 설정 및 파일 반환
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFileName + "\"")
                    .contentType(MediaType.APPLICATION_PDF)
                    .contentLength(pdfFile.length())
                    .body(resource);

        } catch (Exception e) {
            System.err.println("[DownloadController] PDF 다운로드 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body(null); // 500 Internal Server Error
        }
	}
	
	/**
	 * 
	 * @param url
	 * @return
	 */
	@GetMapping("/taxDownload.do") // 다운로드용 새 엔드포인트
	public ResponseEntity<Resource> download3(String url) {
		System.out.println("[DownloadController] PDF 다운로드 요청: url=" + url);
		
		try {
			// 1. PdfService를 호출하여 PDF 파일 생성
			String pdfCreationResult = pdfService.createPdf2(url);
			System.out.println("[PdfService] PDF 생성 결과: " + pdfCreationResult);
			File file = new File(pdfuploadPath);
			if(!file.exists()) {
				file.mkdirs();
			}
			
			// PdfServiceImpl에서 정한 파일 경로 규칙에 따라 파일 객체 생성
			String pdfFilePath = pdfuploadPath +"/"+ url.substring(url.lastIndexOf("=")+1) + ".pdf"; // 서비스와 동일한 경로 규칙 사용
			File pdfFile = new File(pdfFilePath);
			
			// 2. 생성된 PDF 파일의 존재 여부 및 유효성 검사
			if (!pdfFile.exists() || !pdfFile.isFile() || pdfFile.length() == 0) {
				System.err.println("[DownloadController] PDF 파일을 찾을 수 없거나 유효하지 않습니다: " + pdfFilePath);
				return ResponseEntity.status(404).body(null); // 404 Not Found
			}
			
			// 3. Resource 객체 생성 및 파일명 인코딩
			Resource resource = new FileSystemResource(pdfFile);
			
			// 한글 파일명을 위해 인코딩
			String encodedFileName = URLEncoder.encode("관세 납부 고지서[대납자용] 제-" + pdfFile.getName(), StandardCharsets.UTF_8.toString())
					.replaceAll("\\+", "%20"); // 공백은 + 대신 %20으로 인코딩
			
			// 4. HTTP 응답 헤더 설정 및 파일 반환
			return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFileName + "\"")
					.contentType(MediaType.APPLICATION_PDF)
					.contentLength(pdfFile.length())
					.body(resource);
			
		} catch (Exception e) {
			System.err.println("[DownloadController] PDF 다운로드 중 오류 발생: " + e.getMessage());
			e.printStackTrace();
			return ResponseEntity.status(500).body(null); // 500 Internal Server Error
		}
	}
}
