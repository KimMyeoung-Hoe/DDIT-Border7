<%@page import="kr.or.ddit.vo.UserVO"%>
<%@page import="java.util.List"%>
<%@taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="<%=request.getContextPath() %>/lib/jQuery/jquery-3.7.1.min.js" ></script>
<script type="text/javascript" src="/resources/dist/js/adminlte.min.js"></script>
<!-- alert js, css // start -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
<!-- alert js, css // end -->
<link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">
<link rel="stylesheet" href="/css/header.css">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="icon" href="/favicon/favicon.ico">
<header class="app-header">

<sec:authentication property="principal" var="headerPrinc"/>
<c:if test="${headerPrinc ne 'anonymousUser'}">
	<c:set value="${headerPrinc.user }" var="headerUserVO"></c:set> 
	<sec:authentication property="authorities" var="auth"/>
	<c:set var="headerAuth" value="${auth}" scope="request"/>
	
	<c:set var="userNo" value="${headerPrinc.user.userNo}" />
	<c:set var="authCode" value="${headerPrinc.user.authCode}" />
	<c:set var="userId" value="${headerPrinc.user.userId}" />
	<c:set var="userName" value="${headerPrinc.user.userName}" />
	<c:set var="userTel" value="${headerPrinc.user.userTel}" />
	<c:set var="profileImg" value="${headerPrinc.user.profileImg}" />
	<c:set var="unreadMailCount" value="${headerPrinc.user.unreadMailCount}" />
	<c:set var="setGnbAuthCode">
	    <c:choose>
	    	<c:when test="${authCode == 'ROLE_CONSIGNOR'}">
	            회원
	        </c:when>
	        <c:when test="${authCode == 'ROLE_CCA'}">
	            관세사
	        </c:when>
	        <c:when test="${authCode == 'ROLE_LOGISTICS'}">
	            물류관리자
	        </c:when>
	        <c:when test="${authCode == 'ROLE_SVT_ADMIN'}">
	            공무원(주무관 7급)
	        </c:when>
	        <c:when test="${authCode == 'ROLE_SVT_MANDARIN'}">
	            공무원(서기관 4급)
	        </c:when>
	        <c:otherwise>
	            로그인 필요
	        </c:otherwise>
	    </c:choose>
	</c:set>
</c:if>
    <div class="header-logo" role="button" tabindex="0" onclick="goMyHome()">
        Border7
    </div>
    
    <div class="rollingBanner">
    	<p class="rolling-text">
    		<c:set var="setGnbAuthCodeRolling">
			    <c:choose>
			    	<c:when test="${authCode == 'ROLE_CONSIGNOR'}">
			            화주
			        </c:when>
			        <c:when test="${authCode == 'ROLE_CCA'}">
			            관세사
			        </c:when>
			        <c:when test="${authCode == 'ROLE_LOGISTICS'}">
			            물류관리자
			        </c:when>
			        <c:when test="${authCode == 'ROLE_SVT_ADMIN'}">
			            공무원
			        </c:when>
			        <c:when test="${authCode == 'ROLE_SVT_MANDARIN'}">
			            부서장
			        </c:when>
			    </c:choose>
			</c:set>
            ${setGnbAuthCodeRolling } 
        </p>
    </div>
    <nav class="header-nav">
    
    	<sec:authorize access="hasAnyRole('ROLE_CONSIGNOR', 'ROLE_CCA', 'ROLE_LOGISTICS')">
	        <div class="header-nav-item" role="button" tabindex="0">
		        <a href="/myPage/myMail.do">
		        	메일 (<span id="unreadMailCountDisplay">${headerPrinc.user.unreadMailCount}</span>)
		        </a>
	        </div>
	        <div class="header-profile" role="button" tabindex="0">
	            <div class="header-profile-avatar">
	                <img class="profileImg" src="/myPage/displayFile?fileName=${headerPrinc.user.profileImg}" alt="프로필 사진"
	                	style="width: 40px; height: 40px; border:none; border-radius: 50%;"
	                />
	            </div>
	            <span class="header-profile-name">
	            		${userName } 
	            		<span class="auth">${setGnbAuthCode }님 환영합니다</span>
				</span>
	        </div>
       </sec:authorize>
        <sec:authorize access="hasAnyRole('ROLE_SVT_ADMIN', 'ROLE_SVT_MANDARIN')">
        	<div class="header-nav-item" role="button" tabindex="0">
		        <a href="<%=request.getContextPath()%>/myPage/myMail.do">
		        	메일 (${headerPrinc.user.unreadMailCount})
		        </a>
	        </div>
	        <div class="header-profile" role="button" tabindex="0">
	            <span class="header-profile-name">
	            		${userName } 
	            		<span class="auth">${setGnbAuthCode }님 환영합니다</span>
				</span>
	        </div>
        </sec:authorize>
		<c:choose>
			<c:when test="${empty headerAuth || headerAuth eq 'ROLE_ANONYMOUS'}">
				<button class="header-nav-button login-button " onclick="LoginPage()">로그인페이지</button>
			</c:when>
			<c:otherwise>
				<form action="/logout" method="post">
				    <input type="submit" value="로그아웃" class="header-nav-button login-button" /><br />
				</form>	
			</c:otherwise>
		</c:choose>
    </nav>
</header>
<div class="modal-warp" id="userListmodal">
	<div class="modal-content">
		<div class="modal-header">
		    <h3>현재 접속 중인 사용자</h3>
		    <button class="modal-close-button" id="userListModalButton">×</button>
		</div>
		<div id="onlineUsersContainer">
	        <ul id="onlineUsersList">
	            <li>연결 중...</li>
	        </ul>
	    </div>
	</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script type="text/javascript">
function LoginPage(){
	window.location.href="<%=request.getContextPath()%>/login/loginForm.do";
}
function goMyHome(){
	window.location.href="/";
}

//읽지 않은 메일 수를 업데이트하는 함수
function updateUnreadMailCount() {
    $.ajax({
        url: '<%=request.getContextPath()%>/api/user/mailCount',
        type: 'GET',
        success: function(count) {
            $('#unreadMailCountDisplay').text(count);
        },
        error: function(xhr, status, error) {
            console.error("읽지 않은 메일 수를 가져오는 중 오류 발생:", error);
        }
    });
}

// 페이지 로드 시 바로 업데이트 함수 호출
$(document).ready(function() {
    // 사용자가 로그인한 경우에만 업데이트 로직을 실행합니다.
    <c:if test="${headerPrinc ne 'anonymousUser'}">
        updateUnreadMailCount(); // 페이지 로드 시 한 번 실행
        setInterval(updateUnreadMailCount, 500);
    </c:if>
});
</script>