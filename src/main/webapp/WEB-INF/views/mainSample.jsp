<%@page import="kr.or.ddit.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/main.css">
</head>
<body>
<%@ include file="./modules/header.jsp" %>
<%@ include file="./modules/sidebar.jsp" %>
<%
	String userId = (String)session.getAttribute("userId");
	String authCode = (String)session.getAttribute("auth");
%>
<div class="app-container">
	<main class="main-content-area">
		메인화면입니다.
	</main>
</div>
</body>

</html>