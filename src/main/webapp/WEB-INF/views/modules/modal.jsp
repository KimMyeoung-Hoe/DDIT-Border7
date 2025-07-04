<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.13/main.min.css">

<style>
#mainprocess .modal-content{
	width: 1500px;
	max-width: 1624px;
}
#mainprocess .modal-content .modal-body{
	text-align: center;
}
#mainprocess .process-img{
    background: url(/img/prosess.png) center no-repeat;
    background-size: 1410px 800px;
	width: 100%;
    height: 800px;
}
#mainprocess .process-img.ex{
    background: url(/img/prosess2.png) center no-repeat;
    background-size: 1410px 800px;
}
</style>
<body>
<div class="floating-menu">
	<div class="floating-button" id="requestConsultantBtn">
	    <i class="fas fa-info"></i>
	</div>
	<!-- <button class="floating-button" title="유저리스트" id="userListBtn">
        <i class="fas fa-calculator"></i>
    </button> -->
    <button class="floating-button" title="계산기" id="calcFloatingButton">
        <i class="fas fa-calculator"></i>
    </button>
    <button class="floating-button" title="달력" id="calendarFloatingButton">
        <i class="fas fa-calendar-alt"></i>
    </button>
    <button class="floating-button" title="돋보기" id="searchFloatingButton">
        <i class="fas fa-search"></i>
    </button>
    <button class="floating-button" title="채팅/문의" id="chatButton">
		<svg class="chat-icon" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
		     <path d="M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H5.17L4 17.17V4h16v12z"/>
		     <path d="M7 9h10v2H7z"/>
		     <path d="M7 12h7v2H7z"/>
		     <path d="M7 6h10v2H7z"/>
		 </svg>
    </button>
    
    <button class="floating-button" style="display: none;" title="채팅/문의" id="chatFloatingButton">
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
		<div id="fullcalendar"></div>
	</div>
</div>

<div class="modal-warp" id="searchModal">
	<div class="modal-flex-column">
		<div class="modal-2nd">
			<div class="modal-content" id="hsSearch-content">
		        <h3>HS CODE 검색</h3>
		        <div class="search-input-group">
		        	<select
						name="hsSearchType" class="searchModalHsSearchType" class="form-select">
						<option value="code">코드</option>
						<option value="krName">한글이름</option>
					</select>
		            <input type="text" name="hsSearch" id="hsSearch" autocomplete="off" placeholder="검색어를 입력하세요..." />
		        </div>
		        <div class="search-results" >
		        	<div class="search-answer-wrap">
		        		<div class="search-answer-item">검색어를 입력하세용</div>
		        	</div>
		        </div>
			</div>
			<div class="modal-content" id="nationSearch-content">
		        <button class="modal-close-button" id="closeSearchModalButton">&times;</button>
		        <h3>국가 검색</h3>
		        <div class="search-input-group">
		            <input type="text" name="nationSearch" id="nationSearch" autocomplete="off" placeholder="검색어를 입력하세요..." />
		        </div>
		        <div class="search-results" >
		        	<div class="search-answer-wrap">
		        		<div class="search-answer-item">검색어를 입력하세용</div>
		        	</div>
		        </div>
			</div>
		</div>
		
		<div class="modal-content">
			<h3>관세 계산기</h3>
			<div class="search-input-label mb-1">
				<div class="amountLabel">원</div>
				<div class="hscodeLabel">코드</div>
				<div class="nationLabel">국가</div>
				<div class="answerLabel">결과</div>
			</div>
			<div class="search-input-group mb-0">
	            
	            <input type="number" id="enterAmount" name="enterAmount" placeholder="원화 금액을 입력하세요" />
	        	
	        	<div class="modal-search-sm-wrap">
	        		<input type="text" name="hsSearchAnswer" id="hsSearchAnswer" value="0" readonly="readonly">
	        	</div>
	        	<div class="modal-search-sm-wrap">
	        		<input type="number" name="nationSearchAnswer" id="nationSearchAnswer" value="0" readonly="readonly">
	        	</div>
	        	
	        	<input type="text" id="answer-ipt" class="answer-ipt" placeholder="결과 출력" disabled="disabled"/>
	        </div>
		</div>
	</div>
</div>

<div class="modal-warp" id="modalOverlay">
    <div class="modal">
        <div class="modal-header">
            <span>챗봇 열기</span>
            <button class="close-btn">✕</button>
        </div>
        <div class="modal-body">
            <button class="option-button" onclick="openWithOS()">
                <svg class="option-icon" width="18" height="18" viewBox="0 0 24 24" fill="#4e6ef2" xmlns="http://www.w3.org/2000/svg">
                    <path d="M21 2H3c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h7v2H8v2h8v-2h-2v-2h7c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H3V4h18v12z"/>
                </svg>
                OS로 열기
            </button>
            <button class="option-button" onclick="openWithWeb()">
                <svg class="option-icon" width="18" height="18" viewBox="0 0 24 24" fill="#4e6ef2" xmlns="http://www.w3.org/2000/svg">
                    <path d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zm6.93 6h-2.95c-.32-1.25-.78-2.45-1.38-3.56 1.84.63 3.37 1.91 4.33 3.56zM12 4.04c.83 1.2 1.48 2.53 1.91 3.96h-3.82c.43-1.43 1.08-2.76 1.91-3.96zM4.26 14C4.1 13.36 4 12.69 4 12s.1-1.36.26-2h3.38c-.08.66-.14 1.32-.14 2 0 .68.06 1.34.14 2H4.26zm.82 2h2.95c.32 1.25.78 2.45 1.38 3.56-1.84-.63-3.37-1.9-4.33-3.56zm2.95-8H5.08c.96-1.66 2.49-2.93 4.33-3.56C8.81 5.55 8.35 6.75 8.03 8zM12 19.96c-.83-1.2-1.48-2.53-1.91-3.96h3.82c-.43 1.43-1.08 2.76-1.91 3.96zM14.34 14H9.66c-.09-.66-.16-1.32-.16-2 0-.68.07-1.35.16-2h4.68c.09.65.16 1.32.16 2 0 .68-.07 1.34-.16 2zm.25 5.56c.6-1.11 1.06-2.31 1.38-3.56h2.95c-.96 1.65-2.49 2.93-4.33 3.56zM16.36 14c.08-.66.14-1.32.14-2 0-.68-.06-1.34-.14-2h3.38c.16.64.26 1.31.26 2s-.1 1.36-.26 2h-3.38z"/>
                </svg>
                웹으로 열기
            </button>
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

<div class="modal-warp" id="mainprocess">
	<div class="modal-content">
        <div class="modal-header">
            <h3>수입</h3>
            <button class="modal-close-button" id="closemainprocessButton">&times;</button>
        </div>
        
        <div class="modal-body">
        	<div class="process-img"></div>
        </div>
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
    const closeSearchModalButton = document.getElementById('closeSearchModalButton');

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
            	// 달력 화면 구성 --------------------------------------------------
        		initialView: 'dayGridMonth',		// 초기화면 달력 종류 설정 (월간달력으로)
        		locale: "ko",						// 언어 설정
    	        headerToolbar: {					// 헤더 툴바에 구성할 버튼 설정
    	            left: 'prevYear,prev,today,next,nextYear',
    	            center: 'title',
    	            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
    	        },
    	        buttonText: {						// 버튼에 표기할 TEXT 설정
    	    		  today: '오늘',
    	    		  month: '월',
    	    		  week: '주',
    	    		  day: '일',
    	    		  list: '할일목록'
    	    	},
    	    	editable: false,						// 드래그 및 크기조절 설정
    	        selectable: false,					// 드래그 사용여부 설정
    	        dayMaxEvents: true,					// 일정이 많으면 '더보기'로 이벤트 표시
        		// 월간달력 설정 ----------------------------------------------------
        		height: '800px',					// 달력 세로길이 설정
        		navLinks: true,						// 날짜 선택 시 Day 캘린더 링크로 이동
    	    	// 주간,일간달력 설정
    	    	nowIndicator: true,					// 현재 시간 마크
    	        slotMinTime: '00:00',				// 일정 시작시간
    	        slotMaxTime: '24:00',				// 일정 종료시간
    	        
    	    	// 달력 이벤트 설정 --------------------------------------------------------
    	    	// 달력 이벤트 설정 (1) 달력 조회 기능
    	       	events: [
    	            $.ajax({
    	                type: "get",
    	                url: "/myPage/calendarList",
    	                success: function (data) {
    	                    if (data != null) {
    	                        for (let i = 0; i < data.length; i++) {
    	                        	calendar.addEvent({
    	                            	id: data[i].calendarNo,
    	                                title: data[i].calendarTitle,
    	                                start: data[i].calendarStrDate,
    	                                end: data[i].calendarEndDate,
    	                                allDay: data[i].calendarAllYn,
    	                                color: data[i].calendarColor
    	                            });
    	                        }
    	                    }
    	                }
    	            })
    	        ]
            })
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
    
    // 원화 - 환율 - hs 세율 계산기 모달
 	// --- HS 코드 검색 기능 ---

	// HS 검색 입력 필드에서 Enter 키를 눌렀을 때 폼 전송 방지
	$("#hsSearch").on("keydown", function(e) {
	    if (e.key === "Enter") {
	        e.preventDefault();
	    }
	});
	
	// HS 코드 드롭다운 항목 클릭 처리
	$("#hsSearch-content").on("click", ".search-answer-item", function() {
	    //$("#hsdropdown").addClass("dropdown-off"); // 드롭다운 숨기기
	
	    // 클릭된 항목에서 데이터 추출
	    let hsCode = $(this).data("hscode");
	    let hskrname = $(this).data("hskrname");
	    
	    let hstariffrate = $(this).data("hstariffrate");//환율
	
	    // 추출된 데이터로 입력 필드 채우기
	    $("#hsSearch").val(hsCode); // 표시할 이름 또는 코드 미정
	    if(hsCode != undefined){
	    	$(".hscodeLabel").html("선택된 코드 : "+hsCode+"의 과세율"); // 표시할 이름 또는 코드 미정
	    	
		    $("#hsSearchAnswer").val(hstariffrate+"%"); //관세율 할당
			
	    }else{
	    	$(".hscodeLabel").html("잘못 선택된 코드입니다."); // 표시할 이름 또는 코드 미정
	    	$("#hsSearchAnswer").val(0); //관세율 할당
	    }
	    fn_calc();
	});
	
	$("#hsSearch").on("keyup",function(){
		let hsCode = $("#hsSearch").val();
		let searchModalHsSearchType = $(".searchModalHsSearchType").val();
		let data = {
			hsSearchType : searchModalHsSearchType,
			hsSearchWord : hsCode
		}
	
		$.ajax({
			url : "/api/hsCodeSearch.do",
			type : "post",
			contentType:"application/json; charset=utf-8",
			data : JSON.stringify(data),
			success : function(res){
				let htmlCode = '';
				//console.log(res)
				if(res == '' || res == null){
					htmlCode += '<div class="search-answer-item">조회된 내용이없습니다.</div>';
				}else{
					res.forEach(function(v,i) {
						htmlCode += '<div class="search-answer-item" data-hsCode="'+v.hsCode+'" data-hsEnName="'+v.hsEnName+'"';
						htmlCode += 'data-hsEndDate="'+v.hsEndDate+'" data-hsExportNatureCode="'+v.hsExportNatureCode+'"';
						htmlCode += 'data-hsImportNatureCode="'+v.hsImportNatureCode+'" data-hsKrName="'+v.hsKrName+'"';
						htmlCode += 'data-hsNcc="'+v.hsNcc+'" data-hsNccName="'+v.hsNccName+'"';
						htmlCode += 'data-hsQty="'+v.hsQty+'" data-hsRegDate="'+v.hsRegDate+'"';
						htmlCode += 'data-hsTariffRate="'+v.hsTariffRate+'" data-hsTariffRateType="'+v.hsTariffRateType+'"';
						htmlCode += 'data-hsWeight="'+v.hsWeight+'"';
						htmlCode += '>';
						
						//hscode로 검색시표시해줄것들 보여지는값 미정
						htmlCode += v.hsCode +" / "+v.hsEnName+" / "+v.hsKrName+" / "+v.hsNccName;
						
						htmlCode += '</div>';
					});
				}
				
				$("#hsSearch-content .search-answer-wrap").html(htmlCode);
			}
		})//ajax
	})

 	// --- HS 코드 검색 기능 end ---
	
	// --- 국가 검색 기능 ---
	// 국가 검색 입력 필드에서 Enter 키를 눌렀을 때 폼 전송 방지
	$("#nationSearch").on("keydown", function(e) {
	    if (e.key === "Enter") {
	        e.preventDefault();
	    }
	});
	
	// 국가 드롭다운 항목 클릭 처리
	$("#nationSearch-content").on("click", ".search-answer-item", function() {
	    // 클릭된 항목에서 데이터 추출
	    let nationKrName = $(this).data("nationkrname");
	    let nationName = $(this).data("nationname");
	    let exchrate = $(this).data("exchrate");

	    // 추출된 데이터로 입력 필드 채우기
	    $("#nationSearch").val(nationKrName);
	    
		if(nationKrName != undefined){
	    	$(".nationLabel").html("선택된 국가 : "+nationKrName +"의 원화 1원당 환율"); // 표시할 이름 또는 코드 미정
	    	 $("#nationSearchAnswer").val(exchrate); // 숨겨진 필드에 실제 국가 코드 저장
	    }else{
	    	$(".nationLabel").html("잘못 선택된 국가입니다."); // 표시할 이름 또는 코드 미정
	    	$("#nationSearchAnswer").val(0); //관세율 할당
	    }

 		fn_calc();
	});
	
	$("#nationSearch").on("keyup",function(){
		let nationSearch = $("#nationSearch").val();
		let data = {
			searchWord : nationSearch
		}
	
		$.ajax({
			url : "/api/nationSearch.do",
			type : "post",
			contentType:"application/json; charset=utf-8",
			data : JSON.stringify(data),
			success : function(res){
				let htmlCode = '';
				//console.log(res)
				if(res == '' || res == null){
					htmlCode += '<div class="search-answer-item">조회된 내용이없습니다.</div>';
				}else{
					res.forEach(function(v,i) {
						htmlCode += '<div class="search-answer-item" data-currencyCode="'+v.currencyCode+'" data-currencyName="'+v.currencyName+'"';
						htmlCode += 'data-currencySymbol="'+v.currencySymbol+'" data-exRateNo="'+v.exRateNo+'"';
						htmlCode += 'data-exchRate="'+v.exchRate+'" data-nationCode="'+v.nationCode+'"';
						htmlCode += 'data-nationEnName="'+v.nationEnName+'" data-nationKrName="'+v.nationKrName+'"';
						htmlCode += 'data-nationNo="'+v.nationNo+'" data-refDt="'+v.refDt+'"';
						htmlCode += 'data-hsWeight="'+v.hsWeight+'"';
						
						htmlCode += '>';
						
						//hscode로 검색시표시해줄것들 보여지는값 미정
						htmlCode += v.currencyCode +" / "+v.currencyName+" / "+v.currencySymbol+" / "+v.nationKrName;
						
						htmlCode += '</div>';
					});
				}
				
				$("#nationSearch-content .search-answer-wrap").html(htmlCode);
			}
		})//ajax
	})
	// --- 국가 검색 기능 end ---
	
	$("#enterAmount").on("keyup",function(){
		fn_calc()
	})
	
	//계산 값 출력하기
	function fn_calc(){
		let hsSearchAnswer = $("#hsSearchAnswer").val().replace('%', '');
		let rat = parseFloat(parseInt(hsSearchAnswer)/100); // 숨겨진 필드에 실제 환율로 변환 (x / 100);
		
		let nationSearchAnswer = parseFloat($("#nationSearchAnswer").val());
		if($("#enterAmount").val() == "" || $("#enterAmount").val() == null){
			$("#enterAmount").val(0);
		}
		let enterAmount = parseInt($("#enterAmount").val());
		let result = Math.floor(enterAmount * nationSearchAnswer / rat);
		const formatted = new Intl.NumberFormat('ko-KR', {
			  style: 'currency',
			  currency: 'KRW'
		}).format(result);
		$("#answer-ipt").val(formatted);
	}
    // 원화 - 환율 - hs 세율 계산기 모달 end
    
    //************** 쳇봇 ************************
    const chatButton = document.getElementById('chatButton');
	const modalOverlay = document.getElementById('modalOverlay');
    const modalOverlayCloseBtn = document.querySelector("#modalOverlay").querySelector(".close-btn");
    
    // 모달 열기
    chatButton.addEventListener('click', () => {
	    closeAllModals();
	    openModal(modalOverlay);
	});
	
	modalOverlayCloseBtn.addEventListener('click', () => {
		modalOverlay.classList.remove('show');
    });
	
	modalOverlay.addEventListener('click', (event) => {
        if (event.target === modalOverlay) {
        	modalOverlay.classList.remove('show');
        }
    });
    
    // OS로 열기 기능
    function openWithOS() {
        window.open("tg://resolve?domain=Border7_bot");
        closeAllModals();
    }
    
    // 웹으로 열기 기능
    function openWithWeb() {
        window.open("https://web.telegram.org/a/#7961528064","_blank");
        closeAllModals();
    }
  	//************** 쳇봇 끝************************
  
	/* const userListBtn = document.getElementById('userListBtn');
	const userListmodal = document.getElementById('userListmodal');
    const userListModalButton = document.getElementById('userListModalButton');
	
	userListBtn.addEventListener('click', () => {
	    closeAllModals();
	    openModal(userListmodal);
	});
	
	userListModalButton.addEventListener('click', () => {
		userListmodal.classList.remove('show');
    });

	document.getElementById('requestConsultantBtn').addEventListener('click', function() {
	    // 사용자 ID (혹은 userNo)와 같은 필요한 정보를 서버로 전송
	    const userId = "${userId}"; // 현재 로그인된 사용자의 ID
	    const requestData = {
	        requesterId: userId,
	        // 추가 정보 (예: 문의 내용 요약, 현재 페이지 URL 등)
	        issue: "결제 오류 발생",
	        pageUrl: window.location.href
	    };

	    // 서버의 REST API 엔드포인트로 요청
	    fetch('/api/consultant/request', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json',
	            // CSRF 토큰 등 보안 헤더 추가
	            // 'X-CSRF-TOKEN': document.querySelector('meta[name="_csrf"]').getAttribute('content')
	        },
	        body: JSON.stringify(requestData)
	    })
	    .then(response => {
	        if (response.ok) {
	            alertify.alert('컨설팅 요청이 접수되었습니다. 담당자가 곧 연락드릴 것입니다.');
	        } else {
	            alertify.alert('컨설팅 요청 실패. 잠시 후 다시 시도해주세요.');
	        }
	    })
	    .catch(error => {
	        console.error('Error requesting consultant:', error);
	        alertify.alert('네트워크 오류가 발생했습니다.');
	    });
	}); */
	
	/** 프로세스모달 **/
    const requestConsultantBtn = document.getElementById('requestConsultantBtn');
	const mainprocess = document.getElementById('mainprocess');
    const mainprocessCloseBtn = document.querySelector("#mainprocess").querySelector(".modal-close-button");
    
	
    
    requestConsultantBtn.addEventListener('click', () => {
	    closeAllModals();
	    openModal(mainprocess);
	});
	
    mainprocessCloseBtn.addEventListener('click', () => {
		mainprocess.classList.remove('show');
    });
	
    mainprocess.addEventListener('click', (event) => {
        if (event.target === mainprocess) {
        	mainprocess.classList.remove('show');
        }
        let getText = mainprocess.querySelector("h3").innerText;
        mainprocess.querySelector("h3").innerText = getText == '수입' ? '수출' : '수입';
        document.querySelector("#mainprocess").querySelector(".process-img").classList.toggle("ex");
    });
	
	/** 프로세스모달 **/
</script>