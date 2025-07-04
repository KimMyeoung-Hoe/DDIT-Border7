package kr.or.ddit.webSockect;

import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import org.springframework.web.socket.messaging.SessionSubscribeEvent;

@Component
public class WebSocketEventListener {

	private final SimpMessageSendingOperations messagingTemplate;
    // 전체 시스템에 로그인하여 WebSocket에 연결된 사용자 목록 (사용자 ID -> 세션 ID)
    private final Map<String, String> connectedUsers = new ConcurrentHashMap<>();

    @Autowired
    public WebSocketEventListener(SimpMessageSendingOperations messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    @EventListener
    public void handleWebSocketConnectListener(SessionConnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());

        String username = null;
        if (headerAccessor.getUser() != null) {
            // Spring Security를 통해 인증된 사용자 이름 가져오기
            username = headerAccessor.getUser().getName(); // Principal의 getName() 사용
            // 또는 Authentication 객체에서 직접 가져올 수도 있습니다.
            // Authentication authentication = (Authentication) headerAccessor.getUser();
            // if (authentication != null) {
            //     username = authentication.getName();
            // }
        }

        // 로그인되지 않은 사용자도 WebSocket에 연결될 수 있으므로, username이 null이 아닌 경우에만 처리
        if (username != null) {
            String sessionId = headerAccessor.getSessionId();
            // 한 사용자가 여러 탭에서 접속할 경우를 대비하여 Map에 저장
            // 여기서는 간단히 마지막 접속 세션 ID를 저장하는 방식으로 처리 (다른 전략도 가능)
            connectedUsers.put(username, sessionId);
            System.out.println("User connected: " + username + " (Session ID: " + sessionId + ")");

            // 사용자 목록이 업데이트되었음을 모든 클라이언트에 알림
            // Set<String>으로 변환하여 전송 (중복 방지)
            messagingTemplate.convertAndSend("/topic/onlineUsers", new HashSet<>(connectedUsers.keySet()));
        }
    }

    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        String sessionId = headerAccessor.getSessionId();

        // disconnectedUsers에서 해당 세션 ID를 가진 사용자를 찾아서 제거
        String usernameToRemove = null;
        for (Map.Entry<String, String> entry : connectedUsers.entrySet()) {
            if (entry.getValue().equals(sessionId)) {
                usernameToRemove = entry.getKey();
                break;
            }
        }

        if (usernameToRemove != null) {
            connectedUsers.remove(usernameToRemove);
            System.out.println("User disconnected: " + usernameToRemove + " (Session ID: " + sessionId + ")");
            // 사용자 목록이 업데이트되었음을 모든 클라이언트에 알림
            messagingTemplate.convertAndSend("/topic/onlineUsers", new HashSet<>(connectedUsers.keySet()));
        }
    }

    // 클라이언트가 /topic/onlineUsers 를 구독할 때, 현재 사용자 목록을 즉시 보내줄 수 있도록 함
    @EventListener
    public void handleSessionSubscribeEvent(SessionSubscribeEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        String destination = headerAccessor.getDestination();

        // "/topic/onlineUsers"를 구독하는 경우에만 현재 사용자 목록 전송
        if ("/topic/onlineUsers".equals(destination)) {
            String username = null;
            if (headerAccessor.getUser() != null) {
                username = headerAccessor.getUser().getName();
            }
            System.out.println("User " + username + " subscribed to " + destination + ". Sending current online user list.");
            messagingTemplate.convertAndSend("/topic/onlineUsers", new HashSet<>(connectedUsers.keySet()));
        }
    }

    // 현재 접속 중인 사용자 목록을 반환하는 메서드 (필요시)
    public Set<String> getConnectedUsers() {
        return Collections.unmodifiableSet(new HashSet<>(connectedUsers.keySet()));
    }
}
