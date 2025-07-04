<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>세금고지서</title>
	<%@ include file="../modules/header.jsp" %>
	<%@ include file="../modules/sidebar.jsp" %>
	<link rel="stylesheet" href="/css/main.css">
	<style>
		
	</style>
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
							<li class="breadcrumb-item"><a href="/">내 접수내역</a></li>
							<li class="breadcrumb-item"><a href="/">의뢰 진행 상세</a></li>
							<li class="breadcrumb-item"><a href="/">세금고지서</a></li>
						</ol>
					</div>
				</div>
				<div id="contentTitle" class="content-title">세금고지서</div>
				<p id="contentDesc" class="desc">세금고지서를 확인하고, 납부를 진행합니다.</p>
			</div>
			
			<!--  본문 영역 시작 -->
			<div class="section">
				결제 완료
				<div class="btn-container">
					<input type="button" class="btn btn-primary btn-c" id="taxSaveBtn" value="결제완료" />
				</div>
			</div>
		</main>
	</div>
</body>

<script>
	$(document).ready(function () {
		
	});
</script>
</html>