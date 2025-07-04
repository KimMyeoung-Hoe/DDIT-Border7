package kr.or.ddit.webSockect.service;

import java.util.List;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SystemMonitoringService {
	
	private final SimpMessagingTemplate messagingTemplate;
    private final SocketUserService userService; // 관리자 정보 조회 서비스

    public SystemMonitoringService(SimpMessagingTemplate messagingTemplate, SocketUserService userService) {
        this.messagingTemplate = messagingTemplate;
        this.userService = userService;
    }

    public void notifyAdminAboutCriticalError(String errorDetails, String affectedUserNo) {
        log.warn("심각한 오류 발생! 관리자에게 알림을 보냅니다. 오류: {}", errorDetails);

        // 1. 현재 접속 중인 ROLE_SVT_ADMIN 사용자 찾기
        List<String> onlineAdminUserIds = userService.getOnlineUsersByAuthority("ROLE_SVT_ADMIN"); // 가상의 메서드

        if (onlineAdminUserIds.isEmpty()) {
            log.error("오류 발생 시 접속 중인 관리자가 없어 알림을 보낼 수 없습니다. (오류: {})", errorDetails);
            // 오류를 DB에 저장하거나 다른 방식으로 관리자에게 통보 (SMS, 이메일 등)
            return;
        }

        // 2. 찾은 관리자들에게 STOMP 메시지 전송
        for (String adminId : onlineAdminUserIds) {
            String notificationData = "{\"targetKey\": \"" + affectedUserNo + "\", \"type\": \"criticalError\", \"details\": \"" + errorDetails + "\"}";
            
            // SignalingController의 sendConsultantRequest가 처리할 STOMP 메시지 발행
            // /app/consultant/request/{adminId} 로 메시지를 보내면,
            // SignalingController의 @MessageMapping("/consultant/request/{targetUserKey}") 메서드가 해당 메시지를 받아서
            // messagingTemplate.convertAndSendToUser(targetUserKey, "/queue/consultant/notify", consultantData);
            // 이 구문을 통해 최종적으로 해당 adminId 에게 메시지를 보냅니다.
            messagingTemplate.convertAndSend("/app/consultant/request/" + adminId, notificationData);
            log.info("시스템 오류 알림이 관리자({})에게 전송되었습니다. (관련 사용자: {})", adminId, affectedUserNo);
        }
    }

    // 이 메서드는 스케줄러, 특정 비즈니스 로직 처리 중 예외 발생 시 등에서 호출될 수 있습니다.
    // @Scheduled(fixedRate = 60000) // 1분마다 호출 (예시)
    // public void checkSystemStatus() {
    //     if (someCriticalConditionIsMet()) {
    //         notifyAdminAboutCriticalError("데이터베이스 연결 이상", "N/A");
    //     }
    // }
}
