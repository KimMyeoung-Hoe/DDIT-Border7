<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지</title>
	<!-- daum 우편번호찾기 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" ></script>
	<!-- kakao 지도 -->
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e8306615f01d266edffd26c9c180c3c4&libraries=services"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<!-- 공통css -->
	<%@ include file="../modules/header.jsp" %>
	<%@ include file="../modules/sidebar.jsp" %>
	<%@ include file="../modules/modal.jsp" %>
	<link rel="stylesheet" href="/css/main.css" />
	<!-- confirm 대체 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.js"></script>
	<style type="text/css">
		/* 메인 탭 스타일 */
		.mainTabDiv { /* 각 탭 영역 */
			display: none;
		}
		.mainTabDiv.active { /* 선택된 탭 영역 */
			display: block;
		}
		
		/* 전체 스타일 */
		.table-section { /* 테이블 섹션 */
			margin: 0px auto 15px;
			overflow: hidden;
		}
		
		.td-h { /* 테이블 항목명 td */
			min-width: 180px; /* 화면 늘리거나 줄여도 항목명이 줄바꿈 되지 않도록 크기 고정 처리 */
			max-width: 160px;
		}
		.td-b { /* 테이블 항목내용 td */
			width: 100%; /* 화면 늘리거나 줄이면 그 영역을 채우도록 처리 */
			text-align: left !important;
		}
		
		/* 내 정보 영역 스타일 */
		.td-p { /* 테이블 프로필이미지 td */
			min-width: 200px;
			height: 200px;
			position: relative;
		}
		.profileImg { /* 프로필이미지 */
			width: 200px;
			height: 200px;
			border-radius: 50%;
			z-index: 2;
		}
		.profileBtn { /* 프로필이미지 변경 버튼 */
			width: 45px;
			height: 45px;
			border: none;
			border-radius: 50%;
			background-color: #f5f7fa;
			box-shadow: 0 0 10px 5px rgba(0, 0, 0, 0.3);
			position: absolute;
			right: 20px;
			bottom: 20px;
			z-index: 1;
		}
		.ynSpan { /* 수신 동의 text가 담긴 span */
			vertical-align: middle;
			height: 30px;
		}
		#emailYn,
		#smsYn { /* 수신 동의 checkbox */
			display: inline-block;
			vertical-align: middle;
			height: 20px;
		}
		
		/* 내 프로필 영역 스타일 */
		.profile-section { /* 프로필 상단(프로필이미지, 업체명, 제재내용) 영역 */
			margin-bottom: 20px;
			display: flex;
			gap: 15px;
			align-items: flex-start;
			position: relative;
		}
		.SProfileImg { /* 프로필 상단 - 프로필이미지 */
			width: 60px;
			height: 60px;
			border: none;
			border-radius: 50%;
			background-color: #e1e1e1;
		}
		.profile-info { /* 프로필 상단 - 업체명 영역 */
			margin-top: 8px;
			font-size: 30px;
			font-weight: bold;
			display: flex;
   			flex-direction: column;
		}
		.profile-name { /* 프로필 상단 - 업체명 영역 */
			margin-bottom: 0px;
		}
		.profile-specialty { /* 프로필 상단 - 주력분야 */
			font-size: 13px;
			color: #6c757d;
			margin-top: 0px;
			padding-top: 0px;
			font-weight: normal;
			padding-left: 4px;
		}
		.stats-section { /* 프로필 상단 - 제재내용 영역 */
			margin-top: 2px;
			display: flex;
			gap: 40px;
			position: relative;
			align-items: center;
			justify-content: space-around;
			text-align: center;
			position: absolute;
			right: 10px;
		}
		.stat-number { /* 프로필 상단 - 제재내용값 */
			margin-top: -10px;
			margin-bottom: 5px;
			font-size: 28px;
			font-weight: bold;
		}
		.stat-number.red { /* 프로필 상단 - 제재내용값(오류점수) */
			color: #dc3545;
		}
		.stat-number.green { /* 프로필 상단 - 제재내용값(무오류처리률) */
			color: #28a745;
		}
		.contact-info { /* 프로필 본문 영역 */
			display: flex;
			align-items: flex-start;
		}
		.myProfileTable { /* 프로필 본문 - 테이블 */
			width: 50%;
			min-width: 350px;
		}
		.iconTd { /* 프로필 본문 - 테이블 아이콘 td */
			width: 30px;
		}
		.ProfileCategoryinTd { /* 프로필 본문 - 테이블 항목명 td */
			min-width: 110px;
			max-width: 110px;
		}
		.office-section { /* 프로필 지도 영역 */
			margin-top: 15px;
			margin-bottom: 15px;
		}
		.category-options { /* 관세사 탭 본문 영역 */
			color: black;
			max-height: 200px;
			overflow-y: auto;
		}
		
		/* 비밀번호 변경 영역 스타일 */
		#myPwChangeDiv .table-section { /* 테이블 */
			margin: auto;
		}
	</style>
	<sec:authentication property="principal" var="princ"/>
	<% String contextPath = request.getContextPath(); %>
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
							<li class="breadcrumb-item"><a href="/">마이페이지</a></li>
						</ol>
					</div>
				</div>
				<div id="contentTitle" class="content-title">내 정보</div>
				<p id="contentDesc" class="desc">내 계정의 업체 및 담당자 정보를 확인하고 수정합니다.</p>
			</div>
		
			<!--  본문 영역 시작 -->
			<div class="section">
				<!-- 탭 영역 -->
				<div class="support-tabs">
					<div id="myProfileTab" class="tab-item active" data-tab="myProfileDiv">
						<i class="fas fa-question-circle tab-icon"></i> 내 프로필
					</div>
					<div id="myInfoTab" class="tab-item" data-tab="myInfoDiv">
						<i class="fas fa-question-circle tab-icon"></i> 내 정보
					</div>
					<div id="myPwChangeTab" class="tab-item" data-tab="myPwChangeDiv">
						<i class="fas fa-question-circle tab-icon"></i> 비밀번호 변경
					</div>
				</div>
				
				<!-- 내 프로필 div 영역 시작 -->
				<div id="myProfileDiv" class="mainTabDiv active">
					<!-- 화주 프로필 상단 -->
					<c:choose>
						<c:when test="${princ.user.authCode.equals(\"ROLE_CONSIGNOR\")}">
							<div class="profile-section">
								<img class="SProfileImg" src="/myPage/displayFile?fileName=${userVO.consignorVO.consignorProfileImg}" alt="프로필 사진" />
								<div class="profile-info">
									<div class="profile-name">${userVO.consignorVO.consignorName}</div>
								</div>
							</div>	
						</c:when>
					</c:choose>
					<!-- 관세사 프로필 상단 -->
					<c:choose>
						<c:when test="${princ.user.authCode.equals(\"ROLE_CCA\")}">
							<div class="profile-section">
								<img class="SProfileImg" src="/myPage/displayFile?fileName=${userVO.ccaVO.ccaProfileImg}" alt="프로필 사진" />
								<div class="profile-info">
									<div class="profile-name">${userVO.ccaVO.ccaName}</div>
									<span class="profile-specialty">주력분야 : 
										<c:forEach items="${userVO.ccaVO.ccaSpecialtyNameList}" var="cca" varStatus="status">
											${cca}<c:if test="${!status.last }">, </c:if>
										</c:forEach>
									</span>
								</div>
								<div class="stats-section">
									<div class="stat-item">
										<div class="stat-label">오류점수</div>
										<div class="stat-number red">${userVO.ccaVO.ccaSanctionScore}</div>
									</div>
									<div class="stat-item">
										<div class="stat-label">무오류 처리율</div>
										<div class="stat-number green">${userVO.ccaVO.infallible}%</div>
									</div>
								</div>
							</div>	
						</c:when>
					</c:choose>
					<!-- 물류관리자 프로필 상단 -->
					<c:choose>
						<c:when test="${princ.user.authCode.equals(\"ROLE_LOGISTICS\")}">
							<div class="profile-section">
								<img class="SProfileImg" src="/myPage/displayFile?fileName=${userVO.logistMngVO.logistMngProfileImg}" alt="프로필 사진" />
								<div class="profile-info">
									<div class="profile-name">${userVO.logistMngVO.logistMngName}</div>
								</div>
							</div>	
						</c:when>
					</c:choose>
							<div class="contact-info">
								<!-- 화주 프로필 업체정보 -->
								<c:choose>
									<c:when test="${princ.user.authCode.equals(\"ROLE_CONSIGNOR\")}">
										<table class="myProfileTable">
											<tr>
												<td class="">
													<i class="fas fa-phone"></i> 
												</td>
												<td class="ProfileCategoryinTd">
													<span>업체 전화</span>
												</td>
												<td class="td-b">
													<span>${userVO.consignorVO.consignorTel}</span>
												</td>
											</tr>
											<tr>
												<td class="iconTd">
												<i class="fas fa-fax"></i>
												</td>
												<td class="ProfileCategoryinTd">
													<span>업체 팩스</span>
												</td>
												<td class="td-b">
													<span>${userVO.userFax}</span>
												</td>
											</tr>
											<tr>
												<td class="iconTd">
													<i class="fas fa-map-marker-alt"></i>
												</td>
												<td class="ProfileCategoryinTd">
													<span>업체 주소</span>
												</td>
												<td class="td-b">
													<span>${userVO.consignorVO.consignorAddr} ${userVO.consignorVO.consignorDetAddr}</span>
												</td>
											</tr>
										</table>
									</c:when>
								</c:choose>
								<!-- 관세사 프로필 업체정보 -->
								<c:choose>
									<c:when test="${princ.user.authCode.equals(\"ROLE_CCA\")}">
										<table class="myProfileTable">
											<tr>
												<td class="iconTd">
													<i class="fas fa-phone"></i> 
												</td>
												<td class="ProfileCategoryinTd">
													<span>업체 전화</span>
												</td>
												<td class="td-b">
													<span>${userVO.ccaVO.ccaTel}</span>
												</td>
											</tr>
											<tr>
												<td class="iconTd">
													<i class="fas fa-fax"></i>
												</td>
												<td class="ProfileCategoryinTd">
													<span>업체 팩스</span>
												</td>
												<td class="td-b">
													<span>${userVO.userFax}</span>
												</td>
											</tr>
											<tr>
												<td class="iconTd">
													<i class="fas fa-map-marker-alt"></i>
												</td>
												<td class="ProfileCategoryinTd">
													<span>업체 주소</span>
												</td>
												<td class="td-b">
													<span>${userVO.ccaVO.ccaAddr} ${userVO.ccaVO.ccaDetAddr}</span>
												</td>
											</tr>
										</table>
									</c:when>
								</c:choose>
								<!-- 물류관리자 프로필 업체정보 -->
								<c:choose>
									<c:when test="${princ.user.authCode.equals(\"ROLE_LOGISTICS\")}">
										<table class="myProfileTable">
											<tr>
												<td class="iconTd">
												<i class="fas fa-phone"></i> 
												</td>
												<td class="ProfileCategoryinTd">
													<span>업체 전화</span>
												</td>
												<td class="td-b">
													<span>${userVO.logistMngVO.logistMngTel}</span>
												</td>
											</tr>
											<tr>
												<td class="iconTd">
													<i class="fas fa-fax"></i>
												</td>
												<td class="ProfileCategoryinTd">
													<span>업체 팩스</span>
												</td>
												<td class="td-b">
													<span>${userVO.userFax}</span>
												</td>
											</tr>
											<tr>
												<td class="iconTd">
													<i class="fas fa-map-marker-alt"></i>
												</td>
												<td class="ProfileCategoryinTd">
													<span>업체 주소</span>
												</td>
												<td class="td-b">
													<span>${userVO.logistMngVO.logistMngAddr} ${userVO.logistMngVO.logistMngDetAddr}</span>
												</td>
											</tr>
										</table>
									</c:when>
								</c:choose>
								
								<table class="myProfileTable">
									<tr>
										<td class="iconTd">
											<i class="fas fa-user"></i> 
										</td>
										<td class="ProfileCategoryinTd">
											<span>담당자 이름</span>
										</td>
										<td class="td-b">
											<span>${userVO.userName}</span>
										</td>
									</tr>
									<tr>
										<td class="iconTd">
											<i class="fas fa-mobile-alt"></i> 
										</td>
										<td class="ProfileCategoryinTd">
											<span>담당자 핸드폰</span>
										</td>
										<td class="td-b">
											<span>${userVO.userTel}</span>
										</td>
									</tr>
									<tr>
										<td class="iconTd">
											<i class="fas fa-envelope"></i>
										</td>
										<td class="ProfileCategoryinTd">
											<span>담당자 이메일</span>
										</td>
										<td class="td-b">
											<span>${userVO.userEmail}</span>
										</td>
									</tr>
								</table>
							</div>
					<div class="office-section">
						<div id="map" style="width: 100%; height: 300px; display: none;"></div>
					</div>
					<c:if test="${princ.user.authCode.equals(\"ROLE_CCA\")}">
						<div class="categories-section">
							<div class="tabs-container">
								<div class="tabs-header">
									<div id="ccaRecentTab" class="tab-button categories-title active" data-tab="recent">업무 내역</div>
									<div id="ccaErrorTab" class="tab-button categories-title" data-tab="error">오류 점수 부과 내역</div>
								</div>
								<div class="tabs-content">
									<div class="tab-pane category-options active" id="recent">
										<c:if test="${empty contractList}">
									        <span class="no-contract-message">의뢰 내역이 존재하지 않습니다.</span>
									    </c:if>
									    <c:forEach items="${contractList}" var="contract">
									        <div class="contract-item" style="margin-bottom: 10px">
									            <div class="contract-header">
									            	<fmt:parseDate value="${contract.CONTRACT_RECORD_REG_DATE }" pattern="yyyy-MM-dd" var="date"/>
									                <span class="contract-no"><fmt:formatDate value="${date }" pattern="yyyy-MM-dd"/></span>
									            </div>
									            <div class="contract-status">
									                <span class="contract-no">의뢰품목 : ${contract.HS_CODE } (${contract.HS_KR_NAME })</span></br>
									                <span class="contract-no">진행상태 : ${contract.STATUS_CODE_MEDIUM_CATEGORY_NAME } ${contract.STATUS_CODE_NAME }</span>
									            </div>
									        </div>
									    </c:forEach>
									</div>
									<div class="tab-pane category-options" id="error">
										<c:if test="${empty userVO.ccaVO.sanctionScoreList }">
											<span><span>🎉</span>오류 점수 내역이 없습니다.<span>🎉</span></span>
										</c:if>
										<c:forEach items="${userVO.ccaVO.sanctionScoreList }" var="score">
											<div>
												<fmt:parseDate value="${score.sanctionDate }" pattern="yyyy-MM-dd" var="date"/>
												<fmt:formatDate value="${date }" pattern="yyyy-MM-dd"/>  - ${score.sanctionName } : <span style="color: red">${score.sanctionScore }점</span>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</c:if>
				</div>
				<!-- 내 프로필 div 영역 끝 -->
				
				<!-- 내 정보 div 영역 시작 -->
				<div id="myInfoDiv" class="mainTabDiv">
					<!-- 계정 정보 -->
					<div class="table-section">
						<!-- 프로필 사진 수정 위한 file input -->
						<input type="file" id="hiddenProfileFileInput" accept="image/*" style="display: none;" />
						
						<table class="data-table">
							<thead>
								<tr>
									<th colspan="4">계정 정보</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${princ.user.authCode.equals(\"ROLE_CONSIGNOR\")}">
										<tr>
											<td class="td-p" rowspan="4">
												<button type="button" class="profileBtn" title="프로필 이미지 수정" style="display: none;">
													<i class="img-update fas fa-pencil-alt"></i>
												</button>
												<img class="profileImg" src="/myPage/displayFile?fileName=${userVO.consignorVO.consignorProfileImg }" alt="프로필 사진" />
											</td>
											<td class="td-h">권한</td>
											<td class="td-b">화주</td>
										</tr>
									</c:when>
									<c:when test="${princ.user.authCode.equals(\"ROLE_CCA\")}">
										<tr>
											<td class="td-p" rowspan="4">
												<button type="button" class="profileBtn" title="프로필 이미지 수정" style="display: none;">
													<i class="img-update fas fa-pencil-alt"></i>
												</button>
												<img class="profileImg" src="/myPage/displayFile?fileName=${userVO.ccaVO.ccaProfileImg }" alt="프로필 사진" />
											</td>
											<td class="td-h">권한</td>
											<td class="td-b">관세사</td>
										</tr>
									</c:when>
									<c:when test="${princ.user.authCode.equals(\"ROLE_LOGISTICS\")}">
										<tr>
											<td class="td-p" rowspan="4">
												<button type="button" class="profileBtn" title="프로필 이미지 수정" style="display: none;">
													<i class="img-update fas fa-pencil-alt"></i>
												</button>
												<img class="profileImg" src="/myPage/displayFile?fileName=${userVO.logistMngVO.logistMngProfileImg }" alt="프로필 사진" />
											</td>
											<td class="td-h">권한</td>
											<td class="td-b">물류관리자</td>
										</tr>
									</c:when>
								</c:choose>	

								<tr>
									<td class="td-h">아이디</td>
									<td class="td-b">${princ.user.userId }</td>
								</tr>
								<tr>
									<td class="td-h">내부 이메일</td>
									<td class="td-b">${princ.user.userId }@border7.kr</td>
								</tr>
								<tr>
									<td class="td-h">가입일자</td>
									<td class="td-b">${princ.user.regDate }</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<!-- 업체 정보 -->
					<div class="table-section">
						<table class="data-table">
							<thead>
								<tr>
									<th colspan="2">업체 정보</th>
								</tr>
							</thead>
							<tbody>
								<!-- 화주일 경우 -->
								<c:if test="${princ.user.authCode.equals(\"ROLE_CONSIGNOR\")}">
									<tr>
										<td class="td-h">통관번호</td>
										<td class="td-b">${userVO.consignorVO.consignorCustomsCode }</td>
									</tr>
									<tr>
										<td class="td-h">사업자명</td>
										<td class="td-b">${userVO.consignorVO.consignorName }</td>
									</tr>
									<tr>
										<td class="td-h">사업자번호</td>
										<td class="td-b">${userVO.consignorVO.businessNumber }</td>
									</tr>
									<tr>
										<td class="td-h">전화번호</td>
										<td class="td-b">
											<input type="text" id="userTel" name="userTel" class="form-control toggleInfo"
												placeholder="전화번호" readonly value="${userVO.consignorVO.consignorTel }" />
											<span id="checkTel" class="form-text"></span>
										</td>
									</tr>
									<tr>
										<td class="td-h">주소</td>
										<td class="td-b">
											<button type="button" id="zipbtn" class="btn btn-success btn-sm" style="display: none;">주소찾기</button>
											<input type="text" id="userPost" name="userPost" class="form-control"
												placeholder="우편번호" readonly value="${userVO.consignorVO.consignorPost }" />
											<input type="text" name="userAddr" id="userAddr" class="form-control"
												placeholder="기본주소" readonly value="${userVO.consignorVO.consignorAddr }" />
											<input type="text" name="userDetAddr" id="userDetAddr" class="form-control toggleInfo"
												placeholder="상세주소" readonly value="${userVO.consignorVO.consignorDetAddr }" />
										</td>
									</tr>
								</c:if>
								
								<!-- 관세사일 경우 -->
								<c:if test="${princ.user.authCode.equals(\"ROLE_CCA\")}">
									<tr>
										<td class="td-h">관세사명</td>
										<td class="td-b">${userVO.ccaVO.ccaName }</td>
									</tr>
									<tr>
										<td class="td-h">관세사등록번호</td>
										<td class="td-b">${userVO.ccaVO.ccaRegistrationNumber }</td>
									</tr>
									<tr>
										<td class="td-h">전화번호</td>
										<td class="td-b">
											<input type="text" id="userTel" name="userTel" class="form-control toggleInfo"
												placeholder="전화번호" readonly value="${userVO.ccaVO.ccaTel }" />
										</td>
									</tr>
									<tr>
										<td class="td-h">주소</td>
										<td class="td-b">
											<button type="button" id="zipbtn" class="btn btn-success btn-sm" style="display: none;">주소찾기</button>
											<input type="text" id="userPost" name="userPost" class="form-control"
												placeholder="우편번호" readonly value="${userVO.ccaVO.ccaPost }" />
											<input type="text" name="userAddr" id="userAddr" class="form-control"
												placeholder="기본주소" readonly value="${userVO.ccaVO.ccaAddr }" />
											<input type="text" name="userDetAddr" id="userDetAddr" class="form-control toggleInfo"
												placeholder="상세주소" readonly value="${userVO.ccaVO.ccaDetAddr }" />
										</td>
									</tr>
									<tr>
										<td class="td-h">주력분야</td>
										<td class="td-b">
											<input type="checkbox" name="specialtys" id="specialty1" value="1" class="checkbox" disabled />수출입신고<br/>
											<input type="checkbox" name="specialtys" id="specialty2" value="2" class="checkbox" disabled />FTA<br/>
											<input type="checkbox" name="specialtys" id="specialty3" value="3" class="checkbox" disabled />관세환급<br/>
											<input type="checkbox" name="specialtys" id="specialty4" value="4" class="checkbox" disabled />품목분류(HS CODE 분류)<br/>
											<input type="checkbox" name="specialtys" id="specialty5" value="5" class="checkbox" disabled />관세평가<br/>
											<input type="checkbox" name="specialtys" id="specialty6" value="6" class="checkbox" disabled />관세조사 대응<br/>
											<input type="checkbox" name="specialtys" id="specialty7" value="7" class="checkbox" disabled />관세/무역 컨설팅<br/>
										</td>
									</tr>
								</c:if>
								
								<!-- 물류관리자일 경우 -->
								<c:if test="${princ.user.authCode.equals(\"ROLE_LOGISTICS\")}">
									<tr>
										<td class="td-h">사업자명</td>
										<td class="td-b">${userVO.logistMngVO.logistMngName }</td>
									</tr>
									<tr>
										<td class="td-h">사업자번호</td>
										<td class="td-b">${userVO.logistMngVO.businessNumber }</td>
									</tr>
									<tr>
										<td class="td-h">전화번호</td>
										<td class="td-b">
											<input type="text" id="userTel" name="userTel" class="form-control toggleInfo"
												placeholder="전화번호" readonly value="${userVO.logistMngVO.logistMngTel }" />
										</td>
									</tr>
									<tr>
										<td class="td-h">주소</td>
										<td class="td-b">
											<button type="button" id="zipbtn" class="btn btn-success btn-sm" style="display: none;">주소찾기</button>
											<input type="text" id="userPost" name="userPost" class="form-control"
												placeholder="우편번호" readonly value="${userVO.logistMngVO.logistMngPost }" />
											<input type="text" name="userAddr" id="userAddr" class="form-control"
												placeholder="기본주소" readonly value="${userVO.logistMngVO.logistMngAddr }" />
											<input type="text" name="userDetAddr" id="userDetAddr" class="form-control toggleInfo"
												placeholder="상세주소" readonly value="${userVO.logistMngVO.logistMngDetAddr }" />
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>

					<!-- 담당자(모든 사용자 공통) 항목 -->
					<div class="table-section">
						<table class="data-table">
							<thead>
								<tr>
									<th colspan="2">담당자 정보</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="td-h">담당자명</td>
									<td class="td-b">
										<input type="text" id="userName" name="userName" class="form-control toggleInfo" placeholder="이름" readonly value="${userVO.userName }" />
									</td>
								</tr>
								<tr>
									<td class="td-h">핸드폰번호</td>
									<td class="td-b">
										<input type="text" id="userPhone" name="userPhone" class="form-control toggleInfo" placeholder="전화번호" readonly value="${userVO.userTel }" />
										<span id="checkPhone" class="form-text"></span>
										<span class="ynSpan">SMS 수신 동의</span>
										<input type="checkbox" name="smsYn" id="smsYn" class="toggleInfo" disabled />
									</td>
								</tr>
								<tr>
									<td class="td-h">이메일</td>
									<td class="td-b">
										<input type="text" id="userEmail" name="userEmail" class="form-control toggleInfo" placeholder="이메일" readonly value="${userVO.userEmail }" />
										<span id="checkEmail" class="form-text"></span>
										<span class="ynSpan">이메일 수신 동의</span>
										<input type="checkbox" name="emailYn" id="emailYn" class="toggleInfo" disabled />
									</td>
								</tr>
								<tr>
									<td class="td-h">팩스(선택)</td>
									<td class="td-b">
										<input type="text" id="userFax" name="userFax" class="form-control toggleInfo" placeholder="팩스번호" readonly value="${userVO.userFax }" />
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="btn-container">
						<input type="button" class="btn btn-primary btn-c" id="updateBtn" value="수정" />
						<input type="button" class="btn btn-secondary btn-c" id="deleteBtn" value="회원탈퇴" />
					</div>
				</div>
				<!-- 내 정보 div 영역 끝 -->

				<!-- 비밀번호 변경 div 영역 시작 -->
				<div id="myPwChangeDiv" class="mainTabDiv">
					<div class="table-section">
						<table class="data-table">
							<thead>
								<tr>
									<th colspan="3">비밀번호</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="td-h">현재 비밀번호</td>
									<td class="td-b">
										<input type="password" id="pwOld" class="form-control" />
									</td>
									<td class="td-e">
										<input type="button" class="btn btn-primary btn-c" id="pwCheckBtn" value="비밀번호 확인" />
									</td>
								</tr>
								<tr>
									<td class="td-h">새 비밀번호</td>
									<td class="td-b">
										<input type="password" id="pwNew" class="form-control pwToggle" disabled="disabled" placeholder="특수문자 1자 포함(공백 불가), 8자 이상"/>
										<span id="checkpw" class="form-text"></span>
									</td>
									<td class="td-e">
									</td>
								</tr>
								<tr>
									<td class="td-h">새 비밀번호 재확인</td>
									<td class="td-b">
										<input type="password" id="pwNewCheck" class="form-control pwToggle" disabled="disabled"/>
									</td>
									<td class="td-e">
									</td>
								</tr>
							</tbody>
						</table>
						<div class="btn-container">
							<input type="button" class="btn btn-primary btn-c" id="pwChangeBtn" value="비밀번호 변경" disabled="disabled"/>
						</div>
					</div>
				</div>
				<!-- 비밀번호 변경 div 영역 끝 -->
			</div>
			<!-- 본문 영역 끝 -->
		</main>
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function () {
		// 사용자 권한
		let authCode = "${princ.user.authCode }";

		// 탭 클릭 ---------------------------------------------------
		let contentTitle = $("#contentTitle")[0];		// 현재 화면 이름
		let contentDesc = $("#contentDesc")[0];			// 현재 화면 설명
		
		// 메인 탭을 클릭하면
		$(".tab-item").on("click", function() {
			// 현재 선택한 탭만 active class를 적용한다.
			$(".tab-item").removeClass("active");
			$(this).addClass("active");

			// 현재 선택한 탭의 data-tab과 동일한 id를 가진 탭 영역만 active class를 적용한다.
			$(".mainTabDiv").removeClass("active");
			let mainTabDiv = $(this).data("tab");
			$('#' + mainTabDiv).addClass("active");
		});
		
		// 탭 클릭 시 그에 맞춰 화면 이름과 설명 수정
		$("#myProfileTab").on('click', function () {
			contentTitle.innerText = "내 프로필";
			contentDesc.innerText = "타인에게 공개되는 내 정보 화면을 확인합니다.";
			
			location.reload();
			
			// 비밀번호 변경 탭 초기화
			$('#pwOld').val("");
			$('#pwNew').val("");
			$('#pwNewCheck').val("");
        	$('#pwCheckBtn')[0].disabled = false;
			$('#pwOld')[0].disabled = false;
        	$("#pwChangeBtn")[0].disabled = true;
        	$("#pwNew")[0].disabled = true;
        	$("#pwNewCheck")[0].disabled = true;
		});
		$("#myInfoTab").on('click', function () {
			contentTitle.innerText = "내 정보";
			contentDesc.innerText = "내 계정의 업체 및 담당자 정보를 확인하고 수정합니다.";
			
			// 비밀번호 변경 탭 초기화
			$('#pwOld').val("");
			$('#pwNew').val("");
			$('#pwNewCheck').val("");
        	$('#pwCheckBtn')[0].disabled = false;
			$('#pwOld')[0].disabled = false;
        	$("#pwChangeBtn")[0].disabled = true;
        	$("#pwNew")[0].disabled = true;
        	$("#pwNewCheck")[0].disabled = true;
		});
		$("#myPwChangeTab").on('click', function () {
			contentTitle.innerText = "비밀번호 변경";
			contentDesc.innerText = "현재 비밀번호 검증 후에 비밀번호를 변경합니다.";
		});
		
		// 내 프로필 -------------------------------------------------------------------------------------
		// 관세사 하단 탭 클릭
		$(".categories-title").on('click', function () {
			// 현재 선택한 탭만 active class를 적용한다.
			$(".categories-title").removeClass("active");
			$(this).addClass("active");

			// 현재 선택한 탭의 data-tab과 동일한 id를 가진 탭 영역만 active class를 적용한다.
			$(".category-options").removeClass("active");
			let tab = $(this).data("tab");
			$('#' + tab).addClass("active");
		});
		
		// 지도 생성
		let address1 = $('#userAddr').val(); // 기본주소값
		let address2 = $('#userDetAddr').val(); // 상세주소값
		if (address1 && address1.trim() !== "") { // 기본주소 내용이 입력되어 있다면
			let $mapContainer = $("#map"); // 지도
			$mapContainer.show(); // 지도 가시화

			let mapDomElement = $mapContainer[0];

			let mapOption = {
				center : new kakao.maps.LatLng(33.450701, 126.570667),
				level : 3
			};

			let map = new kakao.maps.Map(mapDomElement, mapOption);
			let geocoder = new kakao.maps.services.Geocoder();

			geocoder.addressSearch (
				address1 + " " + address2,
				function(result, status) {
					if (status === kakao.maps.services.Status.OK) {
						let coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						let marker = new kakao.maps.Marker({
							map : map,
							position : coords
						});
						let infowindow = new kakao.maps.InfoWindow({
							content : '<div style="width:150px;text-align:center;padding:6px 0;">사무실 위치</div>'
						});
						infowindow.open(map, marker);
						map.setCenter(coords);
					} else {
						console.error("주소 검색 실패:", status);
					}
				});
		} else {
			let $mapContainer = $("#map");
			if ($mapContainer.length) {
				$mapContainer.hide();
			}
			console.log("주소 정보가 없어서 지도를 생성하지 않습니다.");
		}
		
		// 내 정보 -------------------------------------------------------------------------------------
		// 정보에 맞춰 체크박스 상태 반영하기 ---------------------------------------------------
		// SMS 수신 승인여부에 따라 체크박스 체크
        if(${userVO.smsYn }) {
        	$('#smsYn').attr("checked", true);
        }
     	// EMAIL 수신 승인여부에 따라 체크박스 체크
        if(${userVO.emailYn }) {
        	$('#emailYn').attr("checked", true);
        }
		// 관세사 주력분야에 맞춰 체크박스 체크
		let checkbox = $(".checkbox");
		let ccaVO = '${userVO.ccaVO}';
		if(ccaVO != "") {
			let specialtyCodeListStr = "${userVO.ccaVO.ccaSpecialtyCodeList}";
			let specialtyCodeList = JSON.parse(specialtyCodeListStr);
	        for(let i = 0; i < specialtyCodeList.length; i++) {
	        	let specialty = specialtyCodeList[i];
	        	checkbox[specialty-1].checked = true;
	        }
		}
		
		// profileBtn 버튼 클릭 이벤트
		$('.profileBtn').on('click', function () {
			// display:none 상태인 file input 클릭 이벤트 발생시킴
			$('#hiddenProfileFileInput').click();
		});
		
		// profile 사진 관련 변수를 다른 곳에서도 활용하기 위해 변수를 미리 선언
		let file = null;
		let formData = new FormData();
		let reader = new FileReader();
		
		// file input change 이벤트
		$('#hiddenProfileFileInput').on('change', function(event) {
        	file = event.target.files[0]; // 선택된 파일
        	if (file) { // 파일이 존재하면
        		if (file.type.startsWith('image/')) { // 이미지 파일이 맞으면
        			// 미리보기로 바로 반영
                  	reader.onload = function(e) {
						$('.profileImg').attr('src', e.target.result);
					}
					reader.readAsDataURL(file);
					
					// 폼데이터에 저장
					formData.append('profileImage', file);
        		} else {
        			$.confirm({
 		               title: '프로필 이미지 선택',
 		               content: '이미지 파일만 선택 가능합니다.',
 		               buttons: {
 		                  "확인": function() {
 		                  },
 		               }
 		        	});
				}
        	}
        });
		
		// updateBtn 버튼 클릭 이벤트 ---------------------------------------------------
		$('#updateBtn').on('click', function () {
			let btnText = $('#updateBtn')[0].value;

			// updateBtn 버튼의 Text가 '수정'이면 true
			if(btnText == "수정") {
				// 프로필 수정 버튼 활성화
				$(".profileBtn")[0].style.display = "";
				// 수정 가능한 input readonly 비활성화
				let toggleInfo = $(".toggleInfo");
				for (let i = 0; i < toggleInfo.length; i++) {
					toggleInfo[i].readOnly = false;
				}
				// 우편번호찾기 버튼 활성화
				$("#zipbtn")[0].style.display = "";
				// sms수신동의 체크박스 활성화
				$("#smsYn")[0].disabled = false;
				// email수신동의 체크박스 활성화
				$("#emailYn")[0].disabled = false;
				// 관세사주력분야 체크박스 활성화
				let checkbox = $(".checkbox");
				for (let i = 0; i < checkbox.length; i++) {
					checkbox[i].disabled = false;
				}
				// updateBtn 버튼의 Text를 '저장'으로 변경
				$('#updateBtn')[0].value = "저장";
				// 회원탈퇴 버튼 비활성화
				$("#deleteBtn")[0].style.display = "none";
			}
			
			// updateBtn 버튼의 Text가 '저장'이면 true
			if(btnText == "저장") {
				// 입력항목 검토 ---------------------------------------------------------
				// 업체정보
				let userTel = $('#userTel').val();
				if (!userTel) {
					$.confirm({
 		               title: '내 정보 필수 입력항목',
 		               content: '전화번호를 입력해주세요.',
 		               buttons: {
 		                  "확인": function() {
 		                  },
 		               }
 		        	});
					$('#userTel').focus();
					return;
				}
				
				let userPost = $('#userPost').val();
				if (!userPost) {
					$.confirm({
 		               title: '내 정보 필수 입력항목',
 		               content: '주소를 입력해주세요.',
 		               buttons: {
 		                  "확인": function() {
 		                  },
 		               }
 		        	});
					$('#userAddr').focus();
					return;
				}
				
				let userDetAddr = $('#userDetAddr').val();
				if (!userDetAddr) {
					$.confirm({
 		               title: '내 정보 필수 입력항목',
 		               content: '상세주소를 입력해주세요.',
 		               buttons: {
 		                  "확인": function() {
 		                  },
 		               }
 		        	});
					$('#userDetAddr').focus();
					return;
				}

				// 관세사의 경우 주력분야
				if(ccaVO != "") {
					let checkbox  = $(".checkbox");
					let cnt = 0;
					for (let i = 0; i < checkbox .length; i++) {
						if(checkbox[i]) {
							cnt++;
						}
					}
					if(cnt<0) {
						$.confirm({
	 		               title: '내 정보 필수 입력항목',
	 		               content: '주력분야를 하나 이상 선택해주세요.',
	 		               buttons: {
	 		                  "확인": function() {
	 		                  },
	 		               }
	 		        	});
						$('.checkbox')[0].focus();
						return;
					}
				}
				
				// 담당자정보
				let userName = $('#userName').val();
				if (!userName) {
					$.confirm({
 		               title: '내 정보 필수 입력항목',
 		               content: '담당자 이름을 입력해주세요.',
 		               buttons: {
 		                  "확인": function() {
 		                  },
 		               }
 		        	});
					$('#userName').focus();
					return;
				}
				
				let userPhone = $('#userPhone').val();
				if (!userPhone) {
					$.confirm({
 		               title: '내 정보 필수 입력항목',
 		               content: '담당자 핸드폰번호를 입력해주세요.',
 		               buttons: {
 		                  "확인": function() {
 		                  },
 		               }
 		        	});
					$('#userPhone').focus();
					return;
				}
				
				// userPhone 양식에 맞는지 확인
				let checkPhone = $('#checkPhone');
				$("#userPhone").on("blur", function formatPhoneNumber() {
			        if (userPhone.length === 11) {
			        	userPhone = userPhone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'); // 형식 지정
			        	$("#userPhone").val(userPhone);
			        	checkPhone.style.color = 'blue';
			        	checkPhone.innerHTML = '핸드폰번호 형식입니다!';
			        } else {
			        	checkPhone.style.color = 'red';
			        	checkPhone.innerHTML = '핸드폰번호 형식은 숫자 11자리 입니다.';
			        	return;
			        }
			    });
				
				let userEmail = $('#userEmail').val();
				if (!userEmail) {
					$.confirm({
 		               title: '내 정보 필수 입력항목',
 		               content: '담당자 이메일을 입력해주세요.',
 		               buttons: {
 		                  "확인": function() {
 		                  },
 		               }
 		        	});
					$('#userEmail').focus();
					return;
				}
				
				// userEmail 양식에 맞는지 확인
				$("#userEmail").on("blur",function validateEmail() {
					let checkEmail = $('#checkEmail');
					let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
				    if (emailPattern.test(emailInput)) {
						checkEmail.style.color = 'blue';
				    	checkEmail.innerHTML = '이메일 형식입니다!';
				    } else {
				    	checkEmail.style.color = 'red';
				    	checkEmail.innerHTML = '유효한 이메일 형식을 입력해 주세요. 예: example@example.com';
				        return;
				    }
				});  
				
				// 관세사의 주력분야를 배열로 저장
				let specialtyList = [];
				$('input[name="specialtys"]:checked').each(function() {
					specialtyList.push($(this).val());
				});

				
				// 입력정보를 formData에 추가
				let infoData = {
					// 계정정보
					"authCode"			: "${princ.user.authCode }",
					// 업체정보
					"userTel" 			: userTel,
					"userPost" 			: userPost,
					"userAddr" 			: $('#userAddr').val(),
					"userDetAddr" 		: userDetAddr,
					"specialtyList" 	: specialtyList,
					// 담당자정보
					"userName" 			: userName,
					"userPhone" 		: userPhone,
					"smsYn" 			: $('#smsYn').is(':checked'),
					"userEmail" 		: userEmail,
					"emailYn" 			: $('#emailYn').is(':checked'),
					"userFax" 			: $('#userFax').val()
				}
				formData.append('infoData', JSON.stringify(infoData));
				
				// 프로필사진정보를 formData에 추가
				if (file != null) {
					formData.append('file', file);
				}
				
				// formData를 서버에 전송
				$.ajax({
					url: "/myPage/myInfoUpdate",
					method: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success : function(result) {
						if(result != null && result != "") {
							$.confirm({
		 		               title: '프로필 수정',
		 		               content: '정상적으로 수정되었습니다.',
		 		               buttons: {
		 		                  "확인": function() {
		 		                  },
		 		               }
		 		        	});
						}
					},
					error : function(error, status, thrown) {
						console.log("error : {}", error);
						if(result != null && result != "") {
							$.confirm({
		 		               title: '프로필 수정',
		 		               content: '수정중 오류가 발생했습니다.',
		 		               buttons: {
		 		                  "확인": function() {
		 		                  },
		 		               }
		 		        	});
						}
					}
				});
				
				// 프로필 수정 버튼 비활성화
				$(".profileBtn")[0].style.display = "none";
				// 수정 가능한 input readonly 활성화
				let toggleInfo = $(".toggleInfo");
				for (let i = 0; i < toggleInfo.length; i++) {
					toggleInfo[i].readOnly = true;
				}
				// 우편번호찾기 버튼 비활성화
				$("#zipbtn")[0].style.display = "none";
				// sms수신동의 체크박스 비활성화
				$("#smsYn")[0].disabled = true;
				// email수신동의 체크박스 비활성화
				$("#emailYn")[0].disabled = true;
				// 관세사주력분야 체크박스 비활성화
				let checkbox = $(".checkbox");
				for (let i = 0; i < checkbox.length; i++) {
					checkbox[i].disabled = true;
				}
				// updateBtn 버튼의 Text를 '수정'으로 변경
				$('#updateBtn')[0].value = "수정";
				// 회원탈퇴 버튼 활성화
				$("#deleteBtn")[0].style.display = "";
			}
		});
		
		// 회원탈퇴 버튼 클릭 이벤트 -----------------------------------------------------
		$("#deleteBtn").on('click', function() {
			let userPw = prompt('탈퇴를 진행합니다. 동의하시면 계정의 비밀번호를 입력해주세요.');
			let userData = {
				userId: "${princ.user.userId}",
				userPw: userPw
			}
			// 비밀번호 확인 후 success일 경우 탈퇴 진행
			$.ajax({
				url: "/myPage/checkPw",
				method: "POST",
				dataType: "text",
                data: JSON.stringify(userData),
                contentType: 'application/json',
                success : function(result) {
                	if(result != null && result != "") {
                    	console.log(result);
						$.ajax({
							url: "/myPage/myInfoDelete",
							method: "POST",
							dataType: "text",
			                data: JSON.stringify(userData),
			                contentType: 'application/json',
			                success : function(result) {
			                	console.log(result);
								if(result != null && result != "") {
									$.confirm({
				 		               title: '회원 탈퇴',
				 		               content: '정상적으로 탈퇴 처리되었습니다.',
				 		               buttons: {
				 		                  "확인": function() {
				 		                  },
				 		               }
				 		        	});
								}
							},
							error : function(error, status, thrown) {
								console.log("error : {}", error);
								$.confirm({
			 		               title: '회원 탈퇴',
			 		               content: '탈퇴 처리중 오류가 발생했습니다.',
			 		               buttons: {
			 		                  "확인": function() {
			 		                  },
			 		               }
			 		        	});
							}
			        	});
					}
				},
				error : function(error, status, thrown) {
					console.log("error : {}", error);
					$.confirm({
 		               title: '회원 탈퇴',
 		               content: '비밀번호가 정확하지 않습니다.',
 		               buttons: {
 		                  "확인": function() {
 		                  },
 		               }
 		        	});
				}
        	});
		});
		
		// 비밀번호 변경 -------------------------------------------------------------------------------------
		// 비밀번호 확인 버튼 이벤트
		$('#pwCheckBtn').on('click', function() {
			
			// 로그인사용자 정보를 담는다.
			let userData = {
				userId: "${princ.user.userId}",
				userPw : $('#pwOld').val()
			}
			
			// 비밀번호 확인 후 success일 경우 탈퇴 진행
			$.ajax({
				url: "/myPage/checkPw",
				method: "POST",
				dataType: "text",
                data: JSON.stringify(userData),
                contentType: 'application/json',
                success : function(result) {
                	if(result != null && result != "") {
                    	console.log(result);
                    	$('#pwCheckBtn')[0].disabled = true;
                    	$('#pwOld')[0].disabled = true;
                    	$("#pwNew")[0].disabled = false;
                    	$("#pwNewCheck")[0].disabled = false;
					}
				},
				error : function(error, status, thrown) {
					console.log("error : {}", error);
					$.confirm({
 		               title: '비밀번호 변경',
 		               content: '비밀번호가 정확하지 않습니다.',
 		               buttons: {
 		                  "확인": function() {
 		                  },
 		               }
 		        	});
				}
        	});
			$('#pwOld').val("");
		});
		
		// 비밀번호 재확인 입력 시 비밀번호 일치 및 양식 확인
		$("#pwNewCheck").on("blur",function checkPasswordMatch() {
			let password = $('#pwNew').val();
			let confirmPassword = $('#pwNewCheck').val();
			let checkpw = document.getElementById('checkpw'); // 알림을 표시할 요소
			let passwordCriteria = /^(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$/;
		
		    if (password !== confirmPassword) {
		        checkpw.style.color = 'red';
		        checkpw.innerHTML = ' 비밀번호가 일치하지 않습니다.';
		    } else if (!passwordCriteria.test(password)) {
		        checkpw.style.color = 'orange';
		        checkpw.innerHTML = ' 비밀번호는 8자리 이상이며 특수문자를 하나 이상 포함해야 합니다.';
		    } else {
		        checkpw.style.color = 'blue';
		        checkpw.innerHTML = ' 비밀번호가 일치합니다.';
		        $("#pwChangeBtn")[0].disabled = false;
		    }
		});

		// 비밀번호 변경 버튼 이벤트
		$('#pwChangeBtn').on('click', function() {
			// 로그인사용자 정보를 담는다.
			let userData = {
				userId: "${princ.user.userId}",
				userPw : $('#pwNew').val()
			}
			
			$.ajax({
				url: "/myPage/changePw",
				method: "POST",
				dataType: "text",
	            data: JSON.stringify(userData),
	            contentType: 'application/json',
	            success : function(result) {
	            	console.log(result);
					if(result != null && result != "") {
						$.confirm({
			               title: '비밀번호 변경',
			               content: '정상적으로 수정 처리되었습니다.',
			               buttons: {
			                  "확인": function() {
			                  },
			               }
			        	});
					}
				},
				error : function(error, status, thrown) {
					console.log("error : {}", error);
					$.confirm({
		               title: '비밀번호 변경',
		               content: '수정 처리중 오류가 발생했습니다.',
		               buttons: {
		                  "확인": function() {
		                  },
		               }
		        	});
				}
	    	});
			$('#pwOld').val("");
			$('#pwNew').val("");
			$('#pwNewCheck').val("");
        	$('#pwCheckBtn')[0].disabled = false;
			$('#pwOld')[0].disabled = false;
        	$("#pwChangeBtn")[0].disabled = true;
        	$("#pwNew")[0].disabled = true;
        	$("#pwNewCheck")[0].disabled = true;
		});
		

		// 주소찾기 버튼 클릭 이벤트 ---------------------------------------------------
		$('#zipbtn').on('click', function() {
			// Daum 카카오의 우편번호 검색
			new daum.Postcode({
		        oncomplete: function(data) {
		            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            let addr = ''; 			// 주소 변수
		            let extraAddr = ''; 	// 참고항목 변수
		
		            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                addr = data.roadAddress;
		            } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                addr = data.jibunAddress;
		            }
		
		            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		            if(data.userSelectedType === 'R'){
		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                if(extraAddr !== ''){
		                    extraAddr = ' (' + extraAddr + ')';
		                }
		                // 조합된 참고항목을 해당 필드에 넣는다.
		                $("#extraAddress").val(extraAddr);
		            } else {
		            	$("#extraAddress").val('');
		            }
					
		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
		            $("#userPost").val(data.zonecode);
		            $("#userAddr").val(addr);
		            // 커서를 상세주소 필드로 이동한다.
		            $("#userDetAddr").focus();
		        }
		    }).open();
		});
		
	});
</script>
</html>