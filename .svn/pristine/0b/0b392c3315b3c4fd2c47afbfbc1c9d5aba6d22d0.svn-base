package kr.or.ddit.ci.service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.CIVO;

public interface ICIService {

	//CI 작성
	public ServiceResult insertCI(CIVO civo);
	//CI 확인
	public CIVO selectCI(int ciNo);
	//CI 수정
	public ServiceResult updateCI(CIVO ciVO);
	
	//CI 작성 후 contract에 업데이트
	public ServiceResult updateContractCI(String contractNo, int ciNo);
	
}
