<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공무원 부서관리 페이지</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<%@ include file="../modules/modal.jsp" %>
<link rel="stylesheet" href="/css/main.css">
</head>
<body>
    <div class="app-container">
        <main class="main-content-area">
        <div class="content-header">
		   <!-- 브레드크럼 엘리먼트 -->
		   <div class="breadcrumb-warp">
		      <div class="col-sm-12">
		         <ol class="breadcrumb">
		         	<li class="breadcrumb-item"><a href="/">Home</a></li>
		            <li class="breadcrumb-item"><a href="/servant/departMng.do">부서 조회</a></li>
		         </ol>
		      </div>
		   </div>
		   <!-- 브레드크럼 엘리먼트 끝 -->
		   <div class="content-title">부서 조회</div>
		   <p class="desc">부서를 조회하고 관리하는 페이지입니다.</p>
		</div>
		<div class="section">
			<div class="card-main">
				<div class="card-left">
				<div class="section-header"><h3>행정지원과</h3></div>
				
				<div class="form-detail-group">
					<label>부서장 : </label>
					<span>행정지원과 부서장</span>
				</div>
				<div class="form-detail-group">
					<label>사원 수 : </label>
					<span>15명</span>
				</div>
				<div class="form-detail-group">
					<label>연락처 : </label>
					<span>15명</span>
				</div>
				<div class="form-detail-group">
					<label>위치 : </label>
					<span>15명</span>
				</div>
				<button type="button" class="btn btn-primary" id="cancelBtn">상세보기</button>
				
				</div>
				<div class="card-right">
				<div class="section-header"><h3>관세청본부</h3></div>
				
				<div class="form-detail-group">
					<label>부서장 : </label>
					<span>관세청본부 부서장</span>
				</div>
				
				</div>
			
		</div>
		</div>
            <%-- 부서 카드들을 감싸는 컨테이너 --%>
            <div class="department-grid-container">
                <div class="department-card">
                    <h4>행정지원과</h4>
                    <p style="color:red;">부서장: 행정지원과 부서장</p>
                    <p style="color:red;">사원 수: 15명</p>
                    <p style="color:red;">연락처: 행정지원과 연락처</p>
                    <p style="color:red;">이메일: 부서장 이메일</p>
                    <p style="color:red;">위치: 위치</p>
                    <button type="button" class="detailBtn">상세보기</button>
                </div>
                <div class="department-card">
                    <h4>관세청본부</h4>
                    <p style="color:red;">부서장: 관세청본부 부서장</p>
                    <p style="color:red;">사원 수: 15명</p>
                    <p style="color:red;">연락처: 관세청본부 연락처</p>
                    <p style="color:red;">이메일: 부서장 이메일</p>
                    <p style="color:red;">위치: 위치</p>
                    <button type="button" class="detailBtn">상세보기</button>
                </div>
                <div class="department-card">
                    <h4>검사검역지원과</h4>
                    <p style="color:red;">부서장: 검사검역지원과 부서장</p>
                    <p style="color:red;">사원 수: 15명</p>
                    <p style="color:red;">연락처: 검사검역지원과 연락처</p>
                    <p style="color:red;">이메일: 부서장 이메일</p>
                    <p style="color:red;">위치: 위치</p>
                    <button type="button" class="detailBtn">상세보기</button>
                </div>
                <div class="department-card">
                    <h4>현장지원과</h4>
                    <p style="color:red;">부서장: 현장지원과 부서장</p>
                    <p style="color:red;">사원 수: 15명</p>
                    <p style="color:red;">연락처: 현장지원과 연락처</p>
                    <p style="color:red;">이메일: 부서장 이메일</p>
                    <p style="color:red;">위치: 위치</p>
                    <button type="button" class="detailBtn">상세보기</button>
                </div>
                <%-- 필요하다면 여기에 더 많은 부서 카드를 추가 --%>
            </div>
        </main>
    </div>


</body>
<script type="text/javascript">
$(function(){
    $(".detailBtn").on("click", function(){
        console.log("상세보기 버튼 클릭됨");
    });
});
</script>
</html>