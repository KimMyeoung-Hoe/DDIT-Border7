<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.13/main.min.css">

<style>
/* --- 플로팅 메뉴 스타일 --- */
.floating-menu {
    position: fixed;
    bottom: 15px;
    right: 15px;
    border-radius: 8px;
    padding: 8px;
    display: flex;
    flex-direction: column;
    align-items: center;
    z-index: 1000; /* 모달/채팅창 아래에 가려지지 않도록 높은 z-index */
}

.floating-button {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 45px;
    height: 45px;
    margin: 6px 0;
    border: none;
    border-radius: 50%;
    background-color: #f5f7fa;
    color: #555555;
    font-size: 20px;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.floating-button:hover {
    background-color: #e9ecf0;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08);
    transform: translateY(-1px);
}

.floating-button:active {
    transform: translateY(0);
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

/* --- 모달 공통 스타일 --- */
.modal-warp {
    display: none; /* 초기에는 숨김 */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6);
    justify-content: center;
    align-items: center;
    z-index: 2000; /* 가장 위에 표시 */
    opacity: 0;
    transition: opacity 0.3s ease;
}

.modal-warp.show {
    opacity: 1;
    display: flex;
}
.modal-warp .modal-flex-column{
	display: flex;
	flex-direction: column;
    gap: 20px;
    align-items: center;
    justify-content: center;
    max-width: 80%;
    width:80%;
}

.modal-content {
    background-color: #ffffff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
    width: 90%;
    max-width: 500px; /* 기본 모달 최대 너비 */
    box-sizing: border-box;
    position: relative;
    animation: fadeInScale 0.3s ease-out forwards;
}

/* 모달 나타날 때 애니메이션 */
@keyframes fadeInScale {
    from {
        opacity: 0;
        transform: scale(0.9);
    }
    to {
        opacity: 1;
        transform: scale(1);
    }
}

.modal-close-button {
    position: absolute;
    top: 15px;
    right: 15px;
    background: none;
    border: none;
    font-size: 24px;
    color: #888;
    cursor: pointer;
    padding: 5px;
    transition: color 0.2s ease;
}

.modal-close-button:hover {
    color: #333;
}

/* --- 검색 모달 내부 스타일 --- */
#searchModal .modal-content{
    max-width: 100%;
    width: 100%;
    
}
#searchModal .modal-content h3 {
    text-align: center;
    color: #333;
    margin: 0 0 25px 0;
    font-size: 24px;
}

#searchModal .search-input-group {
    display: flex;
    gap: 10px;
    margin-bottom: 20px;
}

#searchModal .search-input-group input[type="text"] {
    flex-grow: 1;
    padding: 12px 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    outline: none;
    transition: border-color 0.2s ease;
}

#searchModal .search-input-group input[type="text"]:focus {
    border-color: #007bff;
}

#searchModal .search-input-group button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 12px 20px;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

#searchModal .search-input-group button:hover {
    background-color: #0056b3;
}

#searchModal .search-results {
    border-top: 1px solid #eee;
    padding-top: 15px;
    color:#000000;
    font-size: 14px;
    text-align: center;
}
#searchModal .search-results p{
    color:#000000;
}

/* --- 채팅창 스타일 --- */
.chat-warp {
    display: none; /* 초기에는 숨김 */
    position: fixed;
    bottom: 15px; /* 플로팅 메뉴 위로 띄우기 */
    right: 15px;
    width: 320px; /* 채팅창 너비 */
    height: 400px; /* 채팅창 높이 */
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
    flex-direction: column;
    z-index: 1001; /* 플로팅 메뉴와 모달 사이 또는 그 위 (원하는 위치에 따라) */
    opacity: 0;
    transform: translateY(20px); /* 아래에서 위로 나타나는 효과 */
    transition: opacity 0.3s ease, transform 0.3s ease;
}

.chat-warp.show {
    opacity: 1;
    transform: translateY(0);
    display: flex;
}

.chat-header {
    background-color: #007bff;
    color: white;
    padding: 15px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    font-size: 18px;
    font-weight: bold;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.chat-close-button {
    background: none;
    border: none;
    color: white;
    font-size: 24px;
    cursor: pointer;
    padding: 0 5px;
}

.chat-messages {
    flex-grow: 1;
    padding: 15px;
    overflow-y: auto;
    background-color: #f8f8f8;
    border-bottom: 1px solid #eee;
    display: flex;
    flex-direction: column;
}

.chat-message {
    padding: 8px 12px;
    border-radius: 15px;
    margin-bottom: 10px;
    max-width: 80%;
    word-wrap: break-word;
}

.chat-message.sent {
    align-self: flex-end;
    background-color: #dcf8c6;
}

.chat-message.received {
    align-self: flex-start;
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
}

.chat-input-group {
    display: flex;
    padding: 10px 15px;
    border-top: 1px solid #eee;
}

.chat-input-group input {
    flex-grow: 1;
    padding: 10px 12px;
    border: 1px solid #ddd;
    border-radius: 20px;
    font-size: 14px;
    outline: none;
    margin-right: 10px;
}

.chat-input-group button {
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 20px;
    padding: 10px 15px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.chat-input-group button:hover {
    background-color: #0056b3;
}

/* --- 달력 모달 스타일 (calendarModal에만 적용) --- */
#calendarModal .modal-content {
    max-width: 900px; /* 달력 크기에 맞게 최대 너비 늘림 */
    max-height: 80vh;
    overflow-y: auto;
    width: 95%;      /* 화면 너비에 따라 조절되도록 설정 */
    padding: 20px;   /* 내부 여백 조정 */
}

#calendarModal .modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
    margin-bottom: 20px;
}

#calendarModal .modal-header h3 {
    margin: 0;
    font-size: 24px;
    color: #333;
}

/* FullCalendar 기본 스타일 재정의 (선택 사항) */
.fc .fc-button {
    background-color: #007bff;
    border-color: #007bff;
    color: white;
    transition: background-color 0.2s;
}
.fc .fc-button:hover {
    background-color: #0056b3;
    border-color: #0056b3;
}
.fc .fc-button-primary:not(:disabled).fc-button-active {
    background-color: #0056b3;
    border-color: #0056b3;
}
.fc .fc-daygrid-day.fc-day-today {
    background-color: #e6f7ff; /* 오늘 날짜 배경색 */
}

/* --- 계산기 모달 내부 스타일 (새로 추가) --- */
#calcModal .modal-content {
    max-width: 320px; /* 계산기 크기에 맞게 조정 */
    padding: 20px;
    text-align: center;
}

#calcModal .modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
    margin-bottom: 20px;
}

#calcModal .modal-header h3 {
    margin: 0;
    font-size: 24px;
    color: #333;
}

.calculator {
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 10px;
    background-color: #f9f9f9;
}

.calculator-display {
    width: calc(100% - 20px);
    height: 50px;
    font-size: 2em;
    text-align: right;
    margin-bottom: 10px;
    padding: 5px 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: #e0e0e0;
}

.calculator-buttons {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 10px;
}

.calculator-button {
    width: 100%;
    height: 60px;
    font-size: 1.5em;
    border: none;
    border-radius: 5px;
    background-color: #e0e0e0;
    cursor: pointer;
    transition: background-color 0.2s;
}

.calculator-button:hover {
    background-color: #d0d0d0;
}

.calculator-button.operator {
    background-color: #ff9500;
    color: white;
}
.calculator-button.operator:hover {
    background-color: #e08500;
}

.calculator-button.equals {
    grid-column: span 2;
    background-color: #4CAF50;
    color: white;
}
.calculator-button.equals:hover {
    background-color: #45a049;
}

.calculator-button.clear {
    background-color: #f44336;
    color: white;
}
.calculator-button.clear:hover {
    background-color: #d32f2f;
}
</style>
</head>
<body>
<div class="floating-menu">
    <button class="floating-button" title="계산기" id="calcFloatingButton">
        <i class="fas fa-calculator"></i>
    </button>
    <button class="floating-button" title="달력" id="calendarFloatingButton">
        <i class="fas fa-calendar-alt"></i>
    </button>
    <button class="floating-button" title="돋보기" id="searchFloatingButton">
        <i class="fas fa-search"></i>
    </button>
    <button class="floating-button" title="채팅/문의" id="chatFloatingButton">
        <i class="fas fa-comment"></i>
    </button>
</div>

<div class="modal-warp" id="calcModal">
	<div class="modal-content">
		<div class="modal-header">
            <h3>계산기</h3>
            <button class="modal-close-button" id="closeCalcModalButton">&times;</button>
        </div>
        <div class="calculator">
            <input type="text" class="calculator-display" id="calcDisplay" value="0" disabled />
            <div class="calculator-buttons">
                <button class="calculator-button clear">C</button>
                <button class="calculator-button operator">+/-</button>
                <button class="calculator-button operator">%</button>
                <button class="calculator-button operator">/</button>

                <button class="calculator-button">7</button>
                <button class="calculator-button">8</button>
                <button class="calculator-button">9</button>
                <button class="calculator-button operator">*</button>

                <button class="calculator-button">4</button>
                <button class="calculator-button">5</button>
                <button class="calculator-button">6</button>
                <button class="calculator-button operator">-</button>

                <button class="calculator-button">1</button>
                <button class="calculator-button">2</button>
                <button class="calculator-button">3</button>
                <button class="calculator-button operator">+</button>

                <button class="calculator-button equals">=</button>
                <button class="calculator-button">0</button>
                <button class="calculator-button">.</button>
            </div>
        </div>
	</div>
</div>

<div class="modal-warp" id="calendarModal">
	<div class="modal-content">
        <div class="modal-header">
            <h3>달력</h3>
            <button class="modal-close-button" id="closeCalendarModalButton">&times;</button>
        </div>
		<div id="fullcalendar"></div> </div>
</div>

<div class="modal-warp" id="searchModal">
	<div class="modal-flex-column">
		<div class="modal-content">
	        <button class="modal-close-button" id="closeSearchModalButton">&times;</button>
	        <h3>HS CODE 검색</h3>
	        <div class="search-input-group">
	        	<select>
	        		<option value="code">코드</option>
	        		<option value="krName">한글이름</option>
	        		<option value="enName">영어이름</option>
	        		<option value="code">코드</option>
	        	</select>
	            <input type="text" placeholder="검색어를 입력하세요..." />
	            <button><i class="fas fa-search"></i> 검색</button>
	        </div>
	        <div class="search-results">
	            <p>검색 결과가 여기에 표시됩니다.</p>
	        </div>
		</div>
		<div class="modal-content">
			<h3>계산기</h3>
			<div class="search-input-group">
	            <input type="text" placeholder="원화 금액을 입력하세요" />
	        	<select>
	        		<option value="code">HS코드 에따른 값?</option>
	        		<option value="code">코드</option>
	        	</select>
	        	
	        	<select>
	        		<option value="code">국가 선택 -> 환율 가져오는느낌?</option>
	        		<option value="code">국가1</option>
	        	</select>
	        	
	        	<input type="text" placeholder="결과 출력" disabled="disabled"/>
	            <button><i class="fas fa-search"></i> 검색</button>
	        </div>
		</div>
	</div>
	
</div>

<div class="chat-warp" id="chatWindow">
    <div class="chat-header">
        <span>고객 지원 채팅</span>
        <button class="chat-close-button" id="closeChatButton">&times;</button>
    </div>
    <div class="chat-messages" id="chatMessages">
        <div class="chat-message received">안녕하세요! 무엇을 도와드릴까요?</div>
    </div>
    <div class="chat-input-group">
        <input type="text" id="chatInput" placeholder="메시지를 입력하세요..." />
        <button id="sendChatMessage">보내기</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.13/index.global.min.js"></script>

<script type="text/javascript">
    // --- 공통 모달/창 열고 닫기 함수 ---
    function openModal(modalElement) {
        modalElement.classList.add('show');
    }

    function closeAllModals() {
        document.querySelectorAll('.modal-warp.show, .chat-warp.show').forEach(el => {
            el.classList.remove('show');
        });
    }

    // --- 플로팅 버튼 및 모달/창 요소 가져오기 ---
    const calcFloatingButton = document.getElementById('calcFloatingButton');
    const calendarFloatingButton = document.getElementById('calendarFloatingButton');
    const searchFloatingButton = document.getElementById('searchFloatingButton');
    const chatFloatingButton = document.getElementById('chatFloatingButton');

    const calcModal = document.getElementById('calcModal');
    const closeCalcModalButton = document.getElementById('closeCalcModalButton');
    
    const calendarModal = document.getElementById('calendarModal');
    const closeCalendarModalButton = document.getElementById('closeCalendarModalButton');
    
    const searchModal = document.getElementById('searchModal');
    const closeSearchModalButton = document.getElementById('closeSearchModalButton'); // ID 변경됨

    const chatWindow = document.getElementById('chatWindow');
    const closeChatButton = document.getElementById('closeChatButton');
    const chatInput = document.getElementById('chatInput');
    const sendChatMessageButton = document.getElementById('sendChatMessage');
    const chatMessagesContainer = document.getElementById('chatMessages');

    // --- 검색 모달 이벤트 리스너 ---
    searchFloatingButton.addEventListener('click', () => {
        closeAllModals(); // 다른 모달/창 닫기
        openModal(searchModal);
    });
    closeSearchModalButton.addEventListener('click', () => {
        searchModal.classList.remove('show');
    });
    searchModal.addEventListener('click', (event) => {
        if (event.target === searchModal) {
            searchModal.classList.remove('show');
        }
    });

    // --- 채팅창 이벤트 리스너 ---
    chatFloatingButton.addEventListener('click', () => {
        closeAllModals(); // 다른 모달/창 닫기
        chatWindow.classList.toggle('show'); // 토글하여 열고 닫음
        if (chatWindow.classList.contains('show')) {
            chatInput.focus();
            chatMessagesContainer.scrollTop = chatMessagesContainer.scrollHeight;
        }
    });
    closeChatButton.addEventListener('click', () => {
        chatWindow.classList.remove('show');
    });

    // 메시지 전송 함수
    function sendMessage() {
        const messageText = chatInput.value.trim();
        if (messageText !== "") {
            const messageDiv = document.createElement('div');
            messageDiv.classList.add('chat-message', 'sent');
            messageDiv.textContent = messageText;
            chatMessagesContainer.appendChild(messageDiv);
            chatInput.value = "";
            chatMessagesContainer.scrollTop = chatMessagesContainer.scrollHeight;
        }
    }
    sendChatMessageButton.addEventListener('click', sendMessage);
    chatInput.addEventListener('keypress', (event) => {
        if (event.key === 'Enter') {
            sendMessage();
        }
    });

    // --- 달력 모달 이벤트 리스너 및 FullCalendar 초기화 ---
    let calendar; // FullCalendar 인스턴스를 저장할 변수

    calendarFloatingButton.addEventListener('click', () => {
        closeAllModals(); // 다른 모달/창 닫기
        openModal(calendarModal);
        
        if (!calendar) { // 달력이 아직 초기화되지 않았다면
            const fullcalendarEl = document.getElementById('fullcalendar');
            calendar = new FullCalendar.Calendar(fullcalendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                locale: 'ko',
                height: 'auto',
                events: [
                    { title: '회의', start: '2025-06-05T10:00:00', end: '2025-06-05T12:00:00', color: '#28a745' },
                    { title: '팀 점심', start: '2025-06-07T13:00:00', color: '#ffc107' },
                    { title: '보고서 마감', start: '2025-06-10', end: '2025-06-11', allDay: true, color: '#dc3545' }
                ],
                dateClick: function(info) {
                    alertify.alert('날짜 클릭: ' + info.dateStr);
                },
                eventClick: function(info) {
                    alertify.alert('이벤트 클릭: ' + info.event.title + ' on ' + info.event.start.toLocaleDateString());
                }
            });
            calendar.render();
        } else {
            calendar.render(); // 이미 초기화된 달력이 있다면, 크기 변경 등에 대응하여 다시 렌더링
        }
    });
    closeCalendarModalButton.addEventListener('click', () => {
        calendarModal.classList.remove('show');
    });
    calendarModal.addEventListener('click', (event) => {
        if (event.target === calendarModal) {
            calendarModal.classList.remove('show');
        }
    });

    // --- 계산기 모달 이벤트 리스너 및 기능 ---
    const calcDisplay = document.getElementById('calcDisplay');
    let currentInput = '0';
    let operator = null;
    let previousInput = '';
    let resetDisplay = false;

    calcFloatingButton.addEventListener('click', () => {
        closeAllModals();
        openModal(calcModal);
        calcDisplay.value = currentInput; // 모달 열릴 때 현재 값으로 초기화
    });
    closeCalcModalButton.addEventListener('click', () => {
        calcModal.classList.remove('show');
    });
    calcModal.addEventListener('click', (event) => {
        if (event.target === calcModal) {
            calcModal.classList.remove('show');
        }
    });

    document.querySelectorAll('#calcModal .calculator-button').forEach(button => {
        button.addEventListener('click', (e) => {
            const value = e.target.textContent;

            if (e.target.classList.contains('clear')) {
                currentInput = '0';
                operator = null;
                previousInput = '';
                resetDisplay = false;
            } else if (e.target.classList.contains('operator')) {
                if (value === '+/-') {
                    currentInput = String(parseFloat(currentInput) * -1);
                } else if (value === '%') {
                    currentInput = String(parseFloat(currentInput) / 100);
                } else {
                    if (operator && previousInput !== '') {
                        calculate();
                    }
                    operator = value;
                    previousInput = currentInput;
                    resetDisplay = true;
                }
            } else if (e.target.classList.contains('equals')) {
                calculate();
                operator = null;
                resetDisplay = true;
            } else { // Number or decimal
                if (currentInput === '0' || resetDisplay) {
                    currentInput = value === '.' ? '0.' : value;
                    resetDisplay = false;
                } else if (value === '.' && currentInput.includes('.')) {
                    // Do nothing if decimal already exists
                } else {
                    currentInput += value;
                }
            }
            calcDisplay.value = currentInput;
        });
    });

    function calculate() {
        let result;
        const prev = parseFloat(previousInput);
        const current = parseFloat(currentInput);

        if (isNaN(prev) || isNaN(current)) return;

        switch (operator) {
            case '+': result = prev + current; break;
            case '-': result = prev - current; break;
            case '*': result = prev * current; break;
            case '/': result = prev / current; break;
            default: return;
        }
        currentInput = String(result);
    }

    // --- 공통 ESC 키 닫기 ---
    document.addEventListener('keydown', (event) => {
        if (event.key === 'Escape') {
            closeAllModals();
        }
    });
</script>
