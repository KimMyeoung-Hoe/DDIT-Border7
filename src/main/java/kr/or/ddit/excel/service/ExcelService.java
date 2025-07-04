package kr.or.ddit.excel.service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
/**
 * 엑셀 클래스 파일
 */
@Slf4j
@Service
public class ExcelService {
	
	/**
	 * 
	 * @param file
	 * @param model
	 * @return
	 */
    public List<List<String>> excelGetList(MultipartFile file, Model model) {
        // 파일 정보 출력
        log.debug("파일명: {}", file.getOriginalFilename());
        log.debug("파일 크기: {} bytes", file.getSize());
        
        List<List<String>> list = new ArrayList<>();
        Workbook workbook = null;
        
        try {
            if (file.isEmpty()) {
                model.addAttribute("message", "파일을 선택해주세요.");
            }

            // 파일 확장자 검증
            String filename = file.getOriginalFilename();
            if (!filename.endsWith(".xlsx") && !filename.endsWith(".xls")) {
                model.addAttribute("message", "Excel 파일만 업로드 가능합니다.");
            }


            // Excel 파일 처리
            workbook = WorkbookFactory.create(file.getInputStream());

            Sheet sheet = workbook.getSheetAt(0);
            DataFormatter dataFormatter = new DataFormatter(); // DataFormatter 인스턴스 생성

            // 헤더 행 읽기
            Row headerRow = sheet.getRow(0);
            if (headerRow != null) {
                for (Cell cell : headerRow) {
                    log.debug("헤더: {}", dataFormatter.formatCellValue(cell)); // 문자열로 변환
                }
            }

            // 데이터 행 읽기
            for (int i = 1; i <= sheet.getLastRowNum(); i++) { // 전체 행 읽기
                Row row = sheet.getRow(i);
                if (row == null) {
                    continue; // 빈 행 건너뛰기
                }
                List<String> rowData = new ArrayList<>();
                for (Cell cell : row) {
                    rowData.add(dataFormatter.formatCellValue(cell)); // 모든 셀 데이터를 문자열로 변환
                }
                list.add(rowData);
                log.info("읽어온 행 데이터: {}", rowData);
            }

            log.debug("구성한 리스트 객체 :: {}", list.toString());
            log.debug("=================================================");

            workbook.close();
            model.addAttribute("message", "파일이 성공적으로 업로드되었습니다.");
        } catch (IOException e) {
            log.error("파일 처리 중 오류가 발생했습니다.", e);
            model.addAttribute("message", "파일 처리 중 오류가 발생했습니다: " + e.getMessage());
        } catch (Exception e) {
	        log.error("잘못된 Excel 파일 형식입니다. {}", e.getMessage());
	        model.addAttribute("message", "잘못된 Excel 파일 형식입니다.");
	    }
        return list;
    }

    /**
     * 계획 
	 * 1. 엑셀파일을 업로드하여 문서를 생성한다.
	 * 2. 엑셀파일의 rows가 2이상일때 여러개를 생성한다
	 * 	2-1). 문서를 여러개 입력하여 편의성을 재공?
     * @param file
     * @param model
     * @return
     */
	public String excelUpload(MultipartFile file, Model model) {

		return null;
	}

	/**
	 * 계획 
	 * 1. 작성 중인 문서 일시저장시 엑셀로 데이터를 전달한다.
	 * 2. 
	 * @param file
	 * @param model
	 * @return
	 */
	public Resource excelDownload(Model model) {
		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("사용자 정보");

        // 헤더 행 생성
        Row headerRow = sheet.createRow(0);
        String[] headers = {"순번", "이름", "나이", "성별", "연락처"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }

        // 데이터 행 생성
        Object[][] data = {
                {1, "한국인", 35, "남", "010-0000-0000"},
                {2, "박원희", 11, "여", "010-1234-0000"},
                {3, "이국한", 23, "여", "010-5678-0000"},
                {4, "김명희", 27, "여", "010-9010-0000"},
                {5, "김철민", 29, "남", "010-8888-0000"},
        };

        // Sheet 내에 헤더 / 데이터 행 구성
        for (int i = 0; i < data.length; i++) {
            Row row = sheet.createRow(i + 1);
            for (int j = 0; j < data[i].length; j++) {
                Cell cell = row.createCell(j);

                // 문자 처리
                if (data[i][j] instanceof String) {
                    cell.setCellValue((String) data[i][j]);
                }
                // 숫자 처리
                if (data[i][j] instanceof Integer) {
                    cell.setCellValue((Integer) data[i][j]);
                }
            }
        }

        // 열 너비 자동 조정
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // 파일 생성
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        try {
            workbook.write(outputStream);
            workbook.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        ByteArrayResource resource = new ByteArrayResource(outputStream.toByteArray());
        model.addAttribute("downloadMessage", "다운로드가 완료되었습니다.");
        return resource;

	}
}