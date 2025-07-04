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
	<div class="app-container">
		<main class="main-content-area">

		    <div class="container">
		        <div class="header">
		            <h1>수출신고서</h1>
		            <div class="header-icons">
		                <span><i class="icon-placeholder print-icon"></i> 인쇄</span>
		                <span><i class="icon-placeholder pdf-icon"></i> PDF 다운로드</span>
		                <span><i class="icon-placeholder close-icon"></i></span>
		            </div>
		        </div>
		
		        <div class="document-title">
		            <div class="uni-pass-logo">
		                <i class="logo-placeholder uni-pass-logo-icon"></i>
		                <span>UNI-PASS</span>
		            </div>
		            <h2>수출신고필증 (수출이행, 감지)</h2>
		            <div class="remark">* 처리기간: 즉시</div>
		            <div class="seal">전자민원</div>
		        </div>
		
		        <table class="info-table">
		            <tr>
		                <th>신고번호</th>
		                <td>20250503-654321</td>
		                <th>신고일</th>
		                <td>2025-05-03</td>
		            </tr>
		            <tr>
		                <th>통관지세관</th>
		                <td>부산세관</td>
		                <th>수리일자</th>
		                <td>2025-05-04</td>
		            </tr>
		            <tr>
		                <th>수출자</th>
		                <td>메디컬임포트(주)</td>
		                <th>신고인부호</th>
		                <td>E-54321-09876</td>
		            </tr>
		            <tr>
		                <th>사업자등록번호</th>
		                <td>123-45-67890</td>
		                <th>도착항</th>
		                <td>상하이항</td>
		            </tr>
		            <tr>
		                <th>적재의무기한</th>
		                <td>2025-05-20</td>
		                <td colspan="4"></td> </tr>
		        </table>
		
		        <div class="item-section">
		            <h3>품목번호 1 (한국 통계 품목번호: 3004.90.9000)</h3>
		            <table class="sub-table">
		                <tr>
		                    <th>품명/규격</th>
		                    <td style="width: 250px;"></td> <th>수량</th>
		                    <td style="width: 120px;"></td> <th>단가(USD)</th>
		                    <td style="width: 100px;"></td> <th>금액(USD)</th>
		                    <td class="amount-cell red-text"></td> </tr>
		                <tr>
		                    <th>의약품 원료 (항생제)</th>
		                    <td>10,000 / 500 kg</td>
		                    <td></td>
		                    <td></td>
		                    <td>50</td>
		                    <td class="amount-cell red-text">500,000</td>
		                </tr>
		            </table>
		        </div>
		
		        <div class="total-summary-section">
		            <div class="label">총수량</div>
		            <div class="value">10,000</div>
		            <div class="amount-label">총송장금액(USD)</div>
		            <div class="amount-value red-text">500,000</div>
		        </div>
		
		        <div class="footer">
		            <div class="korea-seal" style="bottom: 50px; right: 20px;"> <span>REPUBLIC</span>
		                <span>OF KOREA</span>
		            </div>
		            <div class="disclaimer">
		                발행 번호: <strong>20250503-654321</strong> | 발급일: <strong>2025-05-04</strong><br>
		                본 필증은 전자적으로 발급된 문서로서 관세청 UNI-PASS 시스템을 통해 진위여부를 확인할 수 있습니다.
		            </div>
		        </div>
		    </div>
	    </main>
    </div>
</body>
</html>