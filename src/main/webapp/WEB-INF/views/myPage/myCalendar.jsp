<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>내 일정</title>
	<%@ include file="../modules/header.jsp" %>
	<%@ include file="../modules/sidebar.jsp" %>
	<%@ include file="../modules/modal.jsp" %>
	<!-- 풀캘린더 API -->
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js" ></script>
	<link rel="stylesheet" href="/css/main.css">
	<!-- confirm 대체 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.js"></script>
	<style>
		/* main css 관련 추가설정 */
		.section{
			backdrop-filter: none; /* 일정 드래그 시 main css와 엮여 이미지 위치가 틀어지는 것을 막기 위한 처리 */
			min-width: 1000px; /* 화면 늘리거나 줄여도 항목명이 줄바꿈 되지 않도록 최소크기 고정 처리 */
		}
		
		/* 모달 */
		#eventModal .modal-content { /* 모달 영역 */
			min-width: 600px;
		}
		.modal-table { /* 테이블 */
			width: 480px;
		}
		.td-s { /* 테이블 첫번째 열 td */
			width: 50px;
			min-width: 50px;
			max-width: 50px;
			text-align: center;
		}
		.td-title,
		.form-input-title { /* 일정 내용 입력 td와 input */
			width: 100%;
		}
		.form-input-color { /* 색상 선택 input */
			height: 40px;
			width: 40px;
			border-radius: 10%;
		}
		.td-date,
		.td-time { /* 테이블 날짜, 시간 열 td */
			width: 50%;
		}
		.tr-btn {
			text-align: center;
		}
		.btn {
			margin-top: 20px;
		}
		
		/* 달력 버튼 설정 */
		.fc .fc-button { /* 전체 버튼 */
			background: none;
			border: none;
			color: #6c757d;
		}
		.fc-icon { /* 좌측의 방향 아이콘 */
			color: #6c757d;
		}
		.fc .fc-today-button { /* 좌측의 오늘 버튼 - 현재 오늘 일정 화면이 아닐 때 */
			background: none;
			border: none;
			color: #6c757d;
			font-weight: bold;
		}
		.fc .fc-today-button:disabled { /* 좌측의 오늘 버튼 - 현재 오늘 일정 화면일 때 */
			background: none;
			border: none;
			color: #0d6efd;
		}
		.fc .fc-button-primary:not(:disabled).fc-button-active { /* 우측 버튼 - 현재 선택한 화면일 때 */
			background: none;
			border: none;
			color: #0d6efd;
			font-weight: bold;
		}
		.fc .fc-button:hover { /* 마우스 올렸을 때 */
  			background-color: #f8f9fa;
  			color: #0d6efd;
		}
		.fc .fc-button:focus { /* 포커스 상태일 때 */
			border: none;
			box-shadow: none;
		}
		:root {
			--fc-button-active-bg-color: #0d6efd; /* 클릭 순간의 버튼 색상 */
			--fc-event-border: white 1px solid;
		}

		/* 달력 요일 행 */
		thead {
			background-color: #3a3a50;
		}
		.fc .fc-col-header-cell-cushion {
			color: #f8f9fa;
		}

		/* 달력 날짜 */
		.fc-day-sun a { color: red; }
		.fc-day-sat a { color: blue; }
		.fc-day-mon a,
		.fc-day-tue a,
		.fc-day-wed a,
		.fc-day-thu a,
		.fc-day-fri a { color: gray; }
		
		/* 달력 일정 */
		a.fc-event {
			height: 25px;
			font-size: 15px;
			align-items: center;
			padding: 0;
			margin: 0;
		}
	</style>
	<sec:authentication property="principal" var="princ"/>
	<% String contextPath = request.getContextPath(); %>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
			<!-- 헤더 영역 -->
			<div class="content-header">
				<!-- 브레드크럼 엘리먼트 -->
				<div class="breadcrumb-warp">
					<div class="col-sm-12">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="/">Home</a></li>
							<li class="breadcrumb-item"><a href="myCalendar.do">내 일정</a></li>
						</ol>
					</div>
				</div>
				<div id="contentTitle" class="content-title">내 일정</div>
				<p id="contentDesc" class="desc">내 관세 업무를 조회하고, 내 개인 업무를 등록합니다.</p>
			</div>
		
			<!-- 본문 - 달력 영역 -->
			<div class="section">
				<div>
					<div id="calendar"></div>
				</div>
			</div>
			
			<!-- 일정 입력 모달창 -->
		    <div class="modal-warp modal" id="eventModal">
		    	<div class="modal-content">
			    	<div class="modal-header">
			            <h3 id="modalTitle">일정 등록</h3>
			            <button class="modal-close-button" id="closeCalcModalButton">×</button>
			        </div>
		            <div class="modal-body">
		            	<input type="hidden" name="userNo" value="${princ.user.userId}"/>
			            <table class="modal-table">
			            	<tr>
			            		<td class="td-s">일정</td>
			            		<td class="td-title"><input type="text" class="form-input form-input-title" name="title" id="title"  placeholder="일정 내용" /></td>
								<td class="td-color"><input type="color" class="form-input-color" name="color" id="color"/></td>
			            	</tr>
			            </table>
			            <table class="modal-table">
			            	<tr>
			            		<td class="td-s"></td>
			            		<td class="td-s td-date">날짜</td>
			            		<td class="td-s td-time">
			            			시간
			            			(종일 <input type="checkbox" name="allYn" id="allYn" checked="checked" onclick="toggleTimes(this)"/> )
			            		</td>
			            	</tr>
			            	<tr>
			            		<td class="td-s">시작</td>
			            		<td class="td-b td-date"><input type="date" class="form-input form-input-date" name="startD" id="startD"/></td>
			            		<td class="td-b td-time"><input type="time" class="form-input form-input-time" name="startT" id="startT" disabled/></td>
			            	</tr>
			            	<tr>
			            		<td class="td-s">종료</td>
			            		<td class="td-b td-date"><input type="date" class="form-input form-input-date" name="endD" id="endD"/></td>
			            		<td class="td-b td-time"><input type="time" class="form-input form-input-time" name="endT" id="endT" disabled/></td>
			            	</tr>
			            	<tr class="tr-btn">
			            		<td colspan="3">
			            			<input type="button" id="insertBtn" class="btn btn-primary btn-c" value="등록"/>
			            			<input type="button" id="deleteBtn" class="btn btn-secondary btn-c" value="삭제" style="display: none;"/>
			            		</td>
			            	</tr>
			            </table>
		            </div>
		        </div>
			</div>
		</main>
	</div>
</body>
<script>

	//모달 시간 input 활성 컨트롤 함수 ----------------------------------------------
	function toggleTimes(allYnCheck) {
		$('#startT')[0].disabled = allYnCheck.checked;
		$('#endT')[0].disabled = allYnCheck.checked;
	}
	
	$(document).ready(function () {
		// 모달 활성 컨트롤 -------------------------------------------------------
 	    let modal = $('#eventModal')[0];

		// 현재 선택된 풀캘린더 이벤트 객체를 저장할 변수 (등록인지 수정/삭제인지 판단)
		let currentEvent = null;
		
	 	// 닫기 버튼 선택 시  모달창 비활성화
	    $('.modal-close-button').on("click", function(){
	    	$('#eventModal').removeClass("show");
	    });
	 	
	 	// 모달 영역 외 선택 시 모달창 비활성화
	 	window.onclick = function(event) {
	 		if (event.target === modal) {
	 			$('#eventModal').removeClass("show");
	        }
	    }
	 	
	    // 달력 ----------------------------------------------------------------
    	let calendarEl = $('#calendar')[0];
    	let calendar = new FullCalendar.Calendar(calendarEl, {
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
	    	editable: true,						// 드래그 및 크기조절 설정
	        selectable: true,					// 드래그 사용여부 설정
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
	                                color: data[i].calendarColor,
	                                groupId: data[i].calendarType,
	                                editable: data[i].calendarType == "border" ? false : true,
	                                textColor: data[i].calendarType == "border" ? 'black' : 'white'
	                            });
	                        }
	                    }
	                }
	            })
	        ],
	    	
	    	// 달력 이벤트 설정 (2) 달력 일정 추가 - 모달창
	    	select: function (arg) { // 일자 선택-드래그 시 발생
	    		currentEvent = null;
	    		$("#insertBtn")[0].value = "등록"
	    		$("#deleteBtn")[0].style.display = "none";
	    		$('#eventModal').addClass("show"); // 일정 입력 모달창 활성화
	    		
	    		// 모달 기본값 --------------------------------------------------------
	    	 	// 모달 기본값 (1) 시작날짜
	    	 	let argStart = arg.start;
	    	 	let startD = $('#startD')[0];
	    		let startYear = argStart.getFullYear();
	    		let startMonth = String(argStart.getMonth() + 1).padStart(2, "0");
	    		let startDay = String(argStart.getDate()).padStart(2, "0");
	    		startD.value = startYear + '-' + startMonth + '-' + startDay;
	    		// 모달 기본값 (2) 종료날짜
	    		let argEnd = arg.end;
	    		argEnd.setDate(argEnd.getDate() - 1);
	    		let endD = $('#endD')[0];
	    		let endYear = argEnd.getFullYear();
	    		let endMonth = String(argEnd.getMonth() + 1).padStart(2, "0");
	    		let endDay = String(argEnd.getDate()).padStart(2, "0");
	    		endD.value = endYear + '-' + endMonth + '-' + endDay;
	    		// 모달 기본값 (3) 일정내용
	    		$("#title")[0].value = "";
	    		// 모달 기본값 (4) all-day
	    		$("#allYn")[0].checked = true;
	    		// 모달 기본값 (5) 시간
	    		$('#startT')[0].value = "00:00:00";
	    		$('#endT')[0].value = "00:00:00";
	    		// 모달 기본값 (6) 지정색
	    		$('#color')[0].value = "#5f70d2";

	            calendar.unselect();
	        },
	        
	        // (3) 달력 일정 수정 기능 - 일정을 드래그하여 이동
	        eventDrop: function(arg) {
	        	let newStartD = arg.event._instance.range.start;
	        	let startYear = newStartD.getFullYear();
	    		let startMonth = String(newStartD.getMonth() + 1).padStart(2, "0");
	    		let startDay = String(newStartD.getDate()).padStart(2, "0");
	        	let startD = arg.event.start;
	        	let startT = startD.toTimeString().split(' ')[0];
	    		startD = startYear + '-' + startMonth + '-' + startDay + " " + startT;
	        	
	    		let newEndD = new Date(arg.event._instance.range.end);
    	        if (!arg.event.allDay) {
    	        	newEndD.setDate(newEndD.getDate() - 1);
    	        }
        		let endYear = newEndD.getFullYear();
        		let endMonth = String(newEndD.getMonth() + 1).padStart(2, "0");
        		let endDay = String(newEndD.getDate()).padStart(2, "0");
        		let endD = arg.event.end;
        		let endT = endD.toTimeString().split(' ')[0];
        		endD = endYear + '-' + endMonth + '-' + endDay + " " + endT;
	        	
	            let event = {
	                id: arg.event.id,
	                title: arg.event.title,
	                start: startD,
	                end: endD,
	                allYn: arg.event.allDay,
	                color: arg.event.backgroundColor
	            };

	            $.ajax({
	                url: '/myPage/calendarUpdate/' + arg.event.id,
	                method: 'PUT',
	                contentType: 'application/json',
	                data: JSON.stringify(event)
	            });
	        },
	        
	     	// (3) 달력 일정 수정 기능 - 일정을 드래그하여 크기 변경
	        eventResize: function(arg) {
	        	let newStartD = arg.event._instance.range.start;
	        	let startYear = newStartD.getFullYear();
	    		let startMonth = String(newStartD.getMonth() + 1).padStart(2, "0");
	    		let startDay = String(newStartD.getDate()).padStart(2, "0");
	        	let startD = arg.event.start;
	        	let startT = startD.toTimeString().split(' ')[0];
	    		startD = startYear + '-' + startMonth + '-' + startDay + " " + startT;
	        	
	    		let newEndD = new Date(arg.event._instance.range.end);
    	        if (!arg.event.allDay) {
    	        	newEndD.setDate(newEndD.getDate() - 1);
    	        }
        		let endYear = newEndD.getFullYear();
        		let endMonth = String(newEndD.getMonth() + 1).padStart(2, "0");
        		let endDay = String(newEndD.getDate()).padStart(2, "0");
        		let endD = arg.event.end;
        		let endT = endD.toTimeString().split(' ')[0];
        		endD = endYear + '-' + endMonth + '-' + endDay + " " + endT;
	        	
	            let event = {
	                id: arg.event.id,
	                title: arg.event.title,
	                start: startD,
	                end: endD,
	                allYn: arg.event.allDay,
	                color: arg.event.backgroundColor
	            };

	            $.ajax({
	                url: '/myPage/calendarUpdate/' + arg.event.id,
	                method: 'PUT',
	                contentType: 'application/json',
	                data: JSON.stringify(event)
	            });
	        },
	        
	        // (4) 달력 일정 수정 기능 - 일정을 클릭하여 상세 변경 및 일정 삭제
	        eventClick: function (arg) { // 일정 클릭 시
	        	currentEvent = arg.event;
	        
	     		if(arg.event.groupId === "border") {
	     			return false;
	     		}
	     		
	        	$('#eventModal').addClass("show");
	        	$("#deleteBtn")[0].style.display = "";
	        	$("#insertBtn")[0].value = "수정";

	    		// 모달 기존값 --------------------------------------------------------
	    	 	// 모달 기존값 (1) 시작날짜
	    	 	let startD = arg.event.start;
	    	 	let startYear = startD.getFullYear();
	        	let startMonth = String(startD.getMonth() + 1).padStart(2, "0");
	        	let startDay = String(startD.getDate()).padStart(2, "0");
	        	startD = startYear + '-' + startMonth + '-' + startDay;
	    	 	$('#startD')[0].value = startD;
	    		// 모달 기존값 (2) 종료날짜
	    		let endD = arg.event.end;
    	        if (arg.event.allDay) {
    	        	endD.setDate(endD.getDate() - 1);
    	        }
        		let endYear = endD.getFullYear();
        		let endMonth = String(endD.getMonth() + 1).padStart(2, "0");
        		let endDay = String(endD.getDate()).padStart(2, "0");
        		endD = endYear + '-' + endMonth + '-' + endDay;
	    		$('#endD')[0].value = endD;
	    		// 모달 기존값 (3) 일정내용
	    		$("#title")[0].value = arg.event.title;
	    		// 모달 기존값 (4) all-day
	    		$("#allYn")[0].checked = arg.event.allDay;
	    		// 모달 기존값 (5) 시간
	    		$('#startT')[0].disabled = arg.event.allDay;
				$('#endT')[0].disabled = arg.event.allDay;
	    		$('#startT')[0].value = arg.event.start.toTimeString().split(' ')[0];
	    		$('#endT')[0].value = arg.event.end.toTimeString().split(' ')[0];
	    		// 모달 기존값 (6) 지정색
	    		$('#color')[0].value = arg.event.backgroundColor;
	    		
	            calendar.unselect();
	        }
    	});
    	calendar.render();
    	
    	// 모달 등록 버튼 클릭 --------------------------------------------------------
     	$('#insertBtn').on('click', function () {
	        // 모달 필수값 입력 확인 (1) 일정내용
	        let title = $("#title")[0].value;
	        if (title == null || title == "") {
	        	alertify.alert("일정 내용을 입력해주세요.");
	        	return;
	        }
	        // 모달 필수값 입력 확인 (2) 시작일
	        let startD = new Date($("#startD")[0].value);
	        if (startD == null || startD == "") {
	        	alertify.alert("시작일을 입력해주세요.");
	        	return;
	        }
	     	// 모달 필수값 입력 확인 (3) allYn이 false일 때의 시작시간
	     	let startT = $("#startT")[0].value;
	     	if (!$("#allYn")[0].checked) {
	     		if (startT == null || startT == "") {
		        	alertify.alert("시작시간을 입력해주세요.");
		        	return;
		        }
	     	}
	        
	     	// 시작일시 값 형식 정리
    		let startYear = startD.getFullYear();
    		let startMonth = String(startD.getMonth() + 1).padStart(2, "0");
    		let startDay = String(startD.getDate()).padStart(2, "0");
    		startD = startYear + '-' + startMonth + '-' + startDay + ' ' + startT;
	     	
	        // 종료일시 값 형식 정리
	        let endD = new Date($("#endD")[0].value);
	        if ($("#allYn")[0].checked) {
	        	endD.setDate(endD.getDate() +1);
	        }
    		let endYear = endD.getFullYear();
    		let endMonth = String(endD.getMonth() + 1).padStart(2, "0");
    		let endDay = String(endD.getDate()).padStart(2, "0");
    		let endT = $("#endT")[0].value;
    		endD = endYear + '-' + endMonth + '-' + endDay + ' ' + endT;
    		
    		// 작성된 모든 값 가져오기
	        let calendarFormData = {
	        	title: $("#title")[0].value,
                start: startD,
                end: endD,
                allYn: $("#allYn")[0].checked,
                color: $("#color")[0].value
	        }
	        
    		// 수정인 경우
	        if (currentEvent) {
	        	$.ajax({
	                url: "/myPage/calendarUpdate/" + currentEvent.id,
	                method: "PUT",
	                data: JSON.stringify(calendarFormData),
	                contentType: 'application/json',
	                success: function() {
	                    // FullCalendar에 직접 이벤트 속성 업데이트
	                    currentEvent.setProp('title', calendarFormData.title);
	                    currentEvent.setStart(calendarFormData.start);
	                    currentEvent.setEnd(calendarFormData.end);
	                    currentEvent.setAllDay(calendarFormData.allYn);
	                    currentEvent.setProp('backgroundColor', calendarFormData.color);
	                    currentEvent.setProp('borderColor', calendarFormData.color);
	                    $('#eventModal').removeClass("show");
	                },
	                error: function() {
	                    alertify.alert("일정 수정 중 오류가 발생했습니다.");
	                }
	            });
	        } else {
	        	$.ajax({
	                url: "/myPage/calendarInsert",
	                method: "POST",
	                dataType: "json",
	                data: JSON.stringify(calendarFormData),
	                contentType: 'application/json',
	                success:function (data){
	                	if(data != null){
	                    	calendar.addEvent({
	                        	id: data.calendarNo,
	                            title: data.calendarTitle,
	                            start: data.calendarStrDate,
	                            end: data.calendarEndDate,
	                            allDay: data.calendarAllYn,
	                            color: data.calendarColor
	                        });
	                    }
	                	$('#eventModal').removeClass("show");
	                },
	                error: function() {
	                    alertify.alert("일정 등록 중 오류가 발생했습니다.");
	                }
	            });
	        }
     	});
    	
     	// 모달 삭제 버튼 클릭 ----------------------------------------------------
     	$('#deleteBtn').on('click', function () {
     		if (!currentEvent) return;
     		
     		$.confirm({
				title: '일정 삭제',
				content: '삭제한 일정은 복구가 불가능합니다.<br/>정말로 삭제하시겠습니까?',
				buttons: {
					"네": function() {
						$.ajax({
		                    type: "DELETE",
		                    url: "/myPage/calendarDelete",
		                    data: {"no" : currentEvent.id},
		                    success: function (data) {
		                        if (data == "success") {
		                            alertify.alert("일정을 삭제했습니다.");
		                            currentEvent.remove();
		                            $('#eventModal').removeClass("show");
		                        }else {
		                            alertify.alert("일정 삭제 중 오류가 발생했습니다.");
		                        }
		                    }
		                });
					},
					"아니요": function() {}
				}
			});
     	});
	});
</script>
</html>