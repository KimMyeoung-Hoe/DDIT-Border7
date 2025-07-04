<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수입신고서</title>
    
    <%@ include file="../modules/header.jsp" %>
	<%@ include file="../modules/sidebar.jsp" %>
    
	<link rel="stylesheet" href="/css/main.css">
	<link rel="stylesheet" href="/css/decl.css">
    <style>
        
    </style>
</head>
<body>
	<script type="text/javascript">
		window.open("/consultantConnect.do?targetKey=${targetKey}",
				"_blank",
		        "width=800,height=1000,scrollbars=yes,resizable=yes");
		setTimeout(function() {
			location.href = "/";
     	}, 2000);
    	
	</script>
</body>
</html>