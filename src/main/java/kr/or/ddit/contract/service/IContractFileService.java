package kr.or.ddit.contract.service;

import java.io.File;

import kr.or.ddit.vo.ContractFileAttachVO;

public interface IContractFileService {

	public int insertFileAttachment(ContractFileAttachVO contractFileAttachVO);

	/**
	 * 가져온 파일을 객체화 해서 반환
	 * @param pdfFile
	 * @return
	 */
	public ContractFileAttachVO getContractFileAttachVO(String contractNo, File pdfFile);

}
