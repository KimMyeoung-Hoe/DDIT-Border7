<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 상세</title>
<%@ include file="../modules/header.jsp"%>
<%@ include file="../modules/sidebar.jsp"%>
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.css">
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
							<li class="breadcrumb-item"><a href="/board/faqList.do">자주 찾는 질문(FAQ)</a></li>
							<li class="breadcrumb-item"><a href="#">자주 찾는 질문(FAQ) 상세</a></li>
						</ol>
					</div>
				</div>

				<div class="content-title">자주 찾는 질문(FAQ) 상세</div>
				<p class="desc">자주 찾는 질문의 상세 내용입니다.</p>
			</div>

			<div class="dashboard-section section">

				<div class="form-group">
					<label for="faqCategory">카테고리</label> <input type="text"
						class="form-input" value="${faqVo.faqCategory }"
						disabled="disabled">
				</div>

				<div class="form-group">
					<label for="faqSummary">답변 요약</label> <input type="text"
						class="form-input" value="${faqVo.faqSummary }"
						disabled="disabled">
				</div>



				<div class="form-group">
					<label for="faqTitle">질문 (Q)</label> <input type="text"
						class="form-input" value="${faqVo.faqTitle }" disabled="disabled">
				</div>

				<div class="form-group">
					<label for="faqContent">답변 (A)</label>
					<textarea class="form-input" rows="10" disabled="disabled">${faqVo.faqContent }</textarea>
				</div>

				<div class="form-group">
					<label for="faqTypeInput">FAQ 타입</label>
					<div class="badge-container form-input" id="keywordBadges">
						${faqVo.faqType }</div>

				</div>
				<form action="/board/faqRemove" method="post" id="faqForm">
					<input type="hidden" name="faqNo" value="${faqVo.faqNo }"/>
				</form>
				<div class="form-buttons" style="float: inline-end">
					<button type="reset" class="btn btn-primary" id="listBtn">목록</button>
					<button type="reset" class="btn btn-primary" id="updateBtn">수정</button>
					<button type="reset" class="btn btn-primary" id="delBtn">삭제</button>
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
		let faqForm = $("#faqForm");

		listBtn.on("click", function() {
			location.href = "/board/faqList.do";
		})

		updateBtn.on("click", function() {
			faqForm.attr("action","/board/modify");
			faqForm.attr("method","get");
			faqForm.submit();
		})

		delBtn.on("click", function() {
			
			$.confirm({
				title:'삭제 확인',
				content:'정말 삭제하시겠습니까?',
				buttons:{
					"확인":{
					btnClass: 'btn-primary',
					action:function(){
						faqForm.submit();
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