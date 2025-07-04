<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 리스트</title>
<%@ include file="../modules/header.jsp"%>
<%@ include file="../modules/sidebar.jsp"%>
<link rel="stylesheet" href="/css/main.css">
<sec:authentication property="principal" var="princ" />
<c:if test="${princ ne 'anonymousUser'}">
	<sec:authentication property="principal.user" var="user" />
	<sec:authentication property="authorities" var="auth" />
</c:if>
<style type="text/css">
.support-tabs {
	position: relative;
}
.tab-item-btn {
	position: absolute;
	right: 0;
	top: 0;
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
							<li class="breadcrumb-item"><a href="/board/noticeList.do">공지사항</a></li>
						</ol>
					</div>
				</div>

				<div class="content-title">공지사항</div>
				<p class="desc">공지사항을 조회할 수 있습니다.</p>
			</div>
			<div class="section">
				<div class="support-tabs">
					<div class="tab-item active" data-tab="notice">
						<i class="fas fa-bullhorn tab-icon"></i> 공지사항
					</div>
					<div class="tab-item" data-tab="faq">
						<i class="fas fa-question-circle tab-icon"></i><span id="goFaqBtn">자주 찾는 질문 (FAQ)</span> 
					</div>
					<div class="tab-item" data-tab="appeal">
						<i class="fas fa-bullhorn tab-icon"></i> <span id="goClaimBtn">민원</span>
					</div>
					<div class="form-group">
					<label for="faqCategory"> ${message}</label>
					</div>
					<sec:authorize access="hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')">
					<!--"hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')"  -->
						<div class="tab-item-btn">
							<button class="btn btn-primary" id="registerBtn">공지 등록</button>
						</div>
					</sec:authorize>
				</div>
				<form method="post" id="searchForm">
					<div class="search-filter-section">
						<div class="search-input-wrapper">
							<div class="search-input-icon"></div>
							<input type="hidden" name="page" id="page" /> <input type="text"
								class="form-input search-input" placeholder="공지사항 검색"
								name="searchWord" value="${searchWord }">
						</div>
						<div class="filter-group">
							<button class="btn btn-light" style="border: 1px solid;">검색</button>
						</div>
					</div>
				</form>


				<div class="table-container">
					<table class="data-table">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일자</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:set value="${pageVo.dataList }" var="notice" />
							<c:forEach items="${notice }" var="no" varStatus="status">
								<tr>
									<td>${(pageVo.totalRecord + 1) - no.rnum}</td>
									<td ><a href="/board/noticeDetail/${no.noticeNo }">${no.noticeTitle}</a></td>
									<c:if test="${empty no.updServantName }">
										<td >${no.regServantName}</td>
									</c:if>
									<c:if test="${!empty no.updServantName}">
										<td >${no.updServantName}</td>
									</c:if>
									<fmt:parseDate value="${no.noticeRegDate }" pattern="yyyy-MM-dd" var="parseDate"/>
									<td><fmt:formatDate value="${parseDate }" pattern="yyyy-MM-dd"/></td>
									<td>${no.noticeHit}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="table-footer">
					<div class="pagination" id="pagingArea">${pageVo.pagingHTML}</div>
				</div>
			</div>
		</main>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm");
		let registerBtn = $("#registerBtn");
		let goFaqBtn = $("#goFaqBtn");
		let goClaimBtn = $("#goClaimBtn");
		
		pagingArea.on("click","a",function(e){
			e.preventDefault();
			let pageNo = $(this).data("page");
			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		})
		
		registerBtn.on("click",function(){
			location.href = "/board/noticeform.do";
		})
		
		goFaqBtn.on("click",function(){
			location.href = "/board/faqList.do";
		})
		
		goClaimBtn.on("click",function(){
			console.log("민원 클릭");
			location.href = "/board/appealList.do";
		})
		
		
	})
</script>
</html>