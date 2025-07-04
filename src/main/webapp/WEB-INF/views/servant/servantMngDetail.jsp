<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공무원 계정 상세정보</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<style>
    /* 페이지 전용 스타일 */
    .td-h {
        min-width: 180px;
        max-width: 180px;
        font-weight: bold;
        background-color: #f8f9fa;
    }
    .td-b {
        width: 100%;
        text-align: left; /* 내용 좌측 정렬 */
        padding-left: 15px;
    }
</style>
</head>
<body>
    <div class="app-container">
        <main class="main-content-area">
            <div class="content-header">
                <div class="breadcrumb-warp">
                    <div class="col-sm-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/">Home</a></li>
                            <li class="breadcrumb-item"><a href="/servant/servantMng.do">공무원 계정 관리</a></li>
                            <li class="breadcrumb-item active"><a href="#">계정 상세정보</a></li>
                        </ol>
                    </div>
                </div>
                <div class="content-title">공무원 계정 상세정보</div>
                <p class="desc">선택한 공무원의 상세 정보를 확인합니다.</p>
            </div>
            
            <div class="section">
                <div class="table-section">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th colspan="2">계정 정보</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="td-h">아이디</td>
                                <td class="td-b">${servantInfo.userId}</td>
                            </tr>
                            <tr>
                                <td class="td-h">내부 이메일</td>
                                <td class="td-b">${servantInfo.userId}@border7.kr</td>
                            </tr>
                            <tr>
                                <td class="td-h">가입일자</td>
                                <td class="td-b"><fmt:formatDate value="${servantInfo.regDate}" pattern="yyyy-MM-dd" /></td>
                            </tr>
                            <%-- 계정이 비활성(userStatus == true)일 경우에만 탈퇴일자 행을 표시 --%>
                            <c:if test="${servantInfo.userStatus}">
                                <tr>
                                    <td class="td-h">탈퇴일자</td>
                                    <td class="td-b"><fmt:formatDate value="${servantInfo.withdrawDate}" pattern="yyyy-MM-dd"/></td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="table-section">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th colspan="2">개인 정보</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<tr>
                                <td class="td-h">이름(부서/직급)</td>
                                <td class="td-b">${servantInfo.userName} (${servantInfo.servantVO.deptVO.deptName} / ${servantInfo.servantVO.jobGradeName})</td>
                            </tr>
                            <tr>
                                <td class="td-h">핸드폰번호</td>
                                <td class="td-b">${servantInfo.userTel}</td>
                            </tr>
                            <tr>
                                <td class="td-h">개인 이메일</td>
                                <td class="td-b">${servantInfo.userEmail}</td>
                            </tr>
                            <tr>
                                <td class="td-h">팩스 (선택)</td>
                                <td class="td-b">${servantInfo.userFax}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="btn-container btncr">
                    <button type="button" class="btn btn-primary" id="modifyBtn">수정</button>
                    <button type="button" class="btn btn-secondary" onclick="location.href='<c:url value='/servant/servantMng.do' />'">목록</button>
                </div>
            </div>
        </main>
    </div>
</body>
<script type="text/javascript">
$(function(){
    let modifyBtn = $("#modifyBtn");
    
    modifyBtn.on("click", function(){
        window.location.href = "/servant/servantMngForm.do?userNo=" + ${servantInfo.userNo};
    });
});
</script>
</html>