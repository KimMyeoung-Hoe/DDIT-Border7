<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>새 의뢰현황</title>
<jsp:include page="../modules/header.jsp" />
<jsp:include page="../modules/sidebar.jsp" />
<%@ include file="../modules/modal.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<style>
* {
	box-sizing: border-box;
	font-family: 'Malgun Gothic', sans-serif;
}

body {
	margin: 0;
	padding: 0;
	background-color: #f5f5f5;
}

.container {
	background-color: #f8f9fa;
}

.header {
	padding: 20px;
	border-bottom: 1px solid #eee;
}

.back-btn {
	color: #6c757d;
	text-decoration: none;
	font-size: 0.9rem;
}

.back-btn:hover {
	color: #495057;
}

.main-title {
	font-size: 1.5rem;
	font-weight: bold;
	margin: 0.5rem 0;
}

.subtitle {
	color: #6c757d;
	font-size: 0.9rem;
}

.info-card {
	background: white;
	border-radius: 8px;
	padding: 1.5rem;
	margin-bottom: 1.5rem;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.section-title {
	font-weight: bold;
	margin-bottom: 1rem;
	font-size: 1.1rem;
}

.info-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 0.5rem;
	padding: 0.25rem 0;
}

.info-label {
	color: #6c757d;
	font-size: 0.9rem;
}

.info-value {
	font-weight: 500;
}

.cost-highlight {
	color: #dc3545;
	font-weight: bold;
}

.patient-info {
	background: #f8f9fa;
	border-radius: 8px;
	padding: 1rem;
}

.patient-info .info-row {
	align-items: center;
	margin-bottom: 0.75rem;
}

.patient-info i {
	color: #6c757d;
	width: 20px;
	margin-right: 0.5rem;
}

.file-item {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0.75rem;
	border: 1px solid #e9ecef;
	border-radius: 6px;
	margin-bottom: 0.5rem;
	background: white;
}

.file-info {
	display: flex;
	align-items: center;
}

.file-info i {
	color: #007bff;
	margin-right: 0.5rem;
}

.download-btn {
	color: #007bff;
	text-decoration: none;
	font-size: 0.9rem;
}

.history-badge {
	background: #e9ecef;
	border-radius: 50%;
	width: 30px;
	height: 30px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: bold;
	margin: 1rem auto;
}

.action-buttons {
	display: flex;
	gap: 0.5rem;
	margin-bottom: 1rem;
}

.btn-accept {
	background-color: #007bff;
	border-color: #007bff;
}

.btn-reject {
	background-color: white;
	border-color: #dc3545;
	color: #dc3545;
}

.consultation-textarea {
	width: 100%;
	min-height: 120px;
	border: 1px solid #e9ecef;
	border-radius: 6px;
	padding: 1rem;
	font-size: 0.9rem;
	resize: vertical;
}

.submit-btn {
	background-color: #dc3545;
	border-color: #dc3545;
	padding: 0.75rem 2rem;
	font-weight: 500;
}

.status-badge {
	background-color: #fff3cd;
	color: #856404;
	padding: 0.25rem 0.5rem;
	border-radius: 4px;
	font-size: 0.8rem;
}


</style>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
			<div class="header">

				<div class="content-header">
					<!-- 브레드크럼 엘리먼트 -->
					<div class="breadcrumb-warp">
						<div class="col-sm-12">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="/">Home</a></li>
								<li class="breadcrumb-item"><a href="/cca/ccaContract">접수내역</a></li>
								<li class="breadcrumb-item"><a href="#">신규 의뢰 상세</a></li>
							</ol>
						</div>
					</div>

					<div class="content-title">신규 의뢰 상세</div>
					<p class="desc">의뢰 정보를 확인하고 수락 또는 거절할 수 있습니다.</p>
				</div>
			</div>
			<div class="container section">

				<div class="container-fluid">
					<div class="row">
						<!-- Left Column -->
						<div class="col-lg-8">
							<!-- 의뢰 수출통관 -->
							<div class="info-card">
								<div
									class="d-flex justify-content-between align-items-center mb-3">
									<h3 class="section-title mb-0">${newContract.contractType }
										의뢰</h3>
									<span class="status-badge">${newContract.contractRecordList[0].statusCodeMediumCategoryName }${newContract.contractRecordList[0].statusCodeName }</span>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="info-row">
											<span class="info-label">${newContract.contractType }
												| 의뢰 | ${newContract.productVO.hsCode }</span>
										</div>
									</div>
								</div>
							</div>

							<!-- 의뢰 상세 정보 -->
							<div class="info-card">
								<h3 class="section-title">의뢰 상세 정보</h3>
								<div class="row">
									<div class="col-md-6">
										<div class="info-row">
											<span class="info-label">의뢰 번호</span> <span
												class="info-value">${newContract.contractNo }</span>
										</div>
										<div class="info-row">
											<span class="info-label">의뢰 상품</span> <span
												class="info-value">${newContract.productVO.productName }</span>
										</div>
										<div class="info-row">
											<span class="info-label">원산지</span> <span class="info-value">${newContract.productVO.productOrigin }</span>
										</div>
										<div class="info-row">
											<span class="info-label">물품 부피</span> <span class="info-value">${newContract.productVO.productVolume } CBM</span>
										</div>
									</div>
									<div class="col-md-6">
										<div class="info-row">
											<span class="info-label">등록일</span> <span class="info-value">${newContract.contractRecordList[0].contractRecordRegDate }</span>
										</div>
										<div class="info-row">
											<span class="info-label">물품 수량</span> <span
												class="info-value ">${newContract.productVO.productQty } 개</span>
										</div>
										<div class="info-row">
											<span class="info-label">물품 중량</span> <span
												class="info-value">${newContract.productVO.productWeight } kg</span>
										</div>
										<div class="info-row">
											<span class="info-label">물품 금액</span> <span
												class="info-value"><fmt:formatNumber value="${newContract.productVO.productPrice}" pattern="#,###" /> 원</span>
										</div>
									</div>
								</div>
							</div>

							<!-- 첨부 서류 -->
							<div class="info-card">
								<h3 class="section-title">첨부 서류</h3>
								<div class="file-item">
									<div class="file-info">
										<i class="fas fa-file-pdf"></i> <span>상업송장 (CI)</span> <input
											type="hidden" value="${newContract.ciNo }">
									</div>
									 <a href="/pdf/download/ci/${newContract.ciNo }" class="action-button secondary" id="ciDlBtn"><i class="fas fa-download"></i> 다운로드</a>
			                                    <button class="btn btn-primary" id="ciBtn" value="${newContract.ciNo }"><i class="fas fa-edit"></i> 상세</button>
								</div>
								
								<div class="file-item">
									<div class="file-info">
										<i class="fas fa-file-pdf"></i> <span>패킹리스트 (PL)</span> <input
											type="hidden" value="${newContract.plNo }">
									</div>
									  <a href="/pdf/download/pl/${newContract.plNo }" class="action-button secondary" id="plDlBtn"><i class="fas fa-download"></i> 다운로드</a>
			                                    <button class="btn btn-primary" id="plBtn" value="${newContract.plNo }"><i class="fas fa-edit"></i> 상세</button>
								</div>
							</div>

							<!-- 의뢰 처리 -->
							<div class="info-card">
								<h3 class="section-title">의뢰 처리</h3>

								<div class="action-buttons">
									<button type="button" class="btn btn-primary" id="approvalBtn">
										<i class="fas fa-check"></i> 의뢰 수락
									</button>
									<button type="button" class="btn btn-danger" id="refusalBtn">
										<i class="fas fa-times"></i> 의뢰 거절
									</button>
									
								</div>

								<div id="selectBoxShow" style="display: none;">
										<select class="form-select" id="refusalForm">
												<option value="">거절 사유를 선택해 주세요.</option>
											<c:forEach items="${refusalList}" var="r">
												<option value="${r.statusCode }">${r.statusCodeName }</option>
											</c:forEach>
										</select>
										<button class="btn" style="border: 1px solid;" id="refusalRegisterBtn">등록</button>
									</div>

							</div>
						</div>

						<!-- Right Column -->
						<div class="col-lg-4">
							<div class="info-card">
								<h3 class="section-title">의뢰인 정보
									<button class="" style="border: 1px solid;" id="maskedBtn"><i class="fas fa-eye"></i></button>
								</h3>
								<div class="patient-info">
								<div class="info-row">
										<div class="d-flex align-items-center">
											<i class="fas fa-building"></i> <span class="info-label">${newContract.consignorCompanyName}</span>
										</div>
									</div>
									<div class="info-row">
										<div class="d-flex align-items-center">
											<i class="fas fa-user"></i> <span class="info-label"><span id="userName"> ${newContract.consignorName } </span></span>
										</div>
									</div>
									<div class="info-row">
										<div class="d-flex align-items-center">
											<i class="fas fa-envelope"></i> <span class="info-value">${newContract.consignorUserEmail }</span>
										</div>
									</div>
									<div class="info-row">
										<div class="d-flex align-items-center">
											<!-- <i class="fas fa-phone"></i> --><i class="fas fa-mobile-alt"></i>  <span class="info-value"><span id="userTel">${newContract.consignorUserTel }</span></span>
										</div>
									</div>
									<div class="info-row">
										<div class="d-flex align-items-center">
											<i class="fas fa-fax"></i> <span class="info-value">${newContract.consignorTel } </span>
										</div>
									</div>
									<div class="text-end mt-3">
										<a href="#" class="text-primary text-decoration-none"> <small>회원
												프로필 보기</small>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>


			</div>
		</main>
	</div>

	<script>
		$(function() {
			let listBtn = $("#listBtn");
			let sendBtn = $("#sendBtn");
			let refusalBtn = $("#refusalBtn");
			let selectBoxShow = $("#selectBoxShow");
			let refusalRegisterBtn = $("#refusalRegisterBtn");
			let approvalBtn = $("#approvalBtn");
			let plBtn = $("#plBtn");
			let ciBtn = $("#ciBtn");
			
			let contractNo = window.location.pathname.split("/")[3];
			console.log(contractNo);

			listBtn.on("click", function() {
				location.href = "/cca/ccaContract";
			})
			
			refusalBtn.on("click",function(){
				selectBoxShow.toggle();
			})
			
			//개인정보 마스킹
			let maskedBtn = $("#maskedBtn");
			let userTel = $("#userTel");
			let userName = $("#userName");
			let isMasked = true;
			
			function maskPhoneNumber(phoneNumber){
				 if (!phoneNumber || phoneNumber.length < 10) {
			            return phoneNumber; 
			        }
				return phoneNumber.replace(/(\d{3})-?(\d{4})-?(\d{4})/, "$1-****-$3");
			}
			
			function maskName(name){
				 if (!name || name.length < 2) {
			            return name; 
			        }
				 const firstChar = name.charAt(0);
			        const lastChar = name.charAt(name.length - 1);
			        const maskedMiddle = "*".repeat(name.length - 2); // 중간 글자 개수만큼 * 반복
			        return firstChar + maskedMiddle + lastChar;
			}
			
			const originalPhoneNumber = userTel.text().trim();
			const originalUserName = userName.text().trim();
			
			const maskedPhoneNumber = maskPhoneNumber(originalPhoneNumber);
			const maskedUserName = maskName(originalUserName);
			
			userTel.text(maskedPhoneNumber); //페이지 로딩시 마스킹된거 보이게 ㅇㅇ
			userName.text(maskedUserName); //페이지 로딩시 마스킹된거 보이게 ㅇㅇ
			
			maskedBtn.on("click",function(){
				isMasked = !isMasked;
				
				if(isMasked){
					userTel.text(maskedPhoneNumber);
					userName.text(maskedUserName);
				}else{
					userTel.text(originalPhoneNumber);
					userName.text(originalUserName);
				}
			})
			
			

			refusalRegisterBtn.on("click",function(){
				//거절 후 거절 사유 등록하고 버튼 눌렀을때
				let refusalForm = $("#refusalForm").val();
				console.log(refusalForm);
				
			 	$.ajax({
					url:"/cca/contractRefusal",
					type:"post",
					data : {statusCode:refusalForm , contractNo : contractNo},
					success : function(result){
						console.log(result);
						if(result){
							window.location.href = result;
						}
					},
					error : function(xhr, status, error){
				        console.error("에러 발생:", status, error);
				        alertify.error('오류가 발생했습니다.');
				      /*   alert("요청 처리 중 오류가 발생했습니다."); */
				    }
				})  
			})
	
			
			approvalBtn.on("click",function(){
				console.log("클릭");
				
				$.ajax({
					url:"/cca/contractApproval",
					type:"post",
					data:{contractNo : contractNo},
					success: function(result){
						console.log(result);
						if(result){
							window.location.href = result;
						}
					},
					error : function(xhr, status, error){
				        console.error("에러 발생:", status, error);
				        /* alert("요청 처리 중 오류가 발생했습니다."); */
				        alertify.error('오류가 발생했습니다.');
				    }
				})
			})
			
			plBtn.on("click",function(){
				let plNo = plBtn.val();
				console.log("plNo 클",plNo);
				window.open("/pl/detail.do?plNo="+plNo
						, "_blank"
				        , "width=1000,height=1000,scrollbars=yes,resizable=yes");
			});
			
			ciBtn.on("click",function(){
				let ciNo = ciBtn.val();
				console.log("ci클릭" , ciNo);
				window.open("/ci/detail.do?ciNo="+ciNo
						, "_blank"
				        , "width=1000,height=1000,scrollbars=yes,resizable=yes");
				//location.href ="/ci/detail.do?ciNo="+ciNo;
			});

		})
	</script>
</body>
</html>