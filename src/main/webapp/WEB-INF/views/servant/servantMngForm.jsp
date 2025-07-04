<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공무원 계정 수정</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<style>
    .td-h {
        min-width: 180px;
        max-width: 180px;
        font-weight: bold;
        background-color: #f8f9fa;
    }
    .td-b {
        width: 100%;
        text-align: left;
        padding-left: 10px;
    }
    .form-control[readonly] {
        background-color: #e9ecef; /* 읽기 전용 필드 배경색 */
        border: none;
    }
    .form-select {
    	height: auto;
    	padding: .375rem .75rem;
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
                            <li class="breadcrumb-item active"><a href="#">계정 정보 수정</a></li>
                        </ol>
                    </div>
                </div>
                <div class="content-title">공무원 계정 정보 수정</div>
                <p class="desc">선택한 공무원의 정보를 수정합니다.</p>
            </div>
            
            <div class="section">
                <form id="servantEditForm" method="post" action="/servant/servantMngUpdate.do">
                	<input type="hidden" name="userNo" value="${servantInfo.userNo}" />
                    
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
                                <c:choose>
                                    <%-- 계정이 활성 상태일 때 --%>
                                    <c:when test="${!servantInfo.userStatus}">
                                        <tr>
                                            <td class="td-h">계정 상태</td>
                                            <td class="td-b">
                                                <select name="userStatus" class="form-select" style="width:120px;">
                                                    <option value="false" selected>활성</option>
                                                    <option value="true">비활성</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <%-- 계정이 비활성(탈퇴) 상태일 때 --%>
                                    <c:otherwise>
                                        <tr>
                                            <td class="td-h">탈퇴일자</td>
                                            <td class="td-b"><fmt:formatDate value="${servantInfo.withdrawDate}" pattern="yyyy-MM-dd"/></td>
                                        </tr>
                                         <tr>
                                            <td class="td-h">계정 상태</td>
                                            <td class="td-b">
                                                <select name="userStatus" class="form-select" style="width:120px;">
                                                    <option value="false">활성</option>
                                                    <option value="true" selected>비활성</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
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
                                    <td class="td-b">
                                        ${servantInfo.userName} (${servantInfo.servantVO.deptVO.deptName} / ${servantInfo.servantVO.jobGradeName})
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td-h">핸드폰번호</td>
                                    <td class="td-b">
                                        <input type="text" name="userTel" class="form-control" value="${servantInfo.userTel}" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td-h">개인 이메일</td>
                                    <td class="td-b">
                                        <input type="email" name="userEmail" class="form-control" value="${servantInfo.userEmail}" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td-h">팩스 (선택)</td>
                                    <td class="td-b">
                                        <input type="text" name="userFax" class="form-control" value="${servantInfo.userFax}" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="btn-container btncr">
                        <button type="button" class="btn btn-primary" id="saveBtn">저장</button>
                        <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</body>
<script type="text/javascript">
$(function(){
    $("#saveBtn").on("click", function(){
        if(confirm("수정된 내용을 저장하시겠습니까?")) {
            $("#servantEditForm").submit();
        }
    });
});
</script>
</html>