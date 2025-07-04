<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/contract.css">
<script src="<%= request.getContextPath() %>/lib/jQuery/jquery-3.7.1.min.js"></script>
<style type="text/css">
.page-header {
    margin-bottom: 30px;
}

.page-header .page-title {
    font-size: 2.2em;
    color: #f0f0f0;
    margin-bottom: 10px;
    text-align: left;
}

.page-header .page-description {
    font-size: 1em;
    color: #a0a0d0;
}

/* --- 검색 및 필터 섹션 --- */
.search-filter-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    gap: 20px; /* 요소들 사이의 간격 */
}

.search-input-wrapper {
    flex-grow: 1; /* 검색 입력 필드가 남은 공간을 유연하게 차지 */
    position: relative; /* 아이콘 위치 지정을 위함 */
}

.search-input-wrapper .search-icon {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #808080; /* 검색 아이콘 색상 */
}

.search-filter-section .form-input {
    width: 100%;
    padding: 10px 15px;
    padding-left: 45px; /* 검색 아이콘을 위한 왼쪽 패딩 */
    border: 1px solid #4a4a60;
    background-color: #3a3a50;
    color: #f0f0f0;
    border-radius: 8px;
    font-size: 1em;
    box-sizing: border-box; /* 패딩이 너비에 포함되도록 */
}

.search-filter-section .filter-group {
    display: flex;
    gap: 10px; /* 드롭다운 및 버튼 사이 간격 */
    align-items: center;
}

.search-filter-section .form-select {
    padding: 10px 15px;
    border: 1px solid #4a4a60;
    background-color: #3a3a50;
    color: #f0f0f0;
    border-radius: 8px;
    font-size: 1em;
    appearance: none; /* 브라우저 기본 select 스타일 제거 */
    background-image: url('data:image/svg+xml;charset=UTF-8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="white"><path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"/></svg>'); /* 커스텀 드롭다운 화살표 */
    background-repeat: no-repeat;
    background-position: right 15px center;
    background-size: 1em;
    min-width: 120px;
    cursor: pointer;
}

/* --- 데이터 테이블 섹션 (dashboard-section table-section) --- */
/* dashboard-section은 일반적인 카드형 섹션에 사용되는 스타일입니다. */
/* table-section은 테이블 컨테이너에만 적용되는 특정 스타일입니다. */
.dashboard-section.table-section {
    padding: 0; /* 테이블 자체에 패딩이 있으므로 컨테이너 패딩 제거 */
    background: transparent; /* 배경을 투명하게 */
    border: none; /* 테두리 없음 */
    box-shadow: none; /* 그림자 없음 */
    backdrop-filter: none; /* 블러 없음 */
    overflow: hidden; /* 자식 요소(테이블)의 둥근 모서리를 보존 */
}

/* --- 데이터 테이블 --- */
.data-table {
    width: 100%;
    border-collapse: collapse; /* 셀 간의 간격 제거 */
    background-color: rgba(255, 255, 255, 0.03); /* 테이블 배경색 */
    border-radius: 8px; /* 둥근 모서리 */
    overflow: hidden; /* 둥근 모서리 적용을 위해 내용이 넘치지 않도록 */
}

.data-table th,
.data-table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #4a4a60; /* 셀 구분선 */
    color: #f0f0f0;
    font-size: 0.95em;
}

.data-table th {
    background-color: #3a3a50; /* 헤더 배경색 */
    font-weight: bold;
    color: #f0f0f0;
    white-space: nowrap; /* 헤더 텍스트 줄바꿈 방지 */
}

.data-table tbody tr:hover {
    background-color: rgba(0, 123, 255, 0.08); /* 호버 효과 */
}

.data-table .link-text {
    color: #007bff; /* 링크처럼 보이는 텍스트 */
    cursor: pointer;
}

.data-table .link-text:hover {
    text-decoration: underline;
}

.data-table .info-text {
    color: #a0a0d0; /* 일반 정보 텍스트 */
}

/* 상태 뱃지 (진행중, 접수완료, 완료, 접수대기 등) */
.status-badge {
    display: inline-flex;
    align-items: center;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 0.85em;
    font-weight: bold;
    color: #fff;
    white-space: nowrap; /* 뱃지 텍스트 줄바꿈 방지 */
}

.status-badge::before {
    content: '•'; /* 점 아이콘 */
    font-size: 1.5em; /* 점 크기 */
    line-height: 0.5em; /* 점 정렬 */
    margin-right: 5px;
}

.status-badge.progress { /* 진행중 */
    background-color: #007bff; /* 파란색 */
}

.status-badge.received { /* 접수완료 */
    background-color: #28a745; /* 녹색 */
}

.status-badge.completed { /* 완료 */
    background-color: #6c757d; /* 회색 */
}

.status-badge.pending { /* 접수대기 */
    background-color: #ffc107; /* 노란색 */
    color: #333; /* 노란색 배경에 어울리는 어두운 글자색 */
}

/* 아이콘 버튼 (예: 다운로드 아이콘) */
.icon-button {
    background: none;
    border: none;
    padding: 0;
    font-size: 1.2em;
    color: #c0c0c0;
    cursor: pointer;
    transition: color 0.2s;
}

.icon-button:hover {
    color: #007bff;
}

/* 체크박스 */
.data-table input[type="checkbox"] {
    width: 18px;
    height: 18px;
    accent-color: #007bff; /* 체크박스 색상 */
    cursor: pointer;
}

/* --- 테이블 하단 (페이지네이션, 버튼) --- */
.table-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 15px; /* 패딩 */
    margin-top: 0; /* 테이블과 바로 이어지도록 마진 제거 */
    background-color: rgba(255, 255, 255, 0.03); /* 테이블과 동일한 배경 */
    border-top: 1px solid #4a4a60; /* 테이블 하단선과 맞춤 */
    border-radius: 0 0 8px 8px; /* 하단만 둥글게 */
}

.pagination {
    display: flex;
    gap: 5px; /* 페이지 번호 사이 간격 */
}

.pagination a {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    width: 35px;
    height: 35px;
    border-radius: 50%; /* 원형 */
    color: #c0c0c0;
    background-color: #3a3a50; /* 숫자 배경 */
    transition: background-color 0.2s, color 0.2s;
    font-weight: bold;
}

.pagination a:hover {
    background-color: #007bff;
    color: white;
}

.pagination a.active {
    background-color: #007bff;
    color: white;
    border: 2px solid #007bff;
}

.table-footer .footer-buttons {
    display: flex;
    gap: 10px; /* 버튼들 사이 간격 */
}

/* --- 공통 버튼 스타일 (목록 페이지 내에서도 사용됨) --- */
.action-button {
    padding: 10px 20px;
    border-radius: 8px;
    font-weight: bold;
    transition: background-color 0.2s, transform 0.1s;
}

.action-button.primary {
    background-color: #007bff;
    color: white;
}

.action-button.primary:hover {
    background-color: #0056b3;
    transform: translateY(-1px);
}

.action-button.secondary {
    background-color: transparent;
    color: #007bff;
    border: 1px solid #007bff;
}

.action-button.secondary:hover {
    background-color: rgba(0, 123, 255, 0.1);
    transform: translateY(-1px);
}
</style>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">			
			<div class="page-header">
			    <h1 class="page-title">대행 계약 목록조회</h1>
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
			                <th>관세대리업무계약 일련번호</th>
			                <th>물품 일련번호</th>
			                <th>화주 식별번호</th>
			                <th>관세사 식별번호</th>
			                <th>수출입 구분</th>
			                <th>신고서처리업무 합격여부</th>
			                <th>신고서처리업무 구분</th>
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
			            <button class="action-button primary">새 의뢰 신청하기</button>
			        </div>
			    </div>
			</div>
			
			
			<a href="/contract/declform.do" style="color: #007bff; margin-top: 20px; display: inline-block;">문서작성 페이지(테스트 링크용)</a>
		</main>	
	</div>
</body>
</html>