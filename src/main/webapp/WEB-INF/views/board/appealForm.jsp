<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>민원사항 등록 페이지</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/board2.css">
<style type="text/css">
/* 파일 입력 필드 스타일 (참고 코드에서 가져옴) */
.form-input-file {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #4a4a60;
    background-color: #3a3a50;
    color: #f0f0f0;
    border-radius: 8px;
    font-size: 1em;
    box-sizing: border-box;
    cursor: pointer;
}

.form-input-file::-webkit-file-upload-button {
    background-color: #007bff;
    color: white;
    padding: 8px 15px;
    border-radius: 5px;
    border: none;
    cursor: pointer;
    margin-right: 15px;
    transition: background-color 0.2s;
}

.form-input-file::-webkit-file-upload-button:hover {
    background-color: #0056b3;
}

.file-note {
    font-size: 0.85em;
    color: #a0a0d0;
    margin-top: 5px;
    padding-left: 5px;
}
</style>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
			<div class="page-header-container">
			    <div class="page-header">
			        <h1 class="page-title"></h1>
			        <p class="page-description">새로운 민원사항을 등록합니다.</p>
			    </div>
			    <div class="header-action-buttons">
			        <button class="action-button secondary small-button" onclick="history.back()">목록으로</button>
			    </div>
			</div>
			
			<div class="dashboard-section form-section">
			    <form id="appealUserWriteForm">
			        <div class="form-group">
			            <label for="appealCategory">민원사항 종류</label>
			            <select id="appealCategory" class="form-input">
			                <option value="">민원사항 종류 선택</option>
			                <option value="customsProcedure">통관절차 문의</option>
			                <option value="documentSubmission">서류제출 및 보완</option>
			                <option value="taxFee">세금 및 비용 문의</option>
			                <option value="inspectionQuarantine">검사/검역</option>  
			                <option value="certificateIssuance">신고필증/증명서 발급</option>
			                <option value="cargoTransportStorage">물품 운송 및 보관</option>
			                <option value="systemUsage">시스템 이용 문의</option>
			                <option value="processingDelay">업무 처리 지연</option>
			                <option value="etc">기타</option> 
			            </select>
			        </div>
			
			        <div class="form-group">
			            <label for="declNo">신고접수 일련번호</label>
			            <input type="text" id="declNo" class="form-input" placeholder="(필요시)신고접수 일련번호를 입력하세요." >
			        </div>
			        
			        <div class="form-group">
			            <label for="appealTitle">민원사항 제목</label>
			            <input type="text" id="appealQuestion" class="form-input" placeholder="질문을 입력하세요." required>
			        </div>
			        
			        <div class="form-group">
			            <label for="appealContent">내용</label>
			            <textarea id="appealContent" class="form-input" rows="10" placeholder="내용을 입력하세요." required></textarea>
			        </div>
			        
    				<div class="form-group">
			            <label for="appealAttachment">첨부 파일</label>
			            <input type="file" id="appealAttachment" class="form-input-file">
			            <p class="file-note">최대 5MB, JPG, PNG, PDF 파일만 첨부 가능합니다.</p>
			        </div>
			
			        <div class="form-buttons">
			            <button type="reset" class="action-button secondary">초기화</button>
			            <button type="submit" class="action-button primary">민원사항 등록</button>
			        </div>
			    </form>
			</div>
		</main>
	</div>
</body>
<script type="text/javascript">
	
</script>
</html>