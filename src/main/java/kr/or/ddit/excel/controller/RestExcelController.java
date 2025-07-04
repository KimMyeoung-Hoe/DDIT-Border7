package kr.or.ddit.excel.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.excel.service.ExcelService;
import lombok.extern.slf4j.Slf4j;

/**
 * 엑셀 데이터만 클라이언트에게 보내기위한 레스트컨트롤러
 */
@Slf4j
@RestController
@RequestMapping("/restexcel")
public class RestExcelController {
	
	@Autowired
	private ExcelService excelService;
	
	// 엑셀 읽어오기
	@PostMapping("/excelReadList")
    public List<List<String>> excelReadList(@RequestParam("file") MultipartFile file, Model model) {
		List<List<String>> result = excelService.excelGetList(file, model);
        return result;
    }
}
