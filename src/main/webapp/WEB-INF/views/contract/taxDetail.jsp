<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>세금고지서</title>
	<%@ include file="../modules/header.jsp" %>
	<%@ include file="../modules/sidebar.jsp" %>
	<%@ include file="../modules/modal.jsp" %>
	<link rel="stylesheet" href="/css/main.css">
	<link rel="stylesheet" href="/css/decl.css">
	<style>
		.taxTable {
			width: 100%;
			margin-bottom: 20px;
			border-collapse: collapse;
		}
		.taxTable td {
			border: 1px solid #ccc;
			padding: 8px 10px;
			text-align: left;
			font-size: 13px;
			vertical-align: middle;
			height: 30px;
			box-sizing: border-box;
			background-color: #fff;
			color: #333;
		}
		.taxTable th {
			border: 1px solid #ccc;
			padding: 8px 10px;
			text-align: center;
			font-size: 13px;
			vertical-align: middle;
			height: 30px;
			box-sizing: border-box;
			background-color: #f7f7f7;
			font-weight: normal;
			color: #555;
			width: 140px;
		}
		.taxContent {
			text-align: right;
		}
		.taxTable .subTitle {
			background-color: #eef2f8;
			padding: 8px 10px;
			margin-top: 20px;
			margin-bottom: 0;
			font-size: 15px;
			font-weight: bold;
			border: 1px solid #ccc;
			border-bottom: none;
			color: #333;
			text-align: left;
		}
		.taxTable .num {
			text-align: right;
		}
	</style>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
			<!-- 헤더 영역 -->
			<div class="content-header">
				<!-- 브레드크럼 엘리먼트 -->
				<div class="breadcrumb-warp">
					<div class="col-sm-12">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="/">Home</a></li>
							<li class="breadcrumb-item"><a href="/">내 접수내역</a></li>
							<li class="breadcrumb-item"><a href="/">의뢰 진행 상세</a></li>
							<li class="breadcrumb-item"><a href="/">세금고지서</a></li>
						</ol>
					</div>
				</div>
				<div id="contentTitle" class="content-title">세금고지서</div>
				<p id="contentDesc" class="desc">세금고지서를 확인하고, 납부를 진행합니다.</p>
			</div>
			
			<!--  본문 영역 시작 -->
			<div class="section">
				<!-- 문서명 -->
				<div style="text-align: center; margin-bottom: 20px; position: relative; padding: 10px 0;">
		            <div style="position: absolute; left: 20px; top: 50%; transform: translateY(-50%); display: flex; align-items: center; gap: 5px;">
		                <i style="display: inline-block; width: 30px; height: 30px; background-color: transparent;"></i>
		                <span style="font-size: 28px; font-weight: bold; color: #2a73d8;">Border7</span>
		            </div>
		            <h2 style="font-size: 26px; font-weight: bold; margin: 0; color: #333;">(관세)세금고지서</h2>
		        </div>
		        
				<table class="taxTable">
					<tr>
						<th colspan="6">
							전자납부번호(납부서번호)
						</th>
						<td colspan="2">
							${taxVO.taxNo }
						</td>
					</tr>
					<tr>
						<th>회계년도</th>
						<td><fmt:formatDate value="${taxVO.taxDestDate }" pattern="yyyy" /></td>
						<th>회계</th>
						<td>일반회계</td>
						<th>소관</th>
						<td>관세청</td>
						<th>담당자</th>
						<td>${taxVO.servantName }</td>
					</tr>
					<tr>
						<th>업체명</th>
						<td colspan="3">${taxVO.consignorName }</td>
						<th>사업자등록번호</th>
						<td colspan="3">${taxVO.businessNumber }</td>
					</tr>
					<tr>
						<th>납부세액</th>
						<td colspan="7" class="num"><fmt:formatNumber value="${taxVO.taxAmount }" pattern="###,###,###,### 원" /></td>
					</tr>
					<tr>
						<th>납기내금액</th>
						<td colspan="3" class="num"><fmt:formatNumber value="${taxVO.taxAmount }" pattern="###,###,###,### 원" /></td>
						<th>납기후금액</th>
						<td colspan="3" class="num"><fmt:formatNumber value="${taxVO.taxAmountAfter }" pattern="###,###,###,### 원" /></td>
					</tr>
					<tr>
						<th>고지일자</th>
						<td colspan="7"><fmt:formatDate value="${taxVO.taxDestDate }" pattern="yyyy년 MM월 dd일" /></td>
					</tr>
					<tr>
						<th>납부기한</th>
						<td colspan="7"><fmt:formatDate value="${taxVO.taxDeadlineDate }" pattern="yyyy년 MM월 dd일" /></td>
					</tr>
					<tr>
						<th class="subTitle" colspan="8">
							관할 세무서
						</th>
					</tr>
					<tr>
						<th>관세사명</th>
						<td colspan="3">${taxVO.ccaName }</td>
						<th>관세사등록번호</th>
						<td colspan="3">${taxVO.ccaRegistrationNumber }</td>
					</tr>
				</table>
				<div class="btn-container">
					<input type="button" class="btn btn-primary btn-c" id="taxBtn" value="결제하기" />
				</div>
			</div>
		</main>
	</div>
</body>

<script>
	$(document).ready(function () {
		// 결제하기 버튼 클릭 시
		$("#taxBtn").on("click", function() {
			// 내일 날짜 구하기 - 납부기한 내인지 확인하기 위해
			let today = new Date();
			let tomorrow = new Date();
			tomorrow.setDate(today.getDate() +1);
			
			// 납부기한
			let taxDeadlineDate = new Date("<fmt:formatDate value="${taxVO.taxDestDate }" pattern="yyyy-MM-dd" />");

			// 납부기한 내에 진행하는 결제면 납부후금액으로, 아니면 납기후금액으로 금액 저장
			let taxRealAmount = (taxDeadlineDate < tomorrow) ? ${taxVO.taxAmount } : ${taxVO.taxAmountAfter };
			
			let taxData = {
				"taxNo"			: "${taxVO.taxNo }",
				"taxRealAmount"	: taxRealAmount,
				"declNo"		: "${taxVO.declNo }",
				"contractNo"	: "${taxVO.contractNo }"
			}
			
			// 카카오페이 결제 화면 요청
			$.ajax({
                type: 'POST',
                url: '/contract/taxReady',
                data: JSON.stringify(taxData),
                contentType: 'application/json',
                success: function(result) {
                	console.log(result);
                    location.href = result.next_redirect_pc_url;
                }
            });
		});

	});
</script>
</html>