<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<sec:authentication property="principal" var="princ"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>화상체팅</title>

<%@ include file="../modules/header.jsp"%>
<%@ include file="../modules/sidebar.jsp"%>
<%@ include file="../modules/modal.jsp"%>
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/chet.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.js"></script>

<style type="text/css">
</style>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
			<div class="consultant-wrap">
				<div class="flex_div controls">
					<!-- <input type="number" id="roomIdInput" placeholder="회의실 번호를 입력해주세요" max="999" /> -->
					<input type="number" id="roomIdInput" placeholder="회의실" value="${nobang }" />
					<button type="button" id="enterRoomBtn">입장하기</button>
					<button type="button" id="startSteamBtn">화면 켜기</button>
					<button type="button" id="endSteamBtn">화면 끄기</button>
				</div>

				<div class="video-ele-wrap">
					<div id="localStream" class="video-container">
						<video autoplay playsinline controls muted></video> </div>
					<div id="remoteStreamDiv" class="video-container">
						</div>
				</div>

				<div id="chatArea"></div>
				<div class="chat-input-area">
					<input type="text" id="webSocketChetIpt" placeholder="메시지를 입력하세요." />
					<button type="button" id="sendBtn">보내기</button>
				</div>

				<%-- 사용자 정보는 아래에서 JavaScript 변수로 활용 --%>
				<c:choose>
					<c:when test="${princ == 'anonymousUser'}">
						<c:set var="authCode" value="none" />
					</c:when>
					<c:otherwise>
						<c:set var="userNo" value="${princ.user.userNo}" />
						<c:set var="authCode" value="${princ.user.authCode}" />
						<c:set var="userId" value="${princ.user.userId}" />
						<c:set var="userName" value="${princ.user.userName}" />
						<c:set var="userTel" value="${princ.user.userTel}" />
					</c:otherwise>
				</c:choose>
			</div>
		</main>
	</div>
</body>
<script>
//---------- 웹소켓 클라이언트 변수명 변경: roomStompClient ----------
let roomStompClient = null; // 이 페이지에서 사용할 STOMP 클라이언트 변수

let localStreamElement = document.querySelector('#localStream');
let localStreamvideoElement = document.querySelector('#localStream').querySelector("video");
let myKey = ""; //사용자가 이름 저장하기위함 (로그인된 사용자 이름)
let roomId; // 회의실 번호
let pcListMap = new Map(); // 접속해있는 브라우저?사람? 의 키가 저장될 변수
let otherKeyList = []; // 접속해있는 브라우저?사람? 의 키가 저장될 변수
let localStream = undefined; //자신의 웹캠과 마이크로부터 얻은 미디어 스트림을 저장 하기위한 변수
let streamflag = true;

const chatArea = document.querySelector('#chatArea');
const webSocketChetIpt = document.querySelector('#webSocketChetIpt');
const sendBtn = document.querySelector('#sendBtn');

// 로그인된 사용자 이름 설정
myKey = "${userName}";
if(myKey === "none" || myKey === '' || myKey === null){
	alert("로그인해야 합니다.");
	location.href="/login/loginForm.do"; // 로그인 페이지로 리다이렉트
}

// 스트림 시작시 내 미디어 장치에 연결 및 송신하기위한 함수
const startCam = async () => {
    if(navigator.mediaDevices !== undefined){
        try {
            const stream = await navigator.mediaDevices.getUserMedia({ audio: true, video : true });
            console.log('Stream found:', stream);
            localStream = stream;
            //
            if(localStream["localKey"]== undefined){
            	localStream["localKey"] = myKey;
            }
            stream.getAudioTracks()[0].enabled = true; // 기본적으로 마이크 활성화
            localStreamvideoElement.srcObject = localStream;
        } catch (error) {
            console.error("Error accessing media devices:", error);
            alert("카메라 또는 마이크 접근에 실패했습니다. 권한을 확인해주세요.");
        }
    }
}

// 회의실 웹소켓 연결 함수 (이전의 connectSocket과 유사)
const connectRoomWebSocket = async () => {
    if (!roomId) {
        alert("회의실 번호를 먼저 입력해주세요.");
        return;
    }
    
    // 이미 연결되어 있다면 다시 연결 시도하지 않음
    if (roomStompClient && roomStompClient.connected) {
        console.log("Room WebSocket already connected.");
        return;
    }

    const socket = new SockJS('/signaling');
    roomStompClient = Stomp.over(socket);
    roomStompClient.debug = null; // 디버그 메시지 비활성화
	
    console.log('Connecting to room WebSocket...');
    roomStompClient.connect({}, function (frame) {
        console.log('Connected to Room WebRTC server');
		document.querySelector('#startSteamBtn').style.display = 'block';
        document.querySelector('#endSteamBtn').style.display = 'block'; // 화면 끄기 버튼도 보이기

		// 회의실 입장 메시지 전송
        roomStompClient.send("/app/chat/join/" + roomId, {}, JSON.stringify({
            sender: myKey,
            message: "님이 입장했슴둥"
        }));

        // ---------- 기존 WebRTC 및 채팅 관련 구독 로직 (변수명 `roomStompClient`로 변경) ----------
        //iceCandidate peer 교환을 위한 subscribe
        roomStompClient.subscribe("/topic/peer/iceCandidate/" + myKey + "/" + roomId, candidate => {
            const key = JSON.parse(candidate.body).key;
            const message = JSON.parse(candidate.body).body;
            if (pcListMap.has(key)) {
                pcListMap.get(key).addIceCandidate(new RTCIceCandidate({candidate:message.candidate,sdpMLineIndex:message.sdpMLineIndex,sdpMid:message.sdpMid}));
            } else {
                console.warn("PeerConnection for key " + key + " not found when receiving ICE candidate.");
            }
        });

        //offer peer 교환을 위한 subscribe
        roomStompClient.subscribe("/topic/peer/offer/" + myKey + "/" + roomId, offer => {
            const key = JSON.parse(offer.body).key;
            const message = JSON.parse(offer.body).body;
            if (!pcListMap.has(key)) { // 이미 존재하는 PeerConnection이 아니면 새로 생성
                pcListMap.set(key, createPeerConnection(key));
            }
            pcListMap.get(key).setRemoteDescription(new RTCSessionDescription({type:message.type,sdp:message.sdp}));
            sendAnswer(pcListMap.get(key), key);
        });

        //answer peer 교환을 위한 subscribe
        roomStompClient.subscribe("/topic/peer/answer/" + myKey + "/" + roomId, answer =>{
            const key = JSON.parse(answer.body).key;
            const message = JSON.parse(answer.body).body;
            if (pcListMap.has(key)) {
                pcListMap.get(key).setRemoteDescription(new RTCSessionDescription(message));
            } else {
                console.warn("PeerConnection for key " + key + " not found when receiving Answer.");
            }
        });

 		//key를 보내라는 신호를 받은 subscribe
        roomStompClient.subscribe("/topic/call/key", message =>{
			//자신의 key를 보내는 send
	        roomStompClient.send("/app/send/key", {}, JSON.stringify(myKey));
        });

		//상대방의 key를 받는 subscribe
        roomStompClient.subscribe("/topic/send/key", message => {
            const key = JSON.parse(message.body);
			//만약 중복되는 키가 ohterKeyList에 있는지 확인하고 없다면 추가해준다.
            if(myKey !== key && !otherKeyList.includes(key)){ // includes로 변경
                otherKeyList.push(key);
                console.log("New remote key added:", key, "Current otherKeyList:", otherKeyList);
            }
        });

        // 채팅 메시지 수신
        roomStompClient.subscribe("/topic/chat/" + roomId, message => {
            const receivedMessage = JSON.parse(message.body);
            displayChatMessageIcon(receivedMessage.sender ,": " + receivedMessage.message);
        });
		
		// 입장 메시지 수신
       roomStompClient.subscribe("/topic/chat/join/" + roomId, message => {
           const receivedMessage = JSON.parse(message.body);
           displayChatMessage("[알림] " + receivedMessage.sender ,receivedMessage.message);
       });
	   
	   // 퇴장 이벤트 구독
       roomStompClient.subscribe("/topic/chat/leave/" + roomId, message => {
			const receivedMessage = JSON.parse(message.body);
		    const leaverKey = receivedMessage.sender;
		    const leaveMessage = receivedMessage.message;
            
		    if (pcListMap.has(leaverKey)) {
		        pcListMap.get(leaverKey).close();
		        pcListMap.delete(leaverKey);
		        const remoteVideo = document.getElementById(leaverKey);
		        if (remoteVideo) {
		            remoteVideo.remove();
		        }
		        const index = otherKeyList.indexOf(leaverKey);
		        if (index > -1) {
		            otherKeyList.splice(index, 1);
		        }
		        displayChatMessage(leaverKey, leaveMessage);
		    }
		    getLeaveEvent();
       });
	   
	   // 화면 켜짐 알림 수신
       roomStompClient.subscribe("/topic/stream/start/" + roomId, message => {
           const starterKey = JSON.parse(message.body).key;
           if (starterKey !== myKey) {
               displayChatMessage("[알림]", starterKey + " 님이 화면을 켰습니다.");
           }
       });
       
       // 스트림 종료 알림 수신 (주석 해제 및 활성화)
       roomStompClient.subscribe("/topic/stream/end/"+roomId, message => {
           const enderKey = JSON.parse(message.body).key;
           console.log('스트림 종료 알림 받음:', enderKey);
           if (pcListMap.has(enderKey)) {
               const pcToRemove = pcListMap.get(enderKey);
               // 이 부분은 RTCPeerConnection의 track 제거 로직이 필요할 수 있습니다.
               // 현재 코드에서는 스트림 종료 알림만 처리하고 실제 track 제거는 클라이언트 스스로에게 맡기는 방식입니다.
               // 따라서 원격 비디오 요소만 제거하는 것이 더 간단합니다.
               pcToRemove.close(); // 피어 연결 종료
               pcListMap.delete(enderKey);
               const remoteVideoToRemove = document.getElementById(enderKey);
               if (remoteVideoToRemove) {
                   remoteVideoToRemove.remove();
               }
               const index = otherKeyList.indexOf(enderKey);
               if (index > -1) {
                   otherKeyList.splice(index, 1);
               }
               displayChatMessage("[알림]", enderKey+" 님이 화면을 껐습니다.");
           }
       });
        // ---------------------------------------------------------------------------------

    }, function (error) {
        console.error('Room STOMP error: ' + error);
        alert("회의실 연결에 실패했습니다. 다시 시도해주세요.");
    });
}

// WebRTC 관련 함수들은 그대로 유지하되, `stompClient` 대신 `roomStompClient` 사용
let onTrack = (event, otherKey) => {
    if(document.getElementById("" + otherKey + "") === null){
        const video =  document.createElement('video');
        video.autoplay = true;
        video.controls = true;
        video.id = otherKey;
        video.srcObject = event.streams[0];
        document.getElementById('remoteStreamDiv').appendChild(video);
    }
};

const createPeerConnection = (otherKey) =>{
    const pc = new RTCPeerConnection({
        iceServers: [
            { urls: 'stun:stun.l.google.com:19302' } // STUN 서버 추가
        ]
    });
    try {
        pc.addEventListener('icecandidate', (event) =>{
            onIceCandidate(event, otherKey);
        });
        pc.addEventListener('track', (event) =>{
            onTrack(event, otherKey);
        });
        if(localStream !== undefined){
            localStream.getTracks().forEach(track => {
                pc.addTrack(track, localStream);
            });
        }
        console.log('PeerConnection created for', otherKey);
    } catch (error) {
        console.error('PeerConnection failed: ', error);
    }
    return pc;
}

let onIceCandidate = (event, otherKey) => {
    if (event.candidate) {
        console.log('ICE candidate for', otherKey, ':', event.candidate);
        roomStompClient.send("/app/peer/iceCandidate/" + otherKey + "/" + roomId,{}, JSON.stringify({
            key : myKey,
            body : event.candidate
        }));
    }
};

let sendOffer = (pc ,otherKey) => {
    pc.createOffer().then(offer =>{
        return pc.setLocalDescription(offer); // setLocalDescription은 프로미스를 반환
    }).then(() => {
        roomStompClient.send("/app/peer/offer/" + otherKey + "/" + roomId, {}, JSON.stringify({
            key : myKey,
            body : pc.localDescription
        }));
        console.log('Send offer to', otherKey);
    }).catch(error => console.error('Error creating/sending offer:', error));
};

let sendAnswer = (pc,otherKey) => {
    pc.createAnswer().then( answer => {
        return pc.setLocalDescription(answer);
    }).then(() => {
        roomStompClient.send("/app/peer/answer/" + otherKey + "/" + roomId, {}, JSON.stringify({
            key : myKey,
            body : pc.localDescription
        }));
        console.log('Send answer to', otherKey);
    }).catch(error => console.error('Error creating/sending answer:', error));
};

// 채팅 메시지 표기
const displayChatMessage = (sender, message) => {
	let ele = document.createElement('div');
	let chatMessage = "" + sender + " " + message + "";
	ele.innerHTML = chatMessage;
	
	let senderCheck = myKey === sender ? "mymessage" : "send"; // === 사용
	ele.className = senderCheck +" alert";
	
    chatArea.appendChild(ele);
    chatArea.scrollTop = chatArea.scrollHeight; // 스크롤 하단으로 이동
};

const displayChatMessageIcon = (sender, message) => {
	let ele = "";
	if(myKey === sender){
		ele +='<div class="message-row mymessage">';
		ele +='    <div class="message-bubble">';
	}else{
		ele +='<div class="message-row send">';
	    ele +='    <div class="profile-image-wrapper">';
	    ele +='        <i class="fas fa-user"></i>';
	    ele +='    </div>';
	    ele +='    <div class="message-bubble">';
	    ele +='    <div class="sender-name">'+sender+'<div>';
	}
    
    ele +='        <span class="message-content">'+message.replace(":","")+'</span>';    
    ele +='    </div>';
	ele +='    <span class="timestamp">10:19</span>';
    ele +='</div>';
	
   	$("#chatArea").append(ele);
    chatArea.scrollTop = chatArea.scrollHeight; // 스크롤 하단으로 이동
};

//메시지 보내기
const sendChatMessage = () => {
    const message = webSocketChetIpt.value.trim();
	
	if(!roomStompClient || !roomStompClient.connected){ // roomStompClient 확인
		alert("회의실 웹소켓 연결 중이 아닙니다. 회의실에 입장해주세요.");
		return false;
	}
	if(!roomId){
		alert("회의실 번호를 입력하고 입장해주세요.");
		document.querySelector('#roomIdInput').focus();
		return false;
	}
	
    if (message) {
        roomStompClient.send("/app/chat/" + roomId, {}, JSON.stringify({
            sender: myKey,
            message: message
        }));
        webSocketChetIpt.value = '';
    }
};

// 채팅 메시지 전송 이벤트 리스너
sendBtn.addEventListener('click', sendChatMessage);
webSocketChetIpt.addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
        sendChatMessage();
    }
});

// 룸 번호 입력 후 캠 + 웹소켓 실행
document.querySelector('#enterRoomBtn').addEventListener('click', async () => {
    const inputRoomId = document.querySelector('#roomIdInput').value;
    if(inputRoomId === "" || inputRoomId === null){ // === 사용
		alert("회의실 번호를 입력해주세요");
		return false;
	}
    roomId = inputRoomId; // roomId 전역 변수에 할당

    document.querySelector('#roomIdInput').disabled = true;
    document.querySelector('#enterRoomBtn').disabled = true;

    await connectRoomWebSocket(); // 회의실 웹소켓 연결 시작

    // WebRTC 초기화 및 다른 피어들에게 Offer 요청
    setTimeout(async () => {
        if (roomStompClient && roomStompClient.connected) {
        	//streamflag 화면켜기눌럿으면 true이면
        	if(streamflag){
        		// 자신의 카메라/마이크 스트림 가져오기 (필요하다면)
                if (!localStream) {
                    await startCam();
                }
        	}
            

            // 자신의 스트림을 연결된 모든 피어에게 추가
            if (localStream) {
                pcListMap.forEach(pc => {
                    localStream.getTracks().forEach(track => {
                        pc.addTrack(track, localStream);
                    });
                });
            }

            // 현재 방에 있는 다른 사용자의 키 요청
            roomStompClient.send("/app/call/key", {}, {});

            // 다른 피어들에게 Offer 전송 (약간의 딜레이 후)
            setTimeout(() => {
                otherKeyList.forEach(key => { // map 대신 forEach로 변경
                    if (!pcListMap.has(key)) {
                        pcListMap.set(key, createPeerConnection(key));
                        sendOffer(pcListMap.get(key), key);
                    }
                });
            }, 1000); // 키 요청 및 응답 시간을 기다림
        }
    }, 500); // 웹소켓 연결 시간을 기다림
    
});



// 스트림 시작 버튼 클릭시
document.querySelector('#startSteamBtn').addEventListener('click', async () => {
    if (!localStream) { // 아직 카메라/마이크 스트림이 없으면 가져옴
        await startCam(); 
        if (!localStream) { // 스트림을 가져오지 못했으면 중단
            return; 
        }
    }
    
    document.querySelector('#localStream').style.display = 'block'; // 로컬 화면 표시

    if (roomStompClient && roomStompClient.connected && roomId) {
        roomStompClient.send("/app/stream/start/" + roomId, {}, JSON.stringify({ key: myKey }));
        console.log('스트림 시작 알림 전송:', myKey);
    }
    
    // 기존 연결된 피어들에게 새로운 스트림 트랙 추가 및 SDP 업데이트 요청
    pcListMap.forEach((pc, key) => {
        localStream.getTracks().forEach(track => {
            // 이미 트랙이 추가된 상태일 수 있으므로 중복 추가 방지 로직 필요
            // 혹은 removeTrack 후 addTrack으로 트랙 업데이트
            const sender = pc.getSenders().find(s => s.track === track);
            if (!sender) { // 아직 추가되지 않은 트랙인 경우에만 추가
                pc.addTrack(track, localStream);
            }
        });
        sendOffer(pc, key); // 상대방에게 SDP 재협상을 요청하는 Offer를 보냄
    });

    // 지속적으로 신호 보내기 (새로 들어온 피어에게도 연결 시도)
    // 이 setInterval은 주의해서 사용해야 합니다. 네트워크 부하가 커질 수 있습니다.
    // 보통은 peer connection 상태 변화(iceconnectionstatechange)에 따라 재연결을 시도합니다.
    if (!window.peerConnectInterval) { // 중복 인터벌 방지
        window.peerConnectInterval = setInterval(() => {
            otherKeyList.forEach(key => {
                if (!pcListMap.has(key) && localStream) { // 로컬 스트림이 있을 때만 offer
                    const newPc = createPeerConnection(key);
                    pcListMap.set(key, newPc);
                    sendOffer(newPc, key);
                }
            });
        }, 5000); // 5초마다 새로 들어온 피어에게 Offer 시도
    }
});

// 화면 끄기 버튼 클릭시
document.querySelector('#endSteamBtn').addEventListener('click', async () => {
	
    //  로컬 스트림 중단
    if (localStream) {
        localStream.getTracks().forEach(track => {
            track.stop(); // 각 트랙(비디오, 오디오) 중단
        });
        // 자신의 피어 연결에서 로컬 트랙 제거
        pcListMap.forEach(pc => {
            pc.getSenders().forEach(sender => {
                // localStream의 트랙에 해당하는 sender를 찾아 제거
                if (sender.track && sender.track.kind !== 'data' && sender.track.stop) { // 'data' 트랙 제외, stop 메소드 확인
                    // 이 부분이 RTCPeerConnection.removeTrack() 사용 시도
                    // senders에 있는 트랙과 현재 localStream의 트랙을 비교하여 제거
                    const localStreamTracks = Array.from(localStream.getTracks());
                    if (localStreamTracks.includes(sender.track)) {
                         pc.removeTrack(sender);
                    }
                }
            });
            // SDP 재협상 요청
            sendOffer(pc, pc.otherKey); // otherKey를 PeerConnection에 저장하는 로직이 필요할 수 있습니다.
                                        // 또는 pcListMap의 key를 이용
        });

        localStreamvideoElement.srcObject = null; // 로컬 비디오 요소에서 스트림 제거
        localStream = null; // localStream 변수 초기화
        document.querySelector('#localStream').style.display = 'none'; // 로컬 화면 감추기
    }

    // 원격 피어들에게 스트림 종료 알림 (서버를 통해 알림)
    if (roomStompClient && roomStompClient.connected && roomId) {
        roomStompClient.send("/app/stream/end/" + roomId, {}, JSON.stringify({ key: myKey }));
        console.log('스트림 종료 알림 전송:', myKey);
    }
    
    // 인터벌 제거
    if (window.peerConnectInterval) {
        clearInterval(window.peerConnectInterval);
        window.peerConnectInterval = null;
    }
});

// 브라우저 종료 이벤트 (이 페이지용)
window.addEventListener('beforeunload', () => {
    if (roomStompClient && roomStompClient.connected && roomId) {
        // 회의실 퇴장 메시지 전송
        roomStompClient.send("/app/chat/leave/" + roomId, {}, JSON.stringify({ key: myKey }));
        // 자신의 피어 연결 정리
        pcListMap.forEach(pc => {
            pc.close();
        });
        pcListMap.clear();
        roomStompClient.disconnect(); // 이 페이지의 STOMP 연결 끊음
        console.log("Disconnected room WebSocket on unload.");
    }
    if (window.peerConnectInterval) { // 인터벌 정리
        clearInterval(window.peerConnectInterval);
        window.peerConnectInterval = null;
    }
});

document.addEventListener("DOMContentLoaded", async function(){ // async 추가
    // roomIdInput에서 현재 설정된 회의실 번호를 가져옵니다.
    const initialRoomId = document.querySelector('#roomIdInput').value.trim();

    if(initialRoomId === "" || initialRoomId === null){
        // roomIdInput에 값이 없으면, 사용자가 직접 입력하도록 버튼을 활성화된 상태로 둡니다.
        alert("회의실 번호를 입력해주세요.");
        document.querySelector('#roomIdInput').disabled = false; // 혹시라도 비활성화되어있을까봐 명시
        document.querySelector('#enterRoomBtn').disabled = false; // 혹시라도 비활성화되어있을까봐 명시
        return; // 여기서 함수를 종료하여 자동 입장 시도를 막습니다.
    }

    roomId = initialRoomId; // 전역 변수 roomId에 할당

    // 입력 필드와 버튼을 비활성화하여 추가 조작 방지
    document.querySelector('#roomIdInput').disabled = true;
    document.querySelector('#enterRoomBtn').disabled = true;

    let streamflag = false; // streamflag 변수 초기화 (예시: 기본값은 스트림을 켜지 않음)
                            // 이 변수는 '화면 켜기' 버튼 클릭 시 true로 설정되어야 합니다.
                            // 현재 DOMContentLoaded에서 바로 스트림을 켤 의도라면 true로 시작해도 됩니다.
                            // 예: streamflag = true;

    await connectRoomWebSocket(); // 회의실 웹소켓 연결 시작

    // 웹소켓 연결이 성공적으로 된 후에 WebRTC 초기화 및 다른 피어들에게 Offer 요청
    setTimeout(async () => {
        if (roomStompClient && roomStompClient.connected) {
        	if(streamflag){ // streamflag가 true일 때만 로컬 스트림을 시작합니다.
                // 자신의 카메라/마이크 스트림 가져오기
                if (!localStream) { // localStream이 아직 없으면 가져옵니다.
                    const streamSuccess = await startCam();
                    if (!streamSuccess) { // 스트림 획득 실패 시 추가 진행 중단
                        console.error("Failed to get local stream, WebRTC signaling aborted.");
                        return;
                    }
                }
        	}
            
            // NOTE: createPeerConnection 함수에서 localStream을 addTrack하고 있으므로
            // 여기서는 모든 pc에 대해 일괄적으로 addTrack 할 필요가 없습니다.
            // 다른 피어와 연결될 때마다 createPeerConnection이 호출되고 그 안에서 addTrack이 수행됩니다.

            // 현재 방에 있는 다른 사용자의 키 요청 (자신의 존재를 알림)
            roomStompClient.send("/app/call/key", {}, {});

            // 다른 피어들에게 Offer 전송 (약간의 딜레이 후, 다른 피어들의 키를 받은 후)
            setTimeout(() => {
                otherKeyList.forEach(key => {
                    if (myKey !== key && !pcListMap.has(key)) { // 자신을 제외하고 아직 PeerConnection이 없는 경우
                        const newPc = createPeerConnection(key);
                        pcListMap.set(key, newPc);
                        // localStream이 있는 경우에만 Offer를 보냅니다.
                        // 상대방이 내 스트림을 받도록 유도합니다.
                        if (localStream) { 
                            sendOffer(newPc, key);
                        }
                    }
                });
            }, 1000); // `call/key`에 대한 응답을 받을 시간 확보
        } else {
            console.error("Failed to connect room WebSocket, cannot start WebRTC signaling.");
            alert("웹소켓 연결에 실패했습니다. 페이지를 새로고침 해주세요.");
            // 실패 시 입력 필드와 버튼을 다시 활성화하여 재시도 가능하게 합니다.
            document.querySelector('#roomIdInput').disabled = false;
            document.querySelector('#enterRoomBtn').disabled = false;
        }
    }, 500); // 웹소켓 연결 시간을 기다림
});

function getLeaveEvent(){
	console.log("나가기 이벤트 접수")
	alertify.success('상담이 종료되었습니다. 3초후 대시보드로 이동합니다.');
	setTimeout(() => {
		//location.href = "/"
	}, 3000);
	/*
	alertify.success('상담자가 이탈하였습니다 \n 상담 내용을 입력해 주세요.');
	setTimeout(() => {
		$(".consultant-wrap").addClass("off");
		$(".consultant-ipt-wrap").addClass("show");
	}, 1000);
	*/
}

$("#consultantWrite").on("click",function(){
	if($("#consultantContent").val()===""){
		alertify.error('상담 내용을 작성해 주세요');
	}else{
		$.confirm({
	       title: '상담내용 작성',
	       content: '상담내용을 작성하시겠습니까?',
	       buttons: {
	    	  확인: {
					btnClass: 'btn-primary',
					action : function() {
						location.href = "/"
					}
				},
				취소 : {
					btnClass: 'btn-danger',
					action : function() {
						alertify.error('작성을 취소 했습니다.');
					}
	          	}
	       }
	    });
	}
});

</script>
</html>