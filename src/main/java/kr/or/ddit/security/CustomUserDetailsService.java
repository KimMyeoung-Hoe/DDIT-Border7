package kr.or.ddit.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.or.ddit.user.mapper.IUserMapper;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private IUserMapper userMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
	    log.info("사용자 인증 시도-> username: {}", username);
	    
	    UserVO user = userMapper.readByUserInfo(username);
//		return user == null ? null : new CustomUser(user);
	    if (user == null) {
	        log.warn("존재하지 않는 사용자 접근 시도: {}", username);
	        throw new UsernameNotFoundException("사용자 정보를 찾을 수 없습니다: " + username);
	    }
	    
//	    List<String> authList = new ArrayList<>();
//	    authList.add(user.getAuthCode());
//	    user.setAuthList(authList);
	    
	    if (user.getAuthList() == null) {
	        user.setAuthList(new ArrayList<>());
	    }
	    user.getAuthList().add(user.getAuthCode());
	    
	    
	    log.info("사용자 정보 로드 성공: {}", username);
	    return new CustomUser(user);
	}
}
