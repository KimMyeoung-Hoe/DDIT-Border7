<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/contract.css">
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
							<li class="breadcrumb-item"><a href="/">창고</a></li>
							<li class="breadcrumb-item"><a href="/">섹션</a></li>

						</ol>
					</div>
				</div>

				<div class="content-title">대행 계약 목록조회</div>
				<p class="desc">모든 의뢰 상태를 확인하고 관리할 수 있습니다.</p>

			</div>
			
			
			<div id="messagePopup" th:if="${MSG != null}" class="alert alert-success">
			    <div th:text="${MSG}"></div>
			    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
			        <span aria-hidden="true">&times;</span>
			    </button>
			</div>
						
			
			
			<div class="section">
				<div class="search-filter-section">
				    <div class="search-input-wrapper">
				    	<div class="search-input-icon"></div>
				        <input type="text" class="form-input search-input" placeholder="의뢰번호, 제목, 관세사, 국가, 물품 검색">
				    </div>
				    <div class="filter-group">
				        <select class="form-select">
				            <option>모든 상태</option>
				        </select>
				        <select class="form-select">
				            <option>날짜순</option>
				        </select>
				        <button class="btn btn-primary">상태순</button>
				    </div>
				</div>
				
				<div class="table-section">
				    <table class="data-table">
				        <thead>
				            <tr>
				                <th>보세창고 번호</th>
				                <th>섹션 번호</th>
				                <th>사용 여부</th>
				                <th>이력 확인</th>
				          	</tr>
				        </thead>
				        <tbody>
				        	<c:forEach items="${whSectionVO}" var="whSection">
				            	<tr>
					                <td>${whSection.bwhNo}</td>
					                <td>${whSection.whSectionNo}</td>				             
					                <td>${whSection.whSectionYn eq 1 ? "Y" : "N"}</td>
					                <td><button class="whHistory btn btn-primary btn-sm" value ="${whSection.whSectionNo}">이력 조회</button></td> 
				               </tr>
				           </c:forEach>
				        </tbody>
				    </table>
				
				    <div class="table-footer">
				        <div class="pagination">
				            <a href="#">&lt;&lt;</a>
				            <a href="#">&lt;</a>
				            <a href="#">6</a>
				            <a href="#">7</a>
				            <a href="#">8</a>
				            <a href="#" class="active">9</a>
				            <a href="#">10</a>
				            <a href="#">&gt;</a>
				            <a href="#">&gt;&gt;</a>
				        </div>
				        <div class="footer-buttons">
				            <button class="btn btn-secondary">위치보기</button>
				            <input class="btn btn-primary"  value="새 의뢰 신청하기"/>
				        </div>
				    </div>
				</div>
			</div>
			<a href="/contract/declform.do" style="color: #007bff; margin-top: 20px; display: inline-block;">문서작성 페이지(테스트 링크용)</a>
		</main>	
	</div>
</body>
<script type="text/javascript">

		/* $(document).ready(function() {
		    $("#messagePopup").fadeIn('slow').delay(2000).fadeOut('slow');
		  }); */

		$(".whHistory").on("click", function (e) {
			alertify.alert("클릭");
			    let whSectionNo = $(this).attr("value");
			    location.href = "/servant/whSectionHistory.do?whSectionNo="+whSectionNo;
			    
			
		});
</script>
</html>