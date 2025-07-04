package kr.or.ddit.webSockect.service;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.user.SimpUser;
import org.springframework.messaging.simp.user.SimpUserRegistry;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SocketUserService {

	private final SimpUserRegistry userRegistry;
	
	// SimpUserRegistry를 주입받습니다.
    @Autowired
    public SocketUserService(SimpUserRegistry userRegistry) {
        this.userRegistry = userRegistry;
    }
    
    /**
     * 현재 웹소켓에 연결된 모든 사용자의 Principal (사용자 ID 또는 이름)을 가져옵니다.
     * @return 연결된 사용자의 ID(Principal 이름) 목록
     */
    public List<String> getOnlineWebSocketUsers() {
        // userRegistry.getUsers()는 연결된 모든 SimpUser 객체를 반환합니다.
        // 각 SimpUser는 Principal (로그인된 사용자 이름/ID)을 가집니다.
        Set<SimpUser> users = userRegistry.getUsers();
        
        if (users == null || users.isEmpty()) {
            log.info("현재 웹소켓에 연결된 사용자가 없습니다.");
            return Collections.emptyList();
        }

        List<String> onlineUserIds = users.stream()
            .map(SimpUser::getName) // SimpUser.getName()은 Principal의 이름을 반환합니다.
            .collect(Collectors.toList());

        log.info("현재 온라인 웹소켓 사용자: {}", onlineUserIds);
        return onlineUserIds;
    }

    /**
     * 특정 권한을 가진 현재 웹소켓 연결 사용자 목록을 가져옵니다.
     * 주의: SimpUserRegistry는 사용자의 권한 정보를 직접적으로 제공하지 않습니다.
     * 이 메서드는 사용자의 Principal 이름(ID)을 기반으로 별도의 사용자 인증/권한 서비스에서
     * 해당 사용자의 권한을 조회하는 추가 로직이 필요합니다.
     *
     * @param authorityName 조회할 권한 이름 (예: "ROLE_SVT_ADMIN")
     * @return 해당 권한을 가진 사용자의 ID(Principal 이름) 목록
     */
    public List<String> getOnlineUsersByAuthority(String authorityName) {
        // 1. 현재 웹소켓에 연결된 모든 사용자 ID를 가져옵니다.
        List<String> allOnlineUsers = getOnlineWebSocketUsers();

        if (allOnlineUsers.isEmpty()) {
            return Collections.emptyList();
        }

        // 2. 각 사용자 ID에 대해 권한 정보를 확인하고 필터링합니다.
        // 이 부분은 UserService의 실제 구현 (DB 조회, Spring Security Context 등)에 따라 달라집니다.
        // 여기서는 가상의 isUserInAuthority 메서드를 사용합니다.
        List<String> authorizedUsers = allOnlineUsers.stream()
            .filter(userId -> isUserInAuthority(userId, authorityName)) // 가상의 권한 확인 메서드
            .collect(Collectors.toList());
        
        log.info("권한 '{}'을 가진 온라인 사용자: {}", authorityName, authorizedUsers);
        return authorizedUsers;
    }

    /**
     * 특정 사용자가 주어진 권한을 가지고 있는지 확인하는 가상의 메서드입니다.
     * 실제 구현에서는 데이터베이스에서 사용자 권한을 조회하거나,
     * Spring Security ContextHolder를 통해 현재 인증된 사용자의 권한을 확인해야 합니다.
     *
     * @param userId 확인할 사용자 ID
     * @param authorityName 확인할 권한 이름
     * @return 권한을 가지고 있으면 true, 아니면 false
     */
    private boolean isUserInAuthority(String userId, String authorityName) {
        // TODO: 실제 권한 확인 로직 구현
        // 예시: 데이터베이스에서 userId에 해당하는 사용자의 권한 정보를 조회
        // UserVO user = userMapper.selectUserById(userId);
        // return user.getAuthorities().contains(authorityName);

        // 현재는 예시를 위해 단순 비교 (실제 서비스에서는 이렇게 사용하지 마세요!)
        // 예시: "admin1"이라는 ID만 ROLE_SVT_ADMIN이라고 가정
        if ("ROLE_SVT_ADMIN".equals(authorityName) && "admin1".equals(userId)) {
            return true;
        }
        // 다른 권한 확인 로직 추가
        
        // 중요: `headerAuth`는 JSP에서만 접근 가능한 요청 스코프의 변수이므로,
        // 서버 사이드 서비스 레이어에서는 직접 접근할 수 없습니다.
        // 여기서는 `Principal`의 이름(userId)을 기반으로 DB 등에서 권한을 다시 조회해야 합니다.

        return false;
    }
}
