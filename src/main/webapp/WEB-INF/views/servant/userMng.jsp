<%@page import="kr.or.ddit.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공무원의 이용자 관리 페이지</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
			<div class="content-header">
			   <div class="breadcrumb-warp">
			      <div class="col-sm-12">
			         <ol class="breadcrumb">
			            <li class="breadcrumb-item"><a href="/">Home</a></li>
			            <li class="breadcrumb-item"><a href="/servant/userMng.do">일반이용자 관리</a></li>
			         </ol>
			      </div>
			   </div>
			   <div class="content-title">일반이용자 관리</div>
			   <p class="desc">일반이용자의 계정을 관리하는 페이지입니다.</p>
			</div>
			
			<div class="section">
				<div class="search-filter-section">
				    <div class="filter-group">
				        <select id="searchType" class="form-select">
				            <option value="">검색 타입</option>
				            <option value="userName" ${pagingVO.searchType == 'userName' ? 'selected' : ''}>이름</option>
						    <option value="userEnable" ${pagingVO.searchType == 'userEnable' ? 'selected' : ''}>소속</option>
						    <option value="authCode" ${pagingVO.searchType == 'authCode' ? 'selected' : ''}>회원 유형</option> 
						    <option value="userEmail" ${pagingVO.searchType == 'userEmail' ? 'selected' : ''}>이메일</option>
						    <option value="userTel" ${pagingVO.searchType == 'userTel' ? 'selected' : ''}>연락처</option>
				        </select>
				        <select id="sortColumn" class="form-select">
				            <option value="" ${empty pagingVO.sortColumn ? 'selected' : ''}>정렬 속성</option>
				            <option value="AUTH_CODE" ${pagingVO.sortColumn == 'AUTH_CODE' ? 'selected' : ''}>회원 유형</option>
				            <option value="USER_STATUS" ${pagingVO.sortColumn == 'USER_STATUS' ? 'selected' : ''}>상태</option>
				            <option value="REG_DATE" ${pagingVO.sortColumn == 'REG_DATE' ? 'selected' : ''}>가입일</option>
				        </select>
				    </div>
				    <div class="search-input-wrapper">
				        <div class="search-input-icon"></div>
				        <input type="text" id="searchWord" class="form-input search-input" placeholder="검색, 정렬 조건을 선택하여 검색할 수 있습니다." 
				            value="${pagingVO.searchWord != '' ? pagingVO.searchWord : ''}"
				        />
				    </div>
				    <div class="filter-group">
				    
				        <select id="sortDirection" class="form-select">
				            <option value="" ${empty pagingVO.sortDirection ? 'selected' : ''}>정렬 방향</option>
				            <option value="DESC" ${pagingVO.sortDirection == 'DESC' ? 'selected' : ''}>내림차순</option>
				            <option value="ASC" ${pagingVO.sortDirection == 'ASC' ? 'selected' : ''}>오름차순</option>
				        </select>
				        <button id="searchBtn" class="btn btn-primary">검색</button>
				    </div>
				</div>

				<div class="table-section">
					<table class="data-table">
						<thead>
							<tr>
								<th align="center" width="80">이름</th>
								<th align="center" width="150">회원 유형</th>
								<th align="center" width="150">소속</th>
								<th align="center" width="150">이메일</th>
								<th align="center" width="130">연락처</th>
								<th align="center" width="80">상태</th>
								<th align="center" width="130">가입일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty pagingVO.dataList }">
									<tr>
										<td colspan="7" align="center">조회된 사용자가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${pagingVO.dataList }" var="user">
										<tr>
											<td align="center"><a href="/servant/userMngDetail.do?userNo=${user.userNo }">${user.userName }</a></td>
											<td align="center">
												<c:choose>
													<c:when test="${user.authCode eq 'ROLE_CONSIGNOR' }">화주</c:when>
													<c:when test="${user.authCode eq 'ROLE_CCA' }">관세사</c:when>
													<c:when test="${user.authCode eq 'ROLE_LOGISTICS' }">물류관리자</c:when>
													<c:otherwise>오류! 옳지 않은 회원입니다.</c:otherwise>
												</c:choose>
											</td>
											<td align="center">${user.userEnable }</td>
											<td align="center">${user.userEmail }</td>
											<td align="center">${user.userTel }</td>
											<td align="center">
												<c:choose>
													<c:when test="${user.userStatus eq false}">활성</c:when>
													<c:otherwise>비활성</c:otherwise>
												</c:choose>
											</td>
											<td align="center">
												<fmt:formatDate value="${user.regDate }" pattern="yyyy-MM-dd"/>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<div class="table-footer">
			   		<div class="pagination" id="pagingArea">
				   		${pagingVO.pagingHTML}
					</div>
				</div>
			</div>
		</main>
	</div>
</body>
<script type="text/javascript">
$(function(){
	let baseUrl = "/servant/userMng.do";

	$("#searchBtn").on("click", function() {
		let searchType = $("#searchType").val();
		let searchWord = $("#searchWord").val();
		let sortColumn = $("#sortColumn").val();
		let sortDirection = $("#sortDirection").val();
		
		let url = baseUrl + "?searchType=" + searchType 
						  + "&searchWord=" + searchWord 
						  + "&sortColumn=" + sortColumn 
						  + "&sortDirection=" + sortDirection;
		
		location.href = url;
	});

	$("#searchWord").on("keydown", function(e) {
		if (e.keyCode === 13) {
			$("#searchBtn").click();
		}
	});

	$("#pagingArea").on("click", "a", function(event) {
		event.preventDefault();
		let page = $(this).data("page");
		let searchType = $("#searchType").val();
		let searchWord = $("#searchWord").val();
		let sortColumn = $("#sortColumn").val();
		let sortDirection = $("#sortDirection").val();
		
		let url = baseUrl + "?page=" + page 
						  + "&searchType=" + searchType 
						  + "&searchWord=" + searchWord 
						  + "&sortColumn=" + sortColumn 
						  + "&sortDirection=" + sortDirection;
		
		location.href = url;
	});
});
</script>
</html>