package kr.or.ddit.ci.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ci.mapper.ICIMapper;
import kr.or.ddit.vo.CIVO;

@Service
public class CIServiceImpl implements ICIService {

	@Autowired
	private ICIMapper ciMapper;
	
	@Override
    public ServiceResult insertCI(CIVO civo) {
    	ServiceResult result = null;
    	int status = ciMapper.insertCI(civo);
    	
    	if(status>0) {
    		result = ServiceResult.OK;
    	}else {
    		result = ServiceResult.FAILED;
		}
    	
		return result;
	}

    
    @Override
	public CIVO selectCI(int ciNo) {
		return ciMapper.selectCI(ciNo);
	}

	@Override
	public ServiceResult updateCI(CIVO ciVO) {
		ServiceResult result = null;
		int status = ciMapper.updateCI(ciVO);
		if(status>0) {//수정 성공
			
			result = ServiceResult.OK;
		}else {//수정 실패
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult updateContractCI(String contractNo, int ciNo) {
		ServiceResult result = null;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("contractNo", contractNo);
		map.put("ciNo", ciNo);
		
		int status = ciMapper.updateContractCI(map);
		if(status>0) {//수정 성공
			result = ServiceResult.OK;
		}else {//수정 실패
			result = ServiceResult.FAILED;
		}
		return result;
	}
}