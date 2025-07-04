<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통관의뢰 등록 리스트</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/contract.css">
<link rel="stylesheet" href="/css/contractlist.css">
<style type="text/css">
</style>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">			
			<div class="page-header">
			    <h1 class="page-title">내 의뢰 현황</h1>
			    <p class="page-description">모든 의뢰 상태를 확인하고 관리할 수 있습니다.</p>
			</div>
			
			<div class="search-filter-section">
			    <div class="search-input-wrapper">
			        <input type="text" class="form-input search-input" placeholder="의뢰번호, 제목, 관세사, 국가, 물품 검색">
			    </div>
			    <div class="filter-group">
			        <select class="form-select filter-select">
			            <option>모든 상태</option>
			        </select>
			        <select class="form-select filter-select">
			            <option>날짜순</option>
			        </select>
			        <button class="action-button primary">상태순</button>
			    </div>
			</div>
			
			<div class="dashboard-section table-section">
			    <table class="data-table">
			        <thead>
			            <tr>
			                <th>의뢰 번호</th>
			                <th>의뢰 내용</th>
			                <th>담당 관세사</th>
			                <th>상태</th>
			                <th>등록일</th>
			                <th>최근 업데이트</th>
			                <th>선택</th>
			                <th>작업</th>
			            </tr>
			        </thead>
			        <tbody>
			            <tr>
			                <td>REQ-2025-0042</td>
			                <td>전자제품 수입통관<br>수입 | 중국 | 전자제품</td>
			                <td class="link-text">김관세</td>
			                <td><span class="status-badge progress">진행중</span></td>
			                <td>2025-05-10</td>
			                <td>2025-05-11</td>
			                <td></td>
			                <td><button class="icon-button">다운로드</button></td> </tr>
			            <tr>
			                <td>REQ-2025-0038</td>
			                <td>의류 수출통관<br>수입 | 베트남 | 의류</td>
			                <td class="link-text">이동관</td>
			                <td><span class="status-badge received">접수완료</span></td>
			                <td>2025-05-08</td>
			                <td>2025-05-09</td>
			                <td></td>
			                <td><button class="icon-button">다운로드</button></td>
			            </tr>
			            <tr>
			                <td>REQ-2025-0031</td>
			                <td>식품 수입통관<br>수입 | 태국 | 식품</td>
			                <td class="link-text">박세관</td>
			                <td><span class="status-badge completed">완료</span></td>
			                <td>2025-05-01</td>
			                <td>2025-05-05</td>
			                <td></td>
			                <td><button class="icon-button">다운로드</button></td>
			            </tr>
			            <tr>
			                <td>REQ-2025-0028</td>
			                <td>자동차 부품 수입통관<br>수입 | 미국 | 자동차 부품</td>
			                <td class="link-text">최수술</td>
			                <td><span class="status-badge completed">완료</span></td>
			                <td>2025-04-25</td>
			                <td>2025-04-30</td>
			                <td><input type="checkbox"></td>
			                <td><button class="icon-button">다운로드</button></td>
			            </tr>
			            <tr>
			                <td>REQ-2025-0025</td>
			                <td>화장품 수입통관<br>수입 | 프랑스 | 화장품</td>
			                <td class="info-text">미배정</td>
			                <td><span class="status-badge pending">접수대기</span></td>
			                <td>2025-04-20</td>
			                <td>2025-04-20</td>
			                <td></td>
			                <td><button class="icon-button">다운로드</button></td>
			            </tr>
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
			            <button class="action-button secondary">위치보기</button>
			            <button class="action-button primary" onclick="fn_contract_w()">새 의뢰 신청하기</button>
			        </div>
			    </div>
			</div>
			
			
			<a class="autolink" href="/contract/contractdetail.do" style="color: #007bff; margin-top: 20px; display: inline-block;">문서작성 페이지(테스트 링크용)</a>
		</main>	
	</div>
</body>
<script type="text/javascript">
$(function(){
	$("#ciWrite").on("click",function(){
		location.href="/ci/form.do"
	});
	$("#plWrite").on("click",function(){
		location.href="/pl/form.do"
	});
});
function fn_contract_w(){
	location.href = "/consignor/writeContract.do"
}
</script>
</html>