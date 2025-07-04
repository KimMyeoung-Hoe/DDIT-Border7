package kr.or.ddit.pl.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.pl.mapper.IPLMapper;
import kr.or.ddit.vo.PLVO;

@Service
public class PLServiceImpl implements IPLService {

	@Autowired
	public IPLMapper plMapper;
	
	@Override
	public ServiceResult insertPL(PLVO plVO) {
		ServiceResult result = null;
		int status = plMapper.insertPL(plVO);
		if(status>0) {
    		result = ServiceResult.OK;
    	}else {
    		result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public PLVO selectPL(int plNo) {
		return plMapper.selectPL(plNo);
	}

	@Override
	public ServiceResult updateContractPL(String contractNo, int plNo) {
		ServiceResult result = null;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("contractNo", contractNo);
		map.put("plNo", plNo);
		
		int status = plMapper.updateContractPL(map);
		if(status>0) {//수정 성공
			result = ServiceResult.OK;
		}else {//수정 실패
			result = ServiceResult.FAILED;
		}
		return result;
	}

}
