<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>민원사항 상세 페이지</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/board2.css">
<style type="text/css">
.detail-value {
    padding: 8px 0px;
    min-height: 22px;
    white-space: pre-wrap;
    word-break: break-all;
    background-color: #2f2f4f;
    border: 1px solid #4a4a60;
    border-radius: 8px;
    color: #f0f0f0;
    padding-left: 15px;
}
.attachment-link {
	color: #8bb4ff;
	text-decoration: underline;
}
.attachment-link:hover {
	color: #abcfff;
}
.section-title {
    font-size: 1.2em;
    font-weight: bold;
    color: #e0e0e0;
    margin-top: 30px;
    margin-bottom: 15px;
    padding-bottom: 10px;
    border-bottom: 1px solid #4a4a60;
}
</style>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
			<div class="page-header-container">
			    <div class="page-header">
			        <h1 class="page-title">민원사항 상세</h1>
			        <p class="page-description">접수된 민원사항의 상세 내용입니다.</p>
			    </div>
			    <div class="header-action-buttons">
			        <button class="action-button secondary small-button">답변</button>
			        <button class="action-button secondary small-button delete-button">삭제</button>
			        <button class="action-button primary small-button" onclick="history.back()">목록으로</button>
			    </div>
			</div>
			
			<div class="dashboard-section form-section">
                <div class="form-group">
                    <label>민원 일련번호</label>
                    <div class="detail-value">APPEAL0001</div>
                </div>
                <div class="form-group">
                    <label>민원 종류</label>
                    <div class="detail-value">처리지연</div>
                </div>
                <div class="form-group">
                    <label>신고접수 일련번호</label>
                    <div class="detail-value">decl_202506030001</div>
                </div>
                <div class="form-group">
                    <label>민원사항 제목</label>
                    <div class="detail-value">수입신고 처리 지연 문의</div>
                </div>
                <div class="form-group">
                    <label>민원 작성일시</label>
                    <div class="detail-value">2025-06-03 10:30:22</div>
                </div>
                <div class="form-group">
                    <label>내용</label>
                    <div class="detail-value">
                        수입신고번호 decl_202506030001 건에 대한 통관 처리가 계속 지연되고 있습니다.
                        현재 어떤 단계에 있는지, 예상 완료일은 언제인지 확인 부탁드립니다.
                        (여기에 실제 민원 내용이 표시됩니다. 줄바꿈 포함)
                    </div>
                </div>
                <div class="form-group">
                    <label>첨부 파일</label>
                    <div class="detail-value">
                        <a href="#" class="attachment-link">참고파일.pdf</a>
                    </div>
                </div>

                <h2 class="section-title">답변 정보</h2>
                <div class="form-group">
                    <label>민원 진행상태</label>
                    <div class="detail-value">답변완료</div>
                </div>
                <div class="form-group">
                    <label>담당 공무원</label>
                    <div class="detail-value">E11119</div>
                </div>
                <div class="form-group">
                    <label>답변 내용</label>
                    <div class="detail-value">
                        문의주신 decl_202506030001 건은 현재 서류 심사 단계에 있으며, 추가 확인 사항이 있어 시간이 소요되고 있습니다.
                        금일 중으로 처리 완료될 예정입니다. 불편을 드려 죄송합니다.
                        (여기에 실제 답변 내용이 표시됩니다.)
                    </div>
                </div>
                <div class="form-group">
                    <label>답변 작성일시</label>
                    <div class="detail-value">2025-06-04 09:15:00</div>
                </div>
			</div>
		</main>
	</div>
</body>
<script type="text/javascript">
	
</script>
</html>