package kr.or.ddit.excel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.excel.service.ExcelService;
import lombok.extern.slf4j.Slf4j;

/**
 * 엑셀 업로드하기위한 컨트롤러
 */

@Slf4j
@Controller
@RequestMapping("/excel")
public class ExcelController {

	@Autowired
	private ExcelService excelService;

	//대기
	//엑셀 파일 rows를 통해 문서 여러장 만들기
	@PostMapping("/upload")
    public String excelUpload(@RequestParam("file") MultipartFile file, Model model) {
		String result = excelService.excelUpload(file, model);
        return result;
    }

	//엑셀 다운로드
	//진행
	//분기 잡기 문서 종류, 
	@PostMapping("/download")
    public ResponseEntity<Resource> excelDownload(Model model) {
		Resource result = excelService.excelDownload(model);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=userList.xlsx")
                .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                .body(result);
    }
	
}
