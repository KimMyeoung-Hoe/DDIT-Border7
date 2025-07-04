<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<%@ include file="../modules/modal.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<% String auth = (String) request.getAttribute("userAuth");%>
<% String authName = null;
if(auth.equals("cca")){
		authName = "관세사";
	}else if(auth.equals("consignor")){
		authName = "화주";
	}else{
		authName = "물류관리자";
	}%>
<style>
/* 이 CSS는 회원가입 폼의 내부 디자인과 배치를 담당합니다.
 * 색상, 폰트 등 전반적인 UI는 main.css와 header/sidebar를 통해 로드되는 
 * Bootstrap 및 공통 CSS에 의해 결정된다고 가정합니다.
 */

/* app-container와 main-content-area는 공통 레이아웃 CSS에 정의되어야 함 */
/* 이 파일에서는 해당 영역의 자식 요소들에 대한 스타일만 정의 */

.form-container-wrapper {
    /* app-container와 main-content-area 내에서 폼을 중앙에 배치하고 배경색 설정 */
    display: flex;
    justify-content: center;
    align-items: center; /* 세로 중앙 정렬 */
    min-height: calc(100vh - 60px); /* 헤더 높이 제외 */
    padding: 20px; /* 컨테이너 자체 패딩 */
    box-sizing: border-box;
}

.regist-form {
    background-color: #FFFFFF; /* 폼 배경색을 흰색으로 (밝은 계열) */
    border-radius: 12px; /* 둥근 모서리 */
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15); /* 부드러운 그림자 */
    padding: 40px; /* 내부 패딩 */
    width: 100%; /* 부모 너비에 맞춤 */
    max-width: 600px; /* 최대 너비 제한 */
    box-sizing: border-box;
    font-weight: normal; /* Bootstrap fw-bold 오버라이드 (필요시) */
}

.regist-form h2 {
    color: #343a40; /* 어두운 글자색 (밝은 폼 배경에 잘 보임) */
    font-weight: 700;
    margin-bottom: 30px;
}

.form-label {
    color: #495057; /* 라벨 글자색 */
    font-weight: 600; /* 라벨 글자를 더 진하게 */
    margin-bottom: 8px; /* 라벨과 인풋 사이 간격 */
}

.form-control, .form-select {
    border-radius: 8px; /* 입력 필드 둥근 모서리 */
    border: 1px solid #ced4da; /* 기본 테두리 색 */
    padding: 10px 15px; /* 패딩 조정 */
}

.form-control:focus, .form-select:focus {
    border-color: #7995ff; /* 포커스 시 링크색과 유사하게 */
    box-shadow: 0 0 0 0.25rem rgba(121, 149, 255, 0.25); /* 포커스 시 그림자 효과 */
}

.input-group .btn-outline-secondary {
    border-radius: 0 8px 8px 0; /* 우측만 둥글게 */
    border-color: #ced4da;
    color: #495057;
    background-color: #e9ecef; /* 약간 밝은 배경 */
    transition: all 0.2s ease;
}

.input-group .btn-outline-secondary:hover {
    background-color: #dee2e6;
    border-color: #adb5bd;
}

/* 폼 텍스트 (알림 메시지 등) */
.form-text {
    font-size: 0.875em;
    margin-top: 5px;
    display: block; /* 줄바꿈을 위해 블록 요소로 */
}
#alram {
    color: #6c757d; /* 회색 계열 */
}
#checkResult1, #checkResult2, #checkpw, #checktel {
    font-weight: bold; /* 결과 메시지 글자를 진하게 */
}
/* 예시: 성공 메시지 */
.text-success { color: #28a745 !important; }
/* 예시: 실패 메시지 */
.text-danger { color: #dc3545 !important; }

/* 회원 유형별 추가 필드 스타일 */
.type-specific-fields {
    margin-top: 30px;
    padding-top: 20px;
    border-top: 1px dashed #dee2e6; /* 점선 구분선 */
    margin-bottom: 30px;
}

/* 회원가입 버튼 */
.btn-primary {
    background-color: #7995ff; /* 링크 색상과 통일 */
    border-color: #7995ff;
    padding: 12px 25px;
    font-size: 1.1rem;
    font-weight: bold;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.btn-primary:hover {
    background-color: #6070e0;
    border-color: #6070e0;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

/* 추가 정보 */
#join {
    display: block;
    margin-top: 20px;
    text-align: center;
    font-weight: bold;
}
</style>
</head>

<body>
	<div class="app-container">
		<main class="main-content-area">
            <%-- 폼 컨테이너 래퍼 (중앙 정렬을 위해 추가) --%>
            <div class="form-container-wrapper">
                <form action="<%=request.getContextPath()%>/register/regist.do" method="post" enctype="multipart/form-data" class="regist-form">
                    <h2 class="text-center mb-4"><%= authName %> 회원가입</h2>
                    <div>
                        <div class="mb-3">
                            <label for="id" class="form-label">아이디</label>
                            <div class="input-group">
                                <input type="text" id="id" name="userId" class="form-control" placeholder="아이디">
                                <button type="button" id="checkId" name="checkId" class="btn btn-outline-secondary">아이디 중복체크</button>
                            </div>
                            <span id="checkResult1" class="form-text"></span>
                        </div>
                        <div class="mb-3">
                            <label for="pw" class="form-label">비밀번호</label><br/>
                            <input type="password" id="pw" name="userPw" class="form-control" placeholder="비밀번호">
                            <span id="checkpw" class="form-text"></span>
                        </div>
                        <div class="mb-3">
                            <label for="pwr" class="form-label">비밀번호 확인</label><br/>
                            <input type="password" id="pwr" name="userPwr" class="form-control" placeholder="비밀번호 확인">
                            <span id="alram" class="form-text">비밀번호는 특수문자 1자 포함(공백은 사용불가), 8자 이상으로 해주셔야 합니다.</span>
                        </div>
                        <div class="mb-3">
                            <label for="name" class="form-label">이름</label><br/>
                            <input type="text" id="name" name="userName" class="form-control" placeholder="이름">
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">이메일</label>
                            <div class="input-group">
                                <input type="text" id="email" name="userEmail" class="form-control" placeholder="이메일">
                            </div>
                            <span id="checkResult2" class="form-text"></span>
                        </div>
                        <div class="mb-3">
                            <label for="tel" class="form-label">전화번호</label><br/>
                            <input type="text" id="tel" name="userTel" class="form-control" placeholder="전화번호">
                            <span id="checktel" class="form-text"></span>
                        </div>
                        <div class="mb-3">
                            <label for="fax" class="form-label">팩스번호</label>
                            <div class="input-group">
                                <input type="text" id="fax" name="userFax" class="form-control" placeholder="팩스번호">
                            </div>
                        </div>
                    </div>
                    <%
                        // 'auth' 값에 따른 추가 필드 포함 로직
                        if(auth == null || auth.trim().isEmpty()){
                    %>
                    <script>
                    	alertify.alert('회원 유형 정보가 올바르지 않습니다. 회원가입 메인 페이지로 돌아갑니다.');
                        window.location.href = '<%=request.getContextPath()%>/register/main.do'; // 수정된 경로
                    </script>
                    <%
                        } else if(auth.equals("consignor")){
                    %>
                    <div class="type-specific-fields">
                    	<%@ include file="consignor.jsp" %>
                    </div>
                    <%
                        } else if(auth.equals("logistics")){
                    %>
                    <div class="type-specific-fields">
                    	<%@ include file="logistics.jsp" %>
                    </div>
                    <%
                        } else if(auth.equals("cca")){
                    %>
                    <div class="type-specific-fields">
                    	<%@ include file="cca.jsp" %>
                    </div>
                    <%
                        }
                    %>
                    <div class="mb-3">
                    	<label for="sms" class="form-label">SMS승인</label>
                    	<input type="hidden" name="smsYn" value="false">
                    	<input type="checkbox" name="smsYn" id="smsYn" value="true" >
                    </div>
               		<div class="g-recaptcha" data-sitekey="6Ld1WU4rAAAAADpYn7AkzgeypD_oCtjKbperHDG6"></div>
               		<br/>
                    <div class="text-center">
                        <button type="button" id="submit" class="btn btn-primary">회원가입</button>
                        <button type="button" onclick="window.location.href='<%=request.getContextPath() %>/register/main.do'" class="btn btn-primary" >유형선택으로</button>
                    </div>
                    <span id="join" class="form-text"></span>
                </form>

            </div>
        </main>
    </div>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>    
<script type="text/javascript">
$(function(){
	const auth = "<%=auth %>";
	var authName = null;
	if(auth == "cca"){
		authName = "관세사 사무소";
	}else if(auth == "consignor"){
		authName = "화주 업체";
	}else{
		authName = "물류관리자 업체";
	}
//--------------------------------------------------------------
	
//--------------------------------------------------------------
	//전송 가입하기 이벤트
	$('#submit').on('click', (e) => {
		 e.preventDefault();
	        grecaptcha.ready(function() {
	          grecaptcha.execute('reCAPTCHA_site_key', {action: 'submit'}).then(function(token) {
	              // Add your logic to submit to your backend server here.
	          });
	        });
		// 폼에 없는 값 선언
		var authCode = "ROLE_<%=auth.toUpperCase()%>";
		// null 또는 빈 값 체크 및 포커스 이동
		if (!$("#id").val()) { alert("아이디를 입력해 주세요."); $('#id').focus(); return; }
		if (!$("#pw").val()) { alert("비밀번호를 입력해 주세요."); $('#pw').focus(); return; }
		if (!$("#name").val()) { alert("이름을 입력해 주세요."); $('#name').focus(); return; }
		if (!$("#email").val()) { alert("이메일을 입력해 주세요."); $('#email').focus(); return; }
		if (!$("#tel").val()) { alert("전화번호를 입력해 주세요."); $('#tel').focus(); return; }
		if (!$("#fax").val()) { alert("팩스번호를 입력해 주세요."); $('#fax').focus(); return; }
		if (!$(`#<%=auth%>Name`).val()) { alert(`${authName}명을 입력해 주세요.`); $(`#<%=auth%>Name`).focus(); return; }
		if (!$("#zipcode").val()) { alert("우편번호를 입력해 주세요."); $('#zipcode').focus(); return; }
		if (!$(`#<%=auth%>DetAddr`).val()) { alert("상세주소를 입력해 주세요."); $(`#<%=auth%>DetAddr`).focus(); return; }
		if (!$(`#<%=auth%>ProfileImg`).val()) {alert("프로필 이미지를 등록 해주세요."); $(`#<%=auth%>ProfileImg`).focus(); return; }				
		
		const formElement = document.querySelector('.regist-form'); // form태그 class
		const formData = new FormData(formElement);
		
		formData.append('authCode',authCode);
		
	    // jQuery AJAX 요청
	    $.ajax({
	        url: '<%=request.getContextPath() %>/register/regist.do', // form의 action과 동일
	        type: 'POST',
	        data: formData, // FormData 객체 직접 전달
	        processData: false, // FormData를 사용할 때는 필수: 데이터가 문자열로 변환되지 않도록
	        contentType: false, // FormData를 사용할 때는 필수: Content-Type 헤더를 설정하지 않도록 (브라우저가 알아서 multipart/form-data로 설정)
	        success: function(response) {
	            // response는 서버에서 보낸 JSON 객체라고 가정 (result, msg 필드)
	            console.log("서버 응답:", response);
	            
	            if (response.result > 0) { // 성공적으로 등록되었을 경우
	                location.href = "<%=request.getContextPath()%>/login/loginForm.do";
	            }
	        },
	        error: function(xhr, status, error) {
	            alert("회원가입 중 오류가 발생했습니다: " + error);
	            console.error("AJAX 오류:", xhr, status, error);
	            // 상세 에러 응답이 JSON이면 파싱해서 보여줄 수도 있음
	            // if (xhr.responseJSON && xhr.responseJSON.msg) {
	            //     alert("오류 상세: " + xhr.responseJSON.msg);
	            // }
	        }
	    });

	});
//----------------------------------------------------------------------------	
// 이메일 양식에 맞는지 확인
  $("#email").on("blur",function validateEmail() {
      var emailInput = document.getElementById('email').value;
      var emailResult = document.getElementById('checkResult2');
      var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

      if (!emailPattern.test(emailInput)) {
          emailResult.style.color = 'red';
          emailResult.innerHTML = '유효한 이메일 형식을 입력해 주세요. 예: example@example.com';
          return false;
      } else {
    	  emailResult.style.color = 'blue';
          emailResult.innerHTML = '이메일 형식입니다!';
          return true;
      }
  });     
//----------------------------------------------------
	// 전화번호 양식에 맞는지 확인 (숫자 추줄) 
	$("#tel").on("blur", function formatPhoneNumber() {
        var telInput = document.getElementById('tel');
        var phoneNumber = telInput.value.replace(/\D/g, ''); // 숫자만 추출

        if (phoneNumber.length === 11) {
            phoneNumber = phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'); // 형식 지정
            telInput.value = phoneNumber;
        	checktel.style.color = 'blue';
	    	checktel.innerHTML = ' 전화번호 형식입니다!';
        } else {
        	checktel.style.color = 'red';
	    	checktel.innerHTML = ' 전화번호형식은 숫자로 11자리 입니다';
           
        }
    })		
	
//---------------------------------------------------------
// 비밀번호 한번더 받아서 일치하는지 확인
  $("#pwr").on("blur",function checkPasswordMatch() {
	  var password = document.getElementById('pw').value;
	    var confirmPassword = document.getElementById('pwr').value;
	    var checkpw = document.getElementById('checkpw'); // 알림을 표시할 요소
	    var passwordCriteria = /^(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$/;

	    if (password !== confirmPassword) {
	        checkpw.style.color = 'red';
	        checkpw.innerHTML = ' 비밀번호가 일치하지 않습니다.';
	    } else if (!passwordCriteria.test(password)) {
	        checkpw.style.color = 'orange';
	        checkpw.innerHTML = ' 비밀번호는 8자리 이상이며 특수문자를 하나 이상 포함해야 합니다.';
	    } else {
	        checkpw.style.color = 'blue';
	        checkpw.innerHTML = ' 비밀번호가 일치합니다.';
	    }
	});
	
//--------------------------------------------------------------
// 아이디 중복확인
	$("#checkId").on("click",function(){
			 //입력한 아이디값 가져오기
			 const userId=$("#id").val();
			 if(userId.length==0){
				 alert("체크할 ID를 입력하세요.");
				 $("#id").focus();
				 return;
			 } 
			 let jsonData = {userId:userId};
			 
			 $.ajax({
				 url : "<%=request.getContextPath() %>/register/idCheck.do",
				 type : "get",
				 contentType : "application/json; charset=utf-8",
				 data : "userId=" + userId,
				 
				 success : function(data){
					 console.log("data",data)
					 if(data == 1){
						$("#checkResult1").html("존재하는 아이디입니다").css("color","red");
					 }else{
						$("#checkResult1").html("회원가입 가능한 아이디입니다").css("color","blue");
					 }
				 },
				 error : function(xhr){
					 alert("오류 상태값 : " + xhr.status);
				 },
				 dataType: "json"
			 });
		 });

//-------------------------------------------------------------------------------
	// 이미지 미리보기 기능
	$(`#<%=auth%>ProfileImg`).on("change", function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $("#imagePreview").attr("src", e.target.result).show();
            };
            reader.readAsDataURL(file);
        } else {
            $("#imagePreview").attr("src", "#").hide();
        }
    });
//--------------------------------------------------------------------------    
	//우편번호검색 이벤트 - 
	$('#zipbtn').on('click', function(){
		// Daum 카카오의 우편번호 검색
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                $("#extraAddress").val(extraAddr);
	            } else {
	            	$("#extraAddress").val('');
	            }
				
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            $("#zipcode").val(data.zonecode);
	            $(`#<%=auth%>Addr`).val(addr);
	            // 커서를 상세주소 필드로 이동한다.
	            $(`#<%=auth%>DetAddr`).focus();
	        }
	    }).open();
	});
//------------------------------------------------------------------
	
});
</script>    
</body>
</html>