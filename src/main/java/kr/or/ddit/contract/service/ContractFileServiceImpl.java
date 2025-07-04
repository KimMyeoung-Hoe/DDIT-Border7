package kr.or.ddit.contract.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.ddit.contract.mapper.IContractFileMapper;
import kr.or.ddit.vo.ContractFileAttachVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ContractFileServiceImpl implements IContractFileService {

	@Autowired
	private IContractFileMapper contractFileMapper;

	@Value("${kr.or.ddit.upload.pdf.path}")
	private String pdfuploadPath;
	
	@Override
	public int insertFileAttachment(ContractFileAttachVO attachVO) {
		contractFileMapper.insertFile(attachVO);
		return attachVO.getContractFileNo();
	}

	@Override
	public ContractFileAttachVO getContractFileAttachVO(String contractNo, File pdfFile) {
		ContractFileAttachVO contractFileAttachVO = new ContractFileAttachVO();
		
		// \로 가져온 파일 경로 / 로변경
		String getPath = pdfFile.toString().replaceAll("\\\\", "/");
		Path path = Paths.get(getPath);
		
        String savedFileName = path.getFileName().toString(); // 서버에 저장된 파일 이름 바꿔야할듯?
        String originalFileName = path.getFileName().toString(); // 사용자에게 보여줄 원본 파일 이름
        
        long fileSize = 0;
		try {
			fileSize = Files.size(path);
		} catch (IOException e) {
			e.printStackTrace();
		} // 파일 크기
        
        //String fileExtension = "pdf"; // 확장자
        int getIndex = originalFileName.lastIndexOf('.');
        String fileExtension = originalFileName.substring(getIndex + 1).toUpperCase(); // 확장자
        
        LocalDate dateNow = LocalDate.now();
        String now = dateNow.toString();
        log.info("시간 확인 now : {}" +now);
        
        contractFileAttachVO.setContractNo(contractNo); // 어떤 계약에 속하는지 연결
        contractFileAttachVO.setContractFileType("PDF"); // 파일 유형
        contractFileAttachVO.setContractFileOriginalName(originalFileName);
        contractFileAttachVO.setContractFileExtension(fileExtension);
        contractFileAttachVO.setContractFileSize((int) fileSize); // int 타입에 맞게 캐스팅
        contractFileAttachVO.setContractFilePath(pdfuploadPath); // 저장된 디렉토리 경로
        contractFileAttachVO.setContractFileSavedName(savedFileName);//저장 이름 지금 그대로 저장됨
        contractFileAttachVO.setContractFileDate(now);
        contractFileAttachVO.setContractFileYn(1); // 사용함
		
		return contractFileAttachVO;
	}
	
}
