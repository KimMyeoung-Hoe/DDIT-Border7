<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<sec:authentication property="principal" var="princ"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../modules/header.jsp"%>
<%@ include file="../modules/sidebar.jsp"%>
<%@ include file="../modules/modal.jsp"%>
<link rel="stylesheet" href="/css/main.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<style type="text/css">
#chatArea {
	border: 1px solid #ccc;
	height: 200px;
	overflow-y: scroll;
	padding: 10px;
	margin-top: 10px;
}

#webSocketChetIpt {
	width: 80%;
	padding: 8px;
	margin-top: 5px;
}

#sendBtn {
	width: 15%;
	padding: 8px;
	margin-left: 5px;
}

#localStream {
	max-width: 100%;
	width: 500px;
	display: none;
}

#remoteStreamDiv {
	width: 100%;
	display: flex;
	flex-wrap: wrap;
}

#startSteamBtn {
	display: none;
}

.subimg {
	max-width: 100%;
	width: 500px;
	display: none;
}

#endSteamBtn {
	display: none;
}

.visible {
	display: block;
}

.flex_div {
	display: flex;
	gap: 20px;
}
</style>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
			<div class="flex_div">
				<input type="number" id="roomIdInput" placeholder="회의실 번호를 입력해주세요"
					max="999" />
				<button type="button" id="enterRoomBtn">입장하기</button>
				<button type="button" id="startSteamBtn">화면 켜기</button>
				<button type="button" id="endSteamBtn">화면 끄기</button>
			</div>

			<!-- 내 화면 엘리먼트 -->
			<div>
				<video id="localStream" autoplay playsinline controls></video>
				<div class="subimg">
					<img alt="프로필" src="">
				</div>

			</div>

			<!-- 영상 받아올 엘리먼트 -->
			<div id="remoteStreamDiv"></div>

			<div class="message full"></div>

			<div id="chatArea"></div>
			<div>
				<input type="text" id="webSocketChetIpt" placeholder="메시지를 입력하세요." />
				<button type="button" id="sendBtn">보내기</button>
			</div>
	
	
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
		</main>
	</div>
</body>
<script>
let localStreamElement = document.querySelector('#localStream');
let myKey = ""; //사용자가 이름 저장하기위함
let roomId; // 회의실 번호
let pcListMap = new Map(); // 접속해있는 브라우저?사람? 의 키가 저장될 변수
let otherKeyList = []; // 접속해있는 브라우저?사람? 의 키가 저장될 변수
let localStream = undefined; //자신의 웹캠과 마이크로부터 얻은 미디어 스트림을 저장 하기위한 변수
let stompClient = null; // stompClient 변수를 전역으로 선언

const chatArea = document.querySelector('#chatArea');
const webSocketChetIpt = document.querySelector('#webSocketChetIpt');
const sendBtn = document.querySelector('#sendBtn');

// 채팅 이름 설정-----------
// 회원 세션으로 변경 할것
/* const fn_setname = () => {
	myKey = prompt("이름을 설정해주세요");
	if(myKey == "" || myKey == null){
		alert("이름을 설정해주세요");
		//회원이름 설정하지않으면 다시
		fn_setname();
	}
}
fn_setname(); */
myKey = "${userName}";
if(myKey=="none" || myKey == '' || myKey == null){
	alert("로그인하셈")
	location.href="/"
}
// 채팅 이름 설정----------- end

//스트림 시작시 내 미디어 장치에 연결 및 송신하기위한 함수
const startCam = async () =>{
    if(navigator.mediaDevices !== undefined){
        await navigator.mediaDevices.getUserMedia({ audio: true, video : true })
            .then(async (stream) => {
                console.log('Stream found');
				console.log(stream);
				//웹캠, 마이크의 스트림 정보를 글로벌 변수로 저장한다.
                localStream = stream;
                // Disable the microphone by default
				// 기본적으로 마이크 비활성화
				//음향
                stream.getAudioTracks()[0].enabled = true;
                localStreamElement.srcObject = localStream;
                // Connect after making sure that local stream is availble
				//로컬 스트림이 사용 가능한지 확인한 후 연결하세요.

            }).catch(error => {
                console.error("Error accessing media devices:", error);
            });
    }

}

// 소켓 연결 함수
const connectSocket = async () =>{
    const socket = new SockJS('/signaling');
    stompClient = Stomp.over(socket);
    stompClient.debug = null;
	
	console.log('pcListMap {}',pcListMap );
	console.log('otherKeyList {}',otherKeyList );
	
    stompClient.connect({}, function () {
		document.querySelector('#startSteamBtn').style.display = 'block';
        console.log('Connected to WebRTC server');
		
		stompClient.send("/app/chat/join/" + roomId, {}, JSON.stringify({
            sender: myKey,
            message: "님이 입장했슴둥"
        }));

		//iceCandidate peer 교환을 위한 subscribe
        stompClient.subscribe("/topic/peer/iceCandidate/" + myKey + "/" + roomId, candidate => {
            const key = JSON.parse(candidate.body).key
            const message = JSON.parse(candidate.body).body;

			// 해당 key에 해당되는 peer 에 받은 정보를 addIceCandidate 해준다.
            pcListMap.get(key).addIceCandidate(new RTCIceCandidate({candidate:message.candidate,sdpMLineIndex:message.sdpMLineIndex,sdpMid:message.sdpMid}));

        });

		//offer peer 교환을 위한 subscribe
        stompClient.subscribe("/topic/peer/offer/" + myKey + "/" + roomId, offer => {
            const key = JSON.parse(offer.body).key;
            const message = JSON.parse(offer.body).body;

			// 해당 key에 새로운 peerConnection 를 생성해준후 pcListMap 에 저장해준다.
            pcListMap.set(key,createPeerConnection(key));
			// 생성한 peer 에 offer정보를 setRemoteDescription 해준다.
            pcListMap.get(key).setRemoteDescription(new RTCSessionDescription({type:message.type,sdp:message.sdp}));
            //sendAnswer 함수를 호출해준다.
			sendAnswer(pcListMap.get(key), key);

        });

		//answer peer 교환을 위한 subscribe
        stompClient.subscribe("/topic/peer/answer/" + myKey + "/" + roomId, answer =>{
            const key = JSON.parse(answer.body).key;
            const message = JSON.parse(answer.body).body;

			// 해당 key에 해당되는 Peer 에 받은 정보를 setRemoteDescription 해준다.
            pcListMap.get(key).setRemoteDescription(new RTCSessionDescription(message));

        });

 		//key를 보내라는 신호를 받은 subscribe
        stompClient.subscribe("/topic/call/key", message =>{
			//자신의 key를 보내는 send
	        stompClient.send("/app/send/key", {}, JSON.stringify(myKey));
        });

		//상대방의 key를 받는 subscribe
        stompClient.subscribe("/topic/send/key", message => {
            const key = JSON.parse(message.body);
			//만약 중복되는 키가 ohterKeyList에 있는지 확인하고 없다면 추가해준다.
            if(myKey !== key && otherKeyList.find((mapKey) => mapKey === myKey) === undefined){
                otherKeyList.push(key);
            }
        });

        // 채팅 메시지 수신
        stompClient.subscribe("/topic/chat/" + roomId, message => {
            const receivedMessage = JSON.parse(message.body);
            displayChatMessage(receivedMessage.sender ,": " + receivedMessage.message);
        });
		
		// 입장 메시지 수신
       stompClient.subscribe("/topic/chat/join/" + roomId, message => {
           const receivedMessage = JSON.parse(message.body);
           displayChatMessage(receivedMessage.sender ,receivedMessage.message);
       });
	   
	   // 퇴장 이벤트 구독
       stompClient.subscribe("/topic/chat/leave/" + roomId, message => {
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
       });
	   
	   // 화면 켜짐 알림 수신
       stompClient.subscribe("/topic/stream/start/" + roomId, message => {
           const starterKey = JSON.parse(message.body).key;
           if (starterKey !== myKey) {
               displayChatMessage("[알림]", starterKey + " 님이 화면을 켰습니다.");
           }
       });
	   
		//화면 공유 종료시 
		// 스트림 종료 알림 수신
		/*stompClient.subscribe(`/topic/stream/end/${roomId}`, message => {
			const enderKey = JSON.parse(message.body).key;
		    console.log('스트림 종료 알림 받음:', enderKey);
		    if (pcListMap.has(enderKey)) {
		        const pcToRemove = pcListMap.get(enderKey);
		        pcToRemove.getSenders().forEach(sender => {
		            if (sender.track && sender.track.kind !== 'data') {
		                pcToRemove.removeTrack(sender);
		            }
		        });
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
		        displayChatMessage("[알림]", `${enderKey} 님이 화면을 껐습니다.`);
		    }
       });*/

    });
}

//화면 공유
let onTrack = (event, otherKey) => {
    if(document.getElementById("" + otherKey + "") === null){
        const video =  document.createElement('video');

        video.autoplay = true;
        video.controls = true;
        video.id = otherKey;
        video.srcObject = event.streams[0];

		// 화면 켠 사람의 화면 가져오기
        document.getElementById('remoteStreamDiv').appendChild(video);
    }
};

const createPeerConnection = (otherKey) =>{
    const pc = new RTCPeerConnection();
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

        console.log('PeerConnection created');
    } catch (error) {
        console.error('PeerConnection failed: ', error);
    }
    return pc;
}
//WebRTC 통신에서 ICE (Interactive Connectivity Establishment) 후보를 처리하고 상대방에게 전송하는 역할
// RTCPeerConnection객체에서 icecandidate 이벤트 발생시
// ice candidate는 Internet Connectivity Establishment(인터넷 연결 생성)
let onIceCandidate = (event, otherKey) => {
    if (event.candidate) {
        console.log('ICE candidate');
        stompClient.send("/app/peer/iceCandidate/" + otherKey + "/" + roomId,{}, JSON.stringify({
            key : myKey,
            body : event.candidate
        }));
    }
};

//WebRTC 통신에서 SDP (Session Description Protocol) Offer를 생성하고 상대방에게 전송하는 역할
let sendOffer = (pc ,otherKey) => {
    pc.createOffer().then(offer =>{
        setLocalAndSendMessage(pc, offer);
        stompClient.send("/app/peer/offer/" + otherKey + "/" + roomId, {}, JSON.stringify({
            key : myKey,
            body : offer
        }));
        console.log('Send offer');
    });
};

//WebRTC 통신에서 SDP (Session Description Protocol) Answer를 생성하고 Offer를 보낸 상대방에게 전송하는 역할
let sendAnswer = (pc,otherKey) => {
    pc.createAnswer().then( answer => {
        setLocalAndSendMessage(pc ,answer);
        stompClient.send("/app/peer/answer/" + otherKey + "/" + roomId, {}, JSON.stringify({
            key : myKey,
            body : answer
        }));
        console.log('Send answer');
    });
};

// 채팅 메시지 표기
const displayChatMessage = (sender, message) => {
	/* 제이쿼리
	    let chatMessage = "";
		chatMessage += "<div>"+sender+" : "+message+"</div>";
	*/
	let ele = document.createElement('div');
	let chatMessage = "" + sender + " " + message + ""
	ele.innerHTML = chatMessage;
	
	let senderCheck = myKey == sender ? "mymessage" : "send";
	ele.className = senderCheck
	
    chatArea.appendChild(ele);
    chatArea.scrollTop = chatArea.scrollHeight; // 스크롤 하단으로 이동
};

//메시지 보내기
const sendChatMessage = () => {
    const message = webSocketChetIpt.value.trim();
	
	if(stompClient == "" || stompClient == null){
		alert("회의실번호를 입력해주세요");
		document.querySelector('#roomIdInput').focus();
		return false;
	}
	
    if (message) {
        stompClient.send("/app/chat/" + roomId, {}, JSON.stringify({
            sender: myKey,
            message: message
        }));
        webSocketChetIpt.value = '';
    }
};

//  WebRTC 통신에서 Offer 또는 Answer를 생성한 후, 해당 SDP를 자신의 로컬 피어 연결(RTCPeerConnection) 객체에 설정하는 역할
const setLocalAndSendMessage = (pc ,sessionDescription) =>{
    pc.setLocalDescription(sessionDescription);
};

// 채팅 메시지 전송 이벤트 리스너
sendBtn.addEventListener('click', sendChatMessage);
webSocketChetIpt.addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
        sendChatMessage();
    }
});

//룸 번호 입력 후 캠 + 웹소켓 실행
document.querySelector('#enterRoomBtn').addEventListener('click', async () =>{
	//로컬 화면에 접근한다.
    //await startCam();

    if(localStream !== undefined){
        document.querySelector('#localStream').style.display = 'block';
        document.querySelector('#startSteamBtn').style.display = 'block';
    }
    roomId = document.querySelector('#roomIdInput').value;
    document.querySelector('#roomIdInput').disabled = true;
    document.querySelector('#enterRoomBtn').disabled = true;
	if(roomId == "" || roomId == null){
		alert("회의실번호를 입력해주세요");
		return false
	}

    await connectSocket();
	
	// 새로운 피어 접속 후 (자신), 스트리밍 중인 피어에게 화면 공유 요청
    setTimeout(() => {
		
		// WebSocket 연결 성공 후 키 요청
	    if (stompClient && stompClient.connected) {
	        stompClient.send("/app/call/key", {}, {});
	    }
		
        if (localStream) { // 자신이 스트림을 켜고 있는 경우 다른 새 참여자는 자동으로 볼 수 있음 (기존 로직 유지)
            otherKeyList.map((key) => {
                if (!pcListMap.has(key)) {
                    pcListMap.set(key, createPeerConnection(key));
                    sendOffer(pcListMap.get(key), key);
                }
            });
        } else { // 자신이 스트림을 안 켜고 있는 경우, 다른 스트리머에게 Offer 요청
            otherKeyList.forEach(async (otherKey) => {
                if (!pcListMap.has(otherKey)) {
                    const newPc = createPeerConnection(otherKey);
                    pcListMap.set(otherKey, newPc);
                    sendOffer(newPc, otherKey); // 자신이 Offer를 보냄
                }
            });
        }
    }, 1500); // 약간의 딜레이 후 실행
});

// 스트림 버튼 클릭시 , 다른 웹 key들 웹소켓을 가져 온뒤에 offer -> answer -> iceCandidate 통신
// peer 커넥션은 pcListMap 으로 저장
document.querySelector('#startSteamBtn').addEventListener('click', async () =>{
	if (!localStream) {
	        await startCam(); // 카메라 및 마이크 접근
	        if (localStream) {
	            document.querySelector('#localStream').style.display = 'block'; // 로컬 화면 표시

				// 화면 켜짐 알림 전송
	            if (stompClient && stompClient.connected && roomId) {
	                stompClient.send("/app/stream/start/" + roomId, {}, JSON.stringify({ key: myKey }));
	                console.log('스트림 시작 알림 전송:', myKey);
	            }
				
	            // 기존 연결된 피어들에게 새로운 스트림 트랙 추가 및 SDP 업데이트 요청
	            pcListMap.forEach((pc, key) => {
	                localStream.getTracks().forEach(track => {
	                    pc.addTrack(track, localStream);
	                });
	                // 상대방에게 SDP 재협상을 요청하는 Offer를 보냅니다.
	                sendOffer(pc, key);
	            });
	        }
	    } else {
	        console.log('이미 화면이 켜져 있습니다.');
	    }

	    // 처음 연결 시의 Offer/Answer 교환 로직 (방 입장 후 초기 피어 연결 시도)
	    if (localStream) { // 로컬 스트림이 있을 때만 초기 연결 시도
	        await stompClient.send("/app/call/key", {}, {}); // 키 요청 (처음 연결 시 필요)
	        setTimeout(() => {
	            otherKeyList.map((key) => {
	                if (!pcListMap.has(key)) {
	                    pcListMap.set(key, createPeerConnection(key));
	                    sendOffer(pcListMap.get(key), key);
	                }
	            });
	        }, 1000);
	    }
		
		// 신규 접속한 피어에게
		// 지속적으로 신호 보내기.. 너무 부하가 심할거같아서 수정해야할듯함..
		setInterval(() => {
            otherKeyList.map((key) => {
                if (!pcListMap.has(key)) {
                    pcListMap.set(key, createPeerConnection(key));
                    sendOffer(pcListMap.get(key), key);
                }
            });
		}, 1000);
	/*await stompClient.send(`/app/call/key`, {}, {});

    setTimeout(() =>{
        otherKeyList.map((key) =>{
            if(!pcListMap.has(key)){
                pcListMap.set(key, createPeerConnection(key));
                sendOffer(pcListMap.get(key),key);
            }
        });
    },1000);*/
});

// 화면 끄기 버튼 클릭시
document.querySelector('#endSteamBtn').addEventListener('click', async () =>{
	//  로컬 스트림 중단
    if (localStream) {
        localStream.getTracks().forEach(track => {
            track.stop(); // 각 트랙(비디오, 오디오) 중단
        });
		
        localStreamElement.srcObject = null; // 로컬 비디오 요소에서 스트림 제거
        localStream = null; // localStream 변수 초기화
        document.querySelector('#localStream').style.display = 'none'; // 로컬 화면 감추기

        // 자신의 피어 연결에서 로컬 트랙 제거
        pcListMap.forEach(pc => {
            pc.getSenders().forEach(sender => {
                if (sender.track && localStream && localStream.getTracks().includes(sender.track)) {
                    pc.removeTrack(sender);
                }
            });
        });
    }

    //원격 피어들에게 스트림 종료 알림 및 트랙 제거 (서버를 통해 알림)
    if (stompClient && stompClient.connected && roomId) {
        stompClient.send("/app/stream/end/" + roomId, {}, JSON.stringify({ key: myKey }));
        console.log('스트림 종료 알림 전송:', myKey);
    }
});

// 브라우저 종료 이벤트
window.addEventListener('beforeunload', () => {
    if (stompClient && stompClient.connected && roomId) {
        stompClient.send("/app/chat/leave/" + roomId, {}, JSON.stringify({ key: myKey }));
        // 브라우저 종료 시 자신의 피어 연결 정리
        pcListMap.forEach(pc => {
            pc.close();
        });
        pcListMap.clear();
    }
});
</script>
</html>