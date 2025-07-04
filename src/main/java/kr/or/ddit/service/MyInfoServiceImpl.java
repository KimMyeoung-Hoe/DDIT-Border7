package kr.or.ddit.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.IMyInfoMapper;
import kr.or.ddit.vo.CCAVO;
import kr.or.ddit.vo.ConsignorVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.LogistMngVO;
import kr.or.ddit.vo.ServantVO;
import kr.or.ddit.vo.UserVO;

@Service
public class MyInfoServiceImpl implements IMyInfoService {

	@Autowired
	private IMyInfoMapper myInfoMapper;

	// 내 정보 조회 기능 ----------------------------------------------------------
	@Override
	public UserVO myInfoUser(int userNo) {
		return myInfoMapper.myInfoUser(userNo);
	}
	
	@Override
	public ServantVO myInfoServant(int userNo) {
		return myInfoMapper.myInfoServant(userNo);
	}

	@Override
	public String selectJobGradeName(String jobGradeCode) {
		return myInfoMapper.selectJobGradeName(jobGradeCode);
	}
	
	@Override
	public DeptVO selectDept(String deptCode) {
		return myInfoMapper.selectDept(deptCode);
	}

	@Override
	public ConsignorVO myInfoConsignor(int userNo) {
		return myInfoMapper.myInfoConsignor(userNo);
	}
	
	@Override
	public CCAVO myInfoCca(int userNo) {
		return myInfoMapper.myInfoCca(userNo);
	}
	
	@Override
	public List<String> myInfoCcaSpecialtyCodeList(int userNo) {
		return myInfoMapper.myInfoCcaSpecialtyCodeList(userNo);
	}

	@Override
	public List<String> myInfoCcaSpecialtyNameList(int userNo) {
		return myInfoMapper.myInfoCcaSpecialtyNameList(userNo);
	}

	@Override
	public LogistMngVO myInfoLogistMng(int userNo) {
		return myInfoMapper.myInfoLogistMng(userNo);
	}
	
	// 내 정보 수정 기능 -----------------------------------------------------------
	@Override
	public ServiceResult myInfoUpdateSvt(UserVO userVO) {
		ServiceResult result = null;
		
		int status = myInfoMapper.myInfoUpdateSvt(userVO);
		
		if(status > 0) { // 작업 성공
			result = ServiceResult.OK;
		}else { // 작업 실패
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
	@Override
	public ServiceResult myInfoConsignorUpdate(UserVO userVO) {
		ServiceResult result = null;
		
		try {
			myInfoMapper.myInfoUserUpdate(userVO);
			myInfoMapper.myInfoConsignorUpdate(userVO.getConsignorVO());
			
			result = ServiceResult.OK;
		} catch (Exception e) {
			System.out.println("오류 : " + e);
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult myInfoCcaUpdate(UserVO userVO) {
		ServiceResult result = null;
		
		try {
			myInfoMapper.myInfoUserUpdate(userVO);
			myInfoMapper.myInfoCcaUpdate(userVO.getCcaVO());
			myInfoMapper.myInfoCcaSpecialtyDelete(userVO.getUserNo());
			
			Map<String, Object> map = new HashMap<>();
	        map.put("userNo", userVO.getUserNo());
			List<String> ccaSpecialtyCodeList = (List<String>)userVO.getCcaVO().getCcaSpecialtyCodeList();
			for(String code : ccaSpecialtyCodeList) {
				System.out.println("code : " + code);
		        map.put("specialtyCode", Integer.valueOf(code));
				myInfoMapper.myInfoCcaSpecialtyInsert(map);
			}
			
			result = ServiceResult.OK;
		} catch (Exception e) {
			System.out.println("오류 : " + e);
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult myInfoLogistMngUpdate(UserVO userVO) {
		ServiceResult result = null;
		
		try {
			myInfoMapper.myInfoUserUpdate(userVO);
			myInfoMapper.myInfoLogistMngUpdate(userVO.getLogistMngVO());
			
			result = ServiceResult.OK;
		} catch (Exception e) {
			System.out.println("오류 : " + e);
			result = ServiceResult.FAILED;
		}
		return result;
	}

	// 탈퇴 기능 -----------------------------------------------------------
	@Override
	public ServiceResult myInfoDelete(String userId) {
		ServiceResult result = null;

		try {
			myInfoMapper.myInfoDelete(userId);
			result = ServiceResult.OK;
		} catch (Exception e) {
			System.out.println("오류 : " + e);
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> myInfoCcaContractList(int userNo) {
		return myInfoMapper.myInfoCcaContractList(userNo);
	}
}