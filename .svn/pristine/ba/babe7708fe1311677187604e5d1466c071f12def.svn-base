<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
<%@ include file="../modules/header.jsp"%>
<%@ include file="../modules/sidebar.jsp"%>
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.css">
<sec:authentication property="principal" var="princ" />
<c:if test="${princ ne 'anonymousUser'}">
	<sec:authentication property="principal.user" var="user" />
	<sec:authentication property="authorities" var="auth" />
</c:if>
<style type="text/css">
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
							<li class="breadcrumb-item"><a href="#">공지사항 상세</a></li>
						</ol>
					</div>
				</div>

				<div class="content-title">공지사항 상세</div>
				<p class="desc">공지사항의 상세 내용 입니다.</p>
			</div>


			<div class="section">
				<div class="form-group">
					<label for="faqCategory">제목</label> <input type="text"
						class="form-input" value="${notice.noticeTitle }"
						disabled="disabled">
				</div>
				<div class="form-group">
					<label for="faqSummary">내용</label>
					<div class="form-input" style="height: 300px">
						${notice.noticeContent }</div>
				</div>

				<div class="form-group">
					<label for="faqCategory"> 첨부파일 : </label>
				</div>

				<div>
					<c:if test="${not empty notice.noticeFileList }">
						<c:forEach items="${notice.noticeFileList }" var="noticeFile">
							<div >
							<c:if
								test="${!fn:endsWith(noticeFile.comFileDetailOriginalName, '.pdf')}">
								<span > 
									<img src="/board/display?comFileDetailNo=${noticeFile.comFileDetailNo}">
								</span>
							</c:if>
							
								<span class="mailbox-attachment-size clearfix mt-1"> 
									<span>${noticeFile.comFileDetailOriginalName }</span>
									<span>${noticeFile.comFileDetailSize }</span>
									<c:url value="/board/download.do" var="downloadUrl">
										<c:param name="comFileDetailNo"
											value="${noticeFile.comFileDetailNo }" />
									</c:url> <a href="${downloadUrl }">
										<button>다운로드</button>
								</a>
								</span>
							</div>

						</c:forEach>
					</c:if>
				</div>
				<div class="form-group">
					<label for="faqCategory">조회수 : ${notice.noticeHit }</label>
				</div>
				<div class="form-group">
					<label for="faqCategory">작성일 : ${notice.noticeUpdDate }</label>
				</div>
				<div class="form-group">
					<label for="faqCategory"> ${message}</label>
				</div>
				

				<form action="/board/noticeRemove" method="post" id="noticeForm">
					<input type="hidden" name="noticeNo" value="${notice.noticeNo }" />
				</form>
				<div class="form-buttons" style="float: inline-end">
					<button type="reset" class="btn btn-primary" id="listBtn">목록</button>
					<sec:authorize access="hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')">
						<button type="reset" class="btn btn-primary" id="updateBtn">수정</button>
						<button type="reset" class="btn btn-primary" id="delBtn">삭제</button>
					</sec:authorize>
				</div>
			</div>
		</main>
	</div>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.js"></script>
<script type="text/javascript">
	$(function() {
		let listBtn = $("#listBtn");
		let updateBtn = $("#updateBtn");
		let delBtn = $("#delBtn");
		let noticeForm = $("#noticeForm");

		listBtn.on("click", function() {
			location.href = "/board/noticeList.do";
		})

		updateBtn.on("click", function() {
			noticeForm.attr("action", "/board/noticeUpdate");
			noticeForm.attr("method", "get");
			noticeForm.submit();
		})

		delBtn.on("click", function() {
	
			$.confirm({
				title:'삭제 확인',
				content:'정말 삭제하시겠습니까?',
				buttons:{
					"확인":{
					btnClass: 'btn-primary',
					action:function(){
						noticeForm.submit();
					}
					},
					"아니요":{
						btnClass: 'btn-red',
						function(){
					}
						
					}
				}
			})
			
		})

	})
</script>
</html>