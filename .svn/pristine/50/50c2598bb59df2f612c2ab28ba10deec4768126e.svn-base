package kr.or.ddit.user.service;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.user.mapper.IUserMapper;
import kr.or.ddit.vo.UserVO;

@Service
public class UserServiceImpl implements IUserService {
	
	@Autowired
	private IUserMapper userMapper;
	
	@Autowired
	private PasswordEncoder pe;

	@Override
	public UserVO userInfo(String userId) {
		UserVO userVO = userMapper.readByUserInfo(userId);
		return userVO;
	}

	@Override
	public String findId(UserVO user) {
		return new String(userMapper.findId(user));
	}

	@Override
	public String findpw(UserVO user) {
		return new String(userMapper.findpw(user));
	}

	@Override
	public int updatePw(UserVO user) {
		int result = 0;
		String newPw = pe.encode(user.getUserPw());
		user.setUserPw(newPw);
		result = userMapper.updatePw(user);
		return result;
	}
	
	@Override
	public UserVO signin(UserVO userVO) {
		// user : DB의 회원정보
		// userVO : 입력된 회원정보
		UserVO user = userMapper.login(userVO);
		if (user == null || user.getUserPw() == null || !pe.matches(userVO.getUserPw(), user.getUserPw())) {
			user = null;
		}
		return user ;
	}

	@Override
	public ServiceResult registUser(UserVO userVO) {
		
		ServiceResult result  = null; 
		
		//비밀번호 암호화
		String password =userVO.getUserPw();
		password = pe.encode(password);
		userVO.setUserPw(password);
		
		// 공통부분 등록
		int cnt = userMapper.registUser(userVO);
		if(cnt == 0) {
			return result.FAILED;
		}
		// 각 주체별 부분 등록
		if(userVO.getLogistMngVO() != null) {
			userMapper.registLogistics(userVO);
			result = ServiceResult.OK;
		}else if(userVO.getCcaVO() != null) {
			userMapper.registCCA(userVO);
			result = ServiceResult.OK;
		}else if(userVO.getConsignorVO() != null) {
			// 고유통관번호 임의적으로 지정
			String customCode = "CN";
			customCode += LocalDate.now();
			int CNcnt = userMapper.cntConsignor();
			customCode += CNcnt+1;
			customCode = customCode.replaceAll("-", "");
			userVO.getConsignorVO().setConsignorCustomsCode(customCode);
			userMapper.registConsignor(userVO);
			result = ServiceResult.OK;
		}else{
			result = ServiceResult.NOTEXIST;
		}

		return result;
	}
	
	// 아이디 중복체크
	@Override
	public int checkId(String userId) {
		
		return userMapper.checkId(userId);
	}

	@Override
	public int selectUserNo(String userId) {
		return userMapper.selectUserNo(userId);
	}

	@Override
	public int checkPw(UserVO userVO) {
		int result;
		UserVO user = userMapper.login(userVO);
		if (user == null || user.getUserPw() == null || !pe.matches(userVO.getUserPw(), user.getUserPw())) {
			result = 0;
		}else {
			result = 1;
		}
		return result;
	}

	@Override
	public ServiceResult changePw(UserVO userVO) {
		ServiceResult result  = null; 
		
		//비밀번호 암호화
		String password = userVO.getUserPw();
		password = pe.encode(password);
		userVO.setUserPw(password);
		
		try {
			userMapper.updatePw(userVO);
			result = ServiceResult.OK;
		} catch (Exception e) {
			System.out.println("오류 : " + e);
			result = ServiceResult.FAILED;
		}
		return result;
	}
}
