package kr.or.ddit.util.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.util.mapper.IUtilMapper;

@Service
public class UtilService {
	
	@Autowired
	private IUtilMapper utilMapper;

	public String getContractNoToCdNo(String cdNo) {
		return utilMapper.getContractNoToCdNo(cdNo);
	}
	
	
	
}
