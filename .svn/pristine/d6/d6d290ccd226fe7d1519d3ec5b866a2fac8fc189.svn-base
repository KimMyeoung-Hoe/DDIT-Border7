package kr.or.ddit.webSockect;

import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.webSockect.service.SocketUserService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

@Slf4j
@RestController
public class SignalingController {
	
	private final SimpMessagingTemplate messagingTemplate;
    private final SocketUserService userService; // UserService 주입

    public SignalingController(SimpMessagingTemplate messagingTemplate, SocketUserService userService) {
        this.messagingTemplate = messagingTemplate;
        this.userService = userService;
    }
	
	//offer 정보를 주고 받기 위한 websocket
	//camKey : 각 요청하는 캠의 key , roomId : 룸 아이디
	@MessageMapping("/peer/offer/{camKey}/{roomId}")
	@SendTo("/topic/peer/offer/{camKey}/{roomId}")
	public String PeerHandleOffer(@Payload String offer, @DestinationVariable(value = "roomId") String roomId,
			@DestinationVariable(value = "camKey") String camKey) {
		log.info("[OFFER] {} : {}", camKey, offer);
		return offer;
	}

	//iceCandidate 정보를 주고 받기 위한 webSocket
	//camKey : 각 요청하는 캠의 key , roomId : 룸 아이디
	@MessageMapping("/peer/iceCandidate/{camKey}/{roomId}")
	@SendTo("/topic/peer/iceCandidate/{camKey}/{roomId}")
	public Map<String, Object> PeerHandleIceCandidate(@Payload Map<String, Object> candidate, @DestinationVariable(value = "roomId") String roomId,
			@DestinationVariable(value = "camKey") String camKey) {
		log.info("[ICECANDIDATE] {} : {}", camKey, candidate);
		return candidate;
	}

	//
	@MessageMapping("/peer/answer/{camKey}/{roomId}")
	@SendTo("/topic/peer/answer/{camKey}/{roomId}")
	public String PeerHandleAnswer(@Payload String answer, @DestinationVariable(value = "roomId") String roomId,
			@DestinationVariable(value = "camKey") String camKey) {
		log.info("[ANSWER] {} : {}", camKey, answer);
		return answer;
	}

	//camKey 를 받기위해 신호를 보내는 webSocket
	@MessageMapping("/call/key")
	@SendTo("/topic/call/key")
	public String callKey(@Payload String message) {
		log.info("[Key] : {}", message);
		return message;
	}

	//자신의 camKey 를 모든 연결된 세션에 보내는 webSocket
	@MessageMapping("/send/key")
	@SendTo("/topic/send/key")
	public String sendKey(@Payload String message) {
		return message;
	}

	// 채팅 메시지 처리
	@MessageMapping("/chat/{roomId}")
	@SendTo("/topic/chat/{roomId}")
	public Map<String, String> handleChatMessage(@Payload Map<String, String> message, @DestinationVariable String roomId) {
		log.info("[CHAT] {} in room {}: {}", message.get("sender"), roomId, message.get("message"));
		return message;
	}
	
	private final Map<String, List<String>> roomParticipants = new ConcurrentHashMap<>();
	
	//입장 메시지 처리
	@MessageMapping("/chat/join/{roomId}")
    @SendTo("/topic/chat/join/{roomId}")
    public Map<String, String> joinChatMessage(@Payload Map<String, String> message, @DestinationVariable String roomId){
        String sender = message.get("sender");
        roomParticipants.computeIfAbsent(roomId, k -> new CopyOnWriteArrayList<>()).add(sender);
        log.info("[CHAT] {} join room {}: {}", sender, roomId, message.get("message"));
        return message;
    }
	
	// 퇴장 메시지 처리
	@MessageMapping("/chat/leave/{roomId}")
    @SendTo("/topic/chat/leave/{roomId}")
    public Map<String, String> handleLeaveMessage(@Payload Map<String, String> message, @DestinationVariable String roomId) {
        String key = message.get("key");
        List<String> participants = roomParticipants.get(roomId);
        if (participants != null) {
            participants.remove(key);
            if (participants.isEmpty()) {
                roomParticipants.remove(roomId);
            }
        }
        log.info("[LEAVE] {} in room {}", key, roomId);
        Map<String, String> leaveMessage = new HashMap<>();
        leaveMessage.put("sender", key);
        leaveMessage.put("message", " 님이 퇴장하셨습니다.");
        return leaveMessage;
    }
	
	// 화면 켜짐 알림 처리
    @MessageMapping("/stream/start/{roomId}")
    @SendTo("/topic/stream/start/{roomId}")
    public Map<String, String> handleStreamStart(@Payload Map<String, String> message, @DestinationVariable String roomId) {
        String key = message.get("key");
        log.info("[STREAM START] {} in room {}", key, roomId);
        return message; // 켜짐 알림을 다른 클라이언트들에게 전달
    }
	
	// 스트림 종료 알림 처리
	@MessageMapping("/stream/end/{roomId}")
	@SendTo("/topic/stream/end/{roomId}")
	public Map<String, String> handleStreamEnd(@Payload Map<String, String> message,
	 						@DestinationVariable String roomId) {
		String key = message.get("key");
		// (선택 사항) 스트림 종료 시 roomParticipants에서 제거할지 여부 결정
		List<String> participants = roomParticipants.get(roomId);
		if (participants != null) {
			participants.remove(key);
		} 
		log.info("[STREAM END] {} in room {}", key,roomId);
		return message; // 종료 알림을 다른 클라이언트들에게 전달
	}
	
	/**
     * 특정 사용자에게 컨설턴트 요청 신호를 보냅니다.
     * 이 메시지는 주로 'ROLE_SVT_ADMIN' 권한을 가진 사용자에게 보내질 수 있습니다.
     * @param targetUserKey 컨설턴트 요청을 받을 사용자의 키 (e.g., userNo, userId)
     * @param consultantData 컨설팅 관련 추가 데이터 (선택 사항)
     */
    @MessageMapping("/consultant/request/{targetUserKey}")
    public void sendConsultantRequest(@DestinationVariable String targetUserKey,
                                      @Payload String consultantData) {
        log.info("Consultant request received for {}. Data: {}", targetUserKey, consultantData);

        // 직접 targetUserKey에게 메시지를 보냅니다.
        // 클라이언트(header.jsp)에서는 이 경로를 구독해야 합니다.
        messagingTemplate.convertAndSendToUser(targetUserKey, "/queue/consultant/notify", consultantData);
        log.info("Consultant notification sent to user: {}", targetUserKey);
    }

    /**
     * (추가 예시) 시스템 이벤트를 통해 ROLE_SVT_ADMIN에게 알림을 보내는 메서드.
     * 이 메서드는 특정 REST API 호출이나 스케줄된 작업에서 호출될 수 있습니다.
     */
    // 이 메서드는 외부 HTTP 요청 (REST API)을 받을 때 호출되거나,
    // 다른 서비스 (예: SystemMonitoringService)에서 내부적으로 호출될 수 있습니다.
    // @MessageMapping 이 아니라 @RestController 와 @PostMapping 등으로 외부에 노출될 수 있습니다.
    // 여기서는 예시로 컨트롤러 내부에 두었습니다.
    public void notifyAdminsOfPendingConsultation(String userIdWhoNeedsConsultant, String issueDescription) {
        // UserService를 사용하여 ROLE_SVT_ADMIN 권한을 가진 온라인 사용자 조회
        List<String> adminUserIds = userService.getOnlineUsersByAuthority("ROLE_SVT_ADMIN");

        if (adminUserIds.isEmpty()) {
            log.warn("접속 중인 ROLE_SVT_ADMIN이 없어 컨설팅 알림을 보낼 수 없습니다.");
            // 대안 로직: DB에 알림 요청 저장, 이메일/SMS 발송 등
            return;
        }

        String notificationPayload = "{\"targetKey\": \"" + userIdWhoNeedsConsultant + "\", \"issue\": \"" + issueDescription + "\"}";

        for (String adminId : adminUserIds) {
            log.info("Sending consultation notification to admin: {}", adminId);
            // 각 관리자에게 컨설턴트 요청 신호를 보냅니다.
            // 클라이언트의 '/user/{userId}/queue/consultant/notify' 경로로 메시지가 전송됩니다.
            messagingTemplate.convertAndSendToUser(adminId, "/queue/consultant/notify", notificationPayload);
        }
    }
}