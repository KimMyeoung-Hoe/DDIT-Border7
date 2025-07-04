<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<%@ include file="../modules/modal.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/departMng.css">
<title>공무원 부서관리 페이지</title>
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
					
						</ol>
					</div>
				</div>
				
			<div class="content-title">보세창고 화물 내역</div>
			<p class="desc">모든 의뢰 상태를 확인하고 관리할 수 있습니다.</p>
        </div>
        
        
            <div class="page-title-header">창고 관리 / 이력</div>

            <h3 class="department-section-title">부서 목록</h3>
            <hr class="section-divider"/>

            <%-- 부서 카드들을 감싸는 컨테이너 --%>
            <div class="department-grid-container">
             <c:forEach items="${bwhList}" var="bwh">
                <div class="department-card">
                    <h4>창고 번호 : ${bwh.bwhNo} </h4>
                    <p style="color:red;">창고 부호: ${bwh.bwhCd}</p>
                    <p style="color:red;">창고 사이즈 : ${bwh.bwhSize}</p>
                    <p style="color:red;">폐기 여부 :${bwh.bwhDispYn eq 1 ? 'Y' : 'N'} </p>
                    <p style="color:red;">타입 : ${bwh.bwhType}</p>
                    <button type="button" class="whSection" value = "${bwh.bwhNo}">상세보기</button>
                </div>
                </c:forEach>
                <%-- 필요하다면 여기에 더 많은 부서 카드를 추가 --%>
            </div>
        </main>
    </div>
    
	</body>
	
	
	<script type="text/javascript">
		/* $(".section-table").hide(); */
		 
		$(".whSection").on("click", function (e) {

			    let bwhNo = $(this).attr("value");
			    location.href = "/servant/whSection.do?bwhNo="+bwhNo;
			    
			
		});
	</script>
</html>