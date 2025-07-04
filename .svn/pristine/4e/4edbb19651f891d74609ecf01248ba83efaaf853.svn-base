<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<%@ include file="../modules/header.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/customs.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<style type="text/css">
.login-section-2nd{
   display: flex;
   height:100%;
}
.login-section-2nd > div{
   width: 50%;
}
.login-section-2nd > .login-section-l{
   display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap:30px;
   padding: 25px;
}

.main-content-area.main-loginForm{
   display: flex;
   max-width: 100%;
   padding: 0;
}
.section.section-loginForm{
    text-align: center;
    width: 70%;
    min-width: 600px;
}
.main-loginForm .logo-wrap{
   display: flex;
    align-items: center;
    justify-content: center;
}
.main-loginForm .logo{
   background: url(/img/border.png) center top no-repeat;
    width: 272px;
    height: 332px;
    border-radius: 20px;
    cursor: pointer;
}
.autovalbtn-flex{
   display: flex;
    flex-direction: column;
    gap: 10px;
    align-items: flex-end;
}


.swiper {
  width: 100%;
  height: 100%;
}

.swiper-slide {
  text-align: center;
  font-size: 18px;
  background: #444;
  display: flex;
  justify-content: center;
  align-items: center;
}

.swiper-slide img {
  display: block;
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.autovalbtn.autovalbtn-c{
   right: 50%;
}
.section-header > .btn-container{
	margin: 0;
}
.section-header > .btn-container > .btn{
	width:max-content;
}
.login-wrap{
	display: flex;
    justify-content: center;
    gap: 20px;
}
.login-ipt-wrap label{
	width: 100px;
}
.loginBtn{
	height: 100%;
}
</style>
</head>
<body>
<c:remove var="loginErrorType" scope="session" />
<div class="app-container">
   <main class="main-content-area main-loginForm">
      
      <!-- content-body -->
      <c:if test="${not empty sessionScope.loginError}">
          <div class="alert alert-danger mt-3" role="alert">
              ${sessionScope.loginError}
          </div>
          <c:remove var="loginError" scope="session" />
      </c:if>
      <div class="login-section-2nd">
         <div class="login-section-l">
            <div class="logo-wrap">
               <div class="logo"></div>
            </div>
            <div class="section section-loginForm">
				<div class="section-header">
					<h3 class="section-title">로그인</h3>
					<div class="btn-container">
	                  <input type="button" id="registerBtn" class="btn btn-primary btn-sm" value="회원가입" onclick="location.href='/register/main.do'" />
	                  <input type="button" id="findIDBtn" class="btn btn-primary btn-sm" value="아이디 찾기" />
	                  <input type="button" id="findPWBtn" class="btn btn-primary btn-sm" value="비밀번호 찾기" />
	               </div> 
                </div>
				<form id="loginForm" action="/login" method="post">
					<div class="login-wrap">
						<div class="login-ipt-wrap">
                  			<div>
								<label for="userId">ID : </label>
		                     	<input type="text" id="userId" name="username" placeholder="id">
							</div>
							<div>
		                     	<label for="userPw">PW : </label>
		                     	<input type="password" id="userPw" name="password" placeholder="password">
	                     	</div>
                  		</div> 
                     	<div>
	                     	<input class="btn btn-primary btn-sm loginBtn" type="submit" value="로그인" />
	                     </div>
                  	</div>
               </form>
               
            </div>
         </div>
         
         <div>
            <div class="swiper mySwiper">
               <div class="swiper-wrapper">
                  <div class="swiper-slide"> <img alt="" src="/img/port1.jpg"> </div>
                  <div class="swiper-slide"> <img alt="" src="/img/port2.jpg"> </div>
                  <div class="swiper-slide"> <img alt="" src="/img/port3.jpg"> </div>
                </div>
            </div>
         </div>
         
      
      </div>
      
      <!-- content-body -->
      
      
      <div class="autovalbtn autovalbtn-c" style="padding: 10px; margin: 0px;">
         <h4 style="color: black;">시연용 로그인 </h4>
         <div class="autovalbtn-flex">
            <button id="consigLogin" class="btn btn-success btn-sm"> 화주</button>
            <button id="ccaLogin" class="btn btn-success btn-sm"> 관세사 </button>
            <button id="logiLogin" class="btn btn-success btn-sm"> 물류관리자</button>
            <button id="svtLogin" class="btn btn-success btn-sm"> 공무원 </button>
            <button id="mandarinLogin" class="btn btn-success btn-sm"> 부서장 </button>
         </div>
      </div>
   </main>
</div>
<!-- 아이디 찾기 모달 -->
     <div class="modal fade" id="findIDModal" tabindex="-1" aria-labelledby="findIDModalLabel">
   <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="findIDModalLabel">아이디 찾기</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
         </div>
         <div class="modal-body">
            <label for="id_user_name">이름 입력</label>
            <input type="text" id="id_user_name" class="form-control"><br>
            
            <label for="id_user_email">이메일 입력</label>
            <input type="email" id="id_user_email" class="form-control"><br>
            
            <button id="checkId" class="btn btn-primary">확인하기</button>
         </div>
         <div class="modal-footer" id="idAnswer" style="display: none;">
            <label for="originalId">아이디</label>
            <input type="text" id="originalId" class="form-control" readonly><br>
         </div>
      </div>
   </div>
</div>
   <!-- 아이디 찾기 모달 -->

<!-- 비밀번호 찾기 모달 -->
<div class="modal fade" id="findPWModal" tabindex="-1" aria-labelledby="findPWModalLabel">
   <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="findPWModalLabel">비밀번호 찾기</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
         </div>
         <div class="modal-body">
            <label for="pw_user_id">아이디 입력</label>
            <input type="text" id="pw_user_id" class="form-control"><br>
            
            <label for="pw_user_name">이름 입력</label>
            <input type="text" id="pw_user_name" class="form-control"><br>
            
            <label for="pw_user_email">이메일 입력</label>
            <input type="email" id="pw_user_email" class="form-control"><br>
            
            <button id="checkPw" class="btn btn-primary">확인하기</button>
         </div>
         <div class="modal-footer" id="pwAnswer" style="display: none;">
            <label for="changePW">변경할 비밀번호 입력</label>
            <input type="password" id="changePW" class="form-control"><br>
            
            <label for="changePWCheck">비밀번호 확인</label>
            <input type="password" id="changePWCheck" class="form-control"><br>
            
            <button id="changePWBtn" class="btn btn-success">비밀번호 변경하기</button>
         </div>
      </div>
   </div>
</div>
<!-- 비밀번호 찾기 모달 -->
</body>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script type="text/javascript">
$(function() {
    let findIDBtn = $("#findIDBtn");
    let findPWBtn = $("#findPWBtn");
    
    let checkId = $("#checkId");
    let checkPw = $("#checkPw");
    let changePWBtn = $("#changePWBtn");
    
    let consigLogin = $("#consigLogin");
    let ccaLogin = $("#ccaLogin");
    let logiLogin = $("#logiLogin");
    let svtLogin = $("#svtLogin");
    let mandarinLogin = $("#mandarinLogin");
    let con1234Login = $("#con1234");
    
    /* 테스트 로그인 시작 */
    consigLogin.on("click", function() {
       $("#userId").val("consignor_test007");
        $("#userPw").val(1234);;
        $("#loginForm").submit();
        
    });
    ccaLogin.on("click", function() {
       $("#userId").val("cca_test487");
        $("#userPw").val(1234);;
        $("#loginForm").submit();
    });
    logiLogin.on("click", function() {
       $("#userId").val("log");
        $("#userPw").val(1234);;
        $("#loginForm").submit();
    });
    svtLogin.on("click", function() {
       $("#userId").val("E00101");
        $("#userPw").val(1234);;
        $("#loginForm").submit();
    });
    mandarinLogin.on("click", function() {
       $("#userId").val("E00001");
        $("#userPw").val(1234);;
        $("#loginForm").submit();
    });

    /* 테스트 로그인 끝 */
    
    findIDBtn.on("click", function() {
       $("#id_user_name").val(null);
       $("#id_user_email").val(null);
       
       $("#id_user_name").prop("readonly", false);
        $("#id_user_email").prop("readonly", false);
        
        $("#idAnswer").css("display", "none"); 
        $("#findIDModal").css("display", "none"); 
        
        $("#findIDModal").modal("show");
    });
    findPWBtn.on("click", function() {
       $("#pw_user_id").val(null);
        $("#pw_user_name").val(null);;
        $("#pw_user_email").val(null);
        
       $("#pw_user_id").prop("readonly", false);
        $("#pw_user_name").prop("readonly", false);
        $("#pw_user_email").prop("readonly", false);
        
        $("#pwAnswer").css("display", "none"); 
        $("#findPWModal").css("display", "none"); 
        
        $("#findPWModal").modal("show");
    });
    
    checkId.on("click", function() {
       let userName = $("#id_user_name").val().trim();
        let userEmail = $("#id_user_email").val().trim();
           
       if (!userName) {
    	   alertify.alert("이름을 입력해주세요.");
               return;
           }
        if (!userEmail) {
        	alertify.alert("이메일을 입력해주세요.");
            return;
        }
        $.ajax({
            url: "/login/findid.do",
         type: "POST",
            data: JSON.stringify({
                userName: userName,
                userEmail: userEmail
            }),
         contentType: "application/json; charset=utf-8",
         beforeSend: function() {
            $("#id_user_name").prop("readonly", true);
                $("#id_user_email").prop("readonly", true);
            },
            success: function(result) {
              $("#idAnswer").css("display", "block"); 
              $("#originalId").val(result)
             },
              error: function(xhr, status, error) {
               console.error("오류 발생:", error);
               alertify.alert( "잘못된 정보 입니다. ", error);
               $("#id_user_name").prop("readonly", false);
               $("#id_user_email").prop("readonly", false);
              }
        })
    });
    
    checkPw.on("click", function() {
       let userId = $("#pw_user_id").val().trim();
      let userName = $("#pw_user_name").val().trim();
      let userEmail = $("#pw_user_email").val().trim();
        if (!userId) {
        	alertify.alert("아이디를 입력해주세요.");
            return;
        }
        if (!userName) {
        	alertify.alert("이름을 입력해주세요.");
            return;
        }
        if (!userEmail) {
        	alertify.alert("이메일을 입력해주세요.");
            return;
        }

       $.ajax({
         url: "/login/findpw.do",
         type: "POST",
         data: JSON.stringify({
            userId: userId,
            userName: userName,
            userEmail: userEmail
         }),
         contentType: "application/json; charset=utf-8",
         beforeSend: function() {
            $("#pw_user_id").prop("readonly", true);
                $("#pw_user_name").prop("readonly", true);
                $("#pw_user_email").prop("readonly", true);
            },
         success: function(result) {
              if(result == "1"){
                 console.log("비밀번호 변경 폼 출력")
                 $("#pwAnswer").css("display", "block"); 
              }
             },
             error: function(xhr, status, error) {
              console.log("오류 발생:", error);
              alertify.alert(error);
                 $("#pw_user_id").prop("readonly", false);
                $("#pw_user_name").prop("readonly", false);
                $("#pw_user_email").prop("readonly", false);
             }
       })
    });
    
    changePWBtn.on("click", function() {
       let userId = $("#pw_user_id").val().trim();
       let changePW = $("#changePW").val().trim();
        let changePWCheck = $("#changePWCheck").val().trim();
           
       if (!changePW) {
    	   alertify.alert("비밀번호를 입력해주세요.");
               return;
           }
        if (!changePWCheck) {
        	alertify.alert("비밀번호 확인을 입력해주세요.");
            return;
        }
        if (changePW!=changePWCheck) {
        	alertify.alert("비밀번호 확인의 값이 일치 하지않습니다.");
            return;
        }
        
        $.ajax({
            url: "/login/changepw.do",
         type: "POST",
            data: JSON.stringify({
               userId: userId,
               userPw: changePW
            }),
         contentType: "application/json; charset=utf-8",
            success: function(result) {
               console.log(result);
               alertify.alert("비밀번호 변경 완료");
               location.href = "/login/loginForm.do";
             },
              error: function(xhr, status, error) {
               console.error("오류 발생:", error);
               alertify.alert("비밀번호 변경 실패" + error);
              }
        })
    });
    
    var swiper = new Swiper(".mySwiper", {
       autoplay: {
          delay: 2500,
          disableOnInteraction: false,
        },
    });
    $(".main-loginForm .logo").on("click",function(){
    	location.href="/"
    });
});
</script>
</html>