<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<%@ include file="../modules/modal.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<sec:authentication property="principal" var="princ"/>
<c:set value="${princ.user }" var="userVO"></c:set>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
		   <!-- 브레드크럼 엘리먼트 -->
			<div class="content-header">
			   <div class="breadcrumb-warp">
			      <div class="col-sm-12">
			         <ol class="breadcrumb">
			            <li class="breadcrumb-item"><a href="/">Home</a></li>
			            <li class="breadcrumb-item"><a href="/statistics/logistics.do">통계지원</a></li>
			         </ol>
			      </div>
			   </div>
			   <div class="content-title">통계지원</div>
			   <p class="desc" style="font-size: small;">통계 지원 페이지입니다 <br/> 각 조건을 선택하면 통계를 확인할수 있습니다.</p>
			</div>
			<!-- 브레드크럼 엘리먼트 끝 -->
			<div class="section">
				<div class="card-main">
					<div class="card-left">
						<div class="info-row">
							<span class="card-title"><a >HS-CODE의 카테고리별 통계</a></span>
						</div>
						<c:out value="${myStatistics }"></c:out>
						<c:out value="${allStatistics }"></c:out>
						<div class="info-row">
							<span class="card-title"><a></a></span>
						</div>
						<div class="info-row">
							<span class="card-title"><a>xx통계</a></span>
						</div>
						<div class="info-row">
							<span class="card-title"><a>xx통계</a></span>
						</div>
						<div class="info-row">
							<span class="card-title"><a>xx통계</a></span>
						</div>
					</div>
					
					<div class="card-right">
						<canvas id="myChart" width="500" height="400"></canvas>
					</div>
				</div>
			</div>
		</main>
	</div>
<script>
  const ctx = document.getElementById('myChart');

  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
      datasets: [{
        label: '# of Votes',
        data: [12, 19, 3, 5, 2, 3],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
</script>	
</body>
</html>