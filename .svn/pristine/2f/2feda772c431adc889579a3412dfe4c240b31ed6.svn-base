package kr.or.ddit.webSockect;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.webSockect.service.SocketUserService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/consultant")
public class ConsultantRestController {
	
	private final SimpMessagingTemplate messagingTemplate;
    // 사용자 서비스 또는 관리자 정보 조회 서비스
    private final SocketUserService userService; // 가상의 서비스

    public ConsultantRestController(SimpMessagingTemplate messagingTemplate, SocketUserService userService) {
        this.messagingTemplate = messagingTemplate;
        this.userService = userService;
    }

    @PostMapping("/request")
    public ResponseEntity<String> requestConsultant(@RequestBody Map<String, String> requestPayload) {
        String requesterId = requestPayload.get("requesterId");
        String issue = requestPayload.get("issue");
        String pageUrl = requestPayload.get("pageUrl");

        log.info("컨설팅 요청 접수: 요청자 ID = {}, 이슈 = {}, URL = {}", requesterId, issue, pageUrl);

        // 1. 컨설팅 요청 정보 저장 (데이터베이스 등)
        // e.g., consultantRequestService.saveRequest(requesterId, issue, pageUrl);

        // 2. 현재 접속 중인 ROLE_SVT_ADMIN 사용자 찾기
        // 실제 구현에서는 캐시나 별도의 온라인 관리자 목록 관리 로직이 필요할 수 있습니다.
        // 여기서는 예시로 'admin1', 'admin2'와 같이 특정 관리자 ID를 지정하거나,
        // 로그인된 사용자 중 ROLE_SVT_ADMIN 역할을 가진 사용자를 동적으로 찾아야 합니다.
        List<String> onlineAdminUserIds = userService.getOnlineUsersByAuthority("ROLE_SVT_ADMIN");

        if (onlineAdminUserIds.isEmpty()) {
            log.warn("접속 중인 ROLE_SVT_ADMIN이 없습니다. 요청을 대기열에 추가합니다.");
            // 나중에 관리자가 접속했을 때 알림을 보내는 로직 (DB에 요청 저장 후 관리자 로그인 시 알림)
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).body("No consultants available.");
        }

        // 3. 찾은 관리자 중 한 명 또는 모두에게 STOMP 메시지 전송
        String targetAdminId = onlineAdminUserIds.get(0); // 첫 번째 관리자에게 보낸다고 가정

        // 새 창을 띄울 때 필요한 정보 (여기서는 요청자 ID를 targetKey로 사용)
        String consultantNotificationData = "{\"targetKey\": \"" + requesterId + "\", \"issue\": \"" + issue + "\"}";

        // SignalingController의 sendConsultantRequest가 처리할 STOMP 메시지 발행
        // @MessageMapping("/consultant/request/{targetUserKey}") 에 매핑되도록 경로 구성
        messagingTemplate.convertAndSend("/app/consultant/request/" + targetAdminId, consultantNotificationData);
        log.info("컨설팅 요청 신호가 관리자({})에게 전송되었습니다.", targetAdminId);

        return ResponseEntity.ok("Consultant request sent successfully.");
    }
}
