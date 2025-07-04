<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%= request.getContextPath() %>/lib/jQuery/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/main.css">
<style type="text/css">
table, tr, td{
	border: solid 1px white;
}
</style>
</head>
<body>
<%@ include file="../modules/sidebar.jsp" %>
<div class="header">
	<%@ include file="../modules/header.jsp" %>
</div>
<div class="app-container">
	<main class="main-content-area">
	<button id="adminBtn">행정공무원</button>
	<button id="quaranBtn">현장공무원</button>
	<table id="admin">
		<tr>
			<td>번 호</td>
			<td>신고구분</td>
			<td>접수번호</td>
			<td>신청인</td>
			<td>대리인</td>
			<td>접수일시</td>
			<td>현재 절차</td>
			<td>관리</td>
		</tr>
		<tr>
			<td>1</td>
			<td>구분</td>
			<td>번호</td>
			<td>신청인</td>
			<td>대리인</td>
			<td>접수일시</td>
			<td>현재 절차</td>
			<td>
				<a href="/servant/customsDetail.do">관리</a>
			</td>
		<%-- 	<c:forEach items="<%=list %>" var="item" varStatus="vs">
				<c:choose>
				
					<c:when test="${ }">
						<a href="">행정</a>
					</c:when>
					
					<c:when test="${ }">
					</c:when>
					
					<c:otherwise>
					</c:otherwise>
					
				</c:choose>
			</c:forEach> --%>
		</tr>
	</table>
	<table id="quaran" style="display: none;">
		<tr>
			<td>번 호</td>
			<td>물품코드</td>
			<td>접수번호</td>
			<td>검사유형</td>
			<td>신청인</td>
			<td>접수일시</td>
			<td>관리</td>
		</tr>	
		<tr>
			<td>번 호</td>
			<td>물품코드</td>
			<td>접수번호</td>
			<td>검사유형</td>
			<td>신청인</td>
			<td>접수일시</td>
			<td>관리</td>
		</tr>	
	</table>
	</main>
</div>


</body>
<script type="text/javascript">
	let adminBtn = $("#adminBtn");
	let quaranBtn = $("#quaranBtn");
	let admin = $("#admin");
	let quaran = $("#quaran");
	
	adminBtn.on("click", function() {
		admin.css("display", "block"); 
		quaran.css("display", "none"); 
	});
	
	quaranBtn.on("click", function() {
		quaran.css("display", "block"); 
		admin.css("display", "none"); 
	});
	
</script>
</html>