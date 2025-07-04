<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관세사 찾기페이지</title>
<%@ include file="../modules/header.jsp"%>
<%@ include file="../modules/sidebar.jsp"%>
<%@ include file="../modules/modal.jsp"%>
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

.header {
	padding: 20px;
	border-bottom: 1px solid #eee;
}

.header h1 {
	font-size: 20px;
	margin: 0;
	margin-bottom: 10px;
}

.header p {
	font-size: 14px;
	color: #666;
	margin: 0;
}

.search-container {
	padding: 15px 20px;
	display: flex;
	gap: 10px;
}

.search-box {
	flex: 1;
	position: relative;
	border: 1px solid #ddd;
	border-radius: 4px;
	display: flex;
	align-items: center;
}

.search-box i {
	padding: 0 10px;
	color: #999;
}

.search-box input {
	flex: 1;
	border: none;
	padding: 10px;
	outline: none;
	font-size: 14px;
}

.filter-container {
	display: flex;
	gap: 5px;
}

.filter-btn {
	padding: 8px 15px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background-color: white;
	font-size: 14px;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 5px;
}

.filter-btn.active {
	background-color: #f0f0f0;
}

.broker-list {
	padding: 0 20px;
}

.broker-item {
	padding: 20px 0;
	border-bottom: 1px solid #eee;
	display: flex;
	position: relative;
}

.broker-avatar {
	width: 60px;
	height: 60px;
	background-color: #eee;
	border-radius: 50%;
	margin-right: 15px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.broker-avatar i {
	font-size: 24px;
	color: #999;
}

.broker-info {
	flex: 1;
}

.broker-name {
	font-size: 16px;
	font-weight: bold;
	margin-bottom: 5px;
}

.broker-specialties {
	font-size: 13px;
	color: #666;
	margin-bottom: 10px;
}

.broker-meta {
	display: flex;
	font-size: 12px;
	color: #999;
	gap: 15px;
	margin-top: 10px;
}

.broker-meta div {
	display: flex;
	align-items: center;
	gap: 5px;
}

.broker-score {
	font-size: 22px;
	color: #4CAF50;
	font-weight: bold;
	margin-top: 5px;
}

.detail-btn {
	position: absolute;
	right: 0;
	top: 50%;
	transform: translateY(-50%);
	background-color: #4361ee;
	color: white;
	border: none;
	border-radius: 4px;
	padding: 8px 12px;
	font-size: 13px;
	cursor: pointer;
}

#marker1 {
	top: 10px;
	left: 50%;
	transform: translateX(-50%);
}

#marker2 {
	top: 63px;
	right: 20px;
}

#marker3 {
	top: 120px;
	right: 20px;
}

#marker4 {
	bottom: 20px;
	left: 50%;
	transform: translateX(-50%);
}
</style>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
							<li class="breadcrumb-item"><a href="/consignor/ccaList.do">관세사
									정보</a></li>
						</ol>
					</div>
				</div>

				<div class="content-title">관세사 정보</div>
				<p class="desc">수출입 통관을 도와줄 전문 관세사를 찾아보세요.</p>
			</div>
			<div class="container section">
				<!-- Progress Section -->
				<div class="progress-section">
					<div class="progress-bar-container">
						<div class="progress-bar">
							<div class="progress-step">
								<button class="step-circle active">1</button>
								<span class="step-label">관세사 선택</span>
							</div>
							<div class="progress-step">
								<button class="step-circle inactive">2</button>
								<span class="step-label">기본 정보 입력</span>
							</div>
							<div class="progress-step">
								<button class="step-circle inactive">3</button>
								<span class="step-label">서류 제출</span>
							</div>
						</div>
					</div>
				</div>

				
				<form method="post" id="searchForm">
					<div class="search-filter-section">
						<div class="search-input-wrapper">
							<div class="search-input-icon"></div>
							<input type="hidden" name="page" id="page" /> <input type="text"
								class="form-input search-input"
								placeholder="관세사 이름, 전문 분야, 지역 검색" name="searchWord"
								value="${searchWord }">
						</div>
						 <div class="filter-group">
					      <select class="form-select" name="searchType">
								<option value="">평점</option>
								<option value="내림"
									<c:if test="${searchType eq '내림' }">selected</c:if>>높은순</option>
								<option value="오름"
									<c:if test="${searchType eq '오름' }">selected</c:if>>낮은순</option>
								
							</select>
					      <button class="btn btn-primary">검색</button>
					   </div>
					</div>
				</form>
				
					<button class="filter-group" id="fieldBtn">
						<i class="fas fa-filter"></i> 전문 분야 <i class="fas fa-chevron-down"></i>
					</button>

				


				<!--ㅇㅇㅇ  -->
				<div class="search-container"
					style="font-size: small; display: none;" id="checkBoxShow">
					<div class="checkbox-container" id="checkboxContainer">
						<form action="">
							<div class="checkbox-item">
								<input type="checkbox" id="export-import" name="specialty"
									value="1"> <label for="export-import">수출입신고</label> <input
									type="checkbox" id="fta" name="specialty" value="2"> <label
									for="fta">FTA</label> <input type="checkbox"
									id="customs-valuation" name="specialty" value="3"> <label
									for="customs-valuation">관세환급</label> <input type="checkbox"
									id="hs-code" name="specialty" value="4"> <label
									for="hs-code">품목분류(HS CODE 분류)</label> <input type="checkbox"
									id="customs-investigation" name="specialty" value="5">
								<label for="customs-evaluation">관세평가</label> <input
									type="checkbox" id="customs-investigation" name="specialty"
									value="6"> <label for="customs-investigation">관세조사</label>
								<input type="checkbox" id="customs-consulting" name="specialty"
									value="7"> <label for="customs-consulting">관세/무역
									컨설팅</label> <input type="button" value="조회" id="searchCheckBox">
							</div>
						</form>
					</div>
				</div>
				<div class="broker-list" id="brokerList">
					<c:set value="${pageVo.dataList }" var="ccaList" />
					<!--  -->
					<c:choose>
						<c:when test="${empty ccaList}">
        			없삼
        		</c:when>
						<c:otherwise>
							<c:forEach items="${ccaList }" var="cca">
								<div class="broker-item">
									<div class="broker-avatar">
									
										<c:if test="${cca.ccaProfileImg == null or cca.ccaProfileImg == '' }">
												 <i class="fas fa-user"></i>
										</c:if>
										<c:if test="${!empty cca.ccaProfileImg }">
											<img style="border-radius: 50%" width="100%" height="100%"  src="/myPage/displayFile?fileName=${cca.ccaProfileImg}" >
										</c:if>
										
										
									</div>
									<div class="broker-info" data-cca-no=${cca.userNo}>
										<div class="broker-name">${cca.ccaName}</div>
										<c:forEach items="${cca.specialtyNameList }" var="name"
											varStatus="status">
											<span class="broker-specialties"> ${name.specialtyName }
												<c:if test="${!status.last }">
				                    	  			,
				                    	  		</c:if>
											</span>
										</c:forEach>
										<%-- <div class="broker-score">${cca.ccaSanctionScore }</div> --%>
										 <div class="broker-score">
										 	<%-- <fmt:formatNumber value="${cca.infallible}" pattern="#0.0" /> --%>
										 	${cca.infallible}%
										 </div> 
										<div class="broker-meta">
											<div>
												<i class="fas fa-location-dot"></i>${cca.ccaAddr}</div>
										</div>
									</div>
									<button id="detailBtn" class="detail-btn">상세 정보</button>
									<input type="hidden" id="ccaNo" value="${cca.userNo }">
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					<!--  -->

				</div>

				<div id="pagingArea" style="float: inline-start; margin-top: 20px">${pageVo.pagingHTML}</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
 	$(function(){
 		//작성중이던 계약이 있을때
 		
 		let checkBoxFlag = false;
 		let searchBox = $("#searchBox");
 		let brokerList = $("#brokerList");
 		
 		let fieldBtn = $("#fieldBtn"); //전문분야 버튼
 		let checkboxContainer = $("#checkboxContainer"); //체크박스 컨테이너
 		let checkBoxShow = $("#checkBoxShow"); //체크박스 div 
 		let searchCheckBox = $("#searchCheckBox"); //체크박스 버튼
 		
 		let detailBtn = $("#detailBtn"); //상세정보 버튼
 		let ccaNoVlaue = $("#ccaNo"); //관세사 userNo
 		
 		
 		//페이지네이션
 		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm");
 		
		pagingArea.on("click","a",function(e){
			e.preventDefault(); //a 태그가 가지고 있는 href동작을 막는다
			let pageNo = $(this).data("page"); //page no값
			
			if(!checkBoxFlag){
				searchForm.find("#page").val(pageNo);
				searchForm.submit();
			}
		
			console.log(checkBoxFlag)
			if(checkBoxFlag){
				//체크박스를 선택했을때
				let selected = [];
	 			$('input[name="specialty"]:checked').each(function(){
	 				selected.push($(this).val())
	 			})
				
				$.ajax({
	 				url: "/consignor/checkSpecialtyCodeList",
	 				type:"post",
	 				contentType : "application/json; charset=utf-8",
	 				data : JSON.stringify({specialtyNameList : selected , pageNo : pageNo}),
	 				success : function(result){
	 					console.log("결과 : ",result)
	 					checkBoxFlag = true;
	 				 	let html = ``;
	 					if(result.dataList.length > 0){
	 						brokerList.empty();
	 						
	 						for(let i =0 ; i<result.dataList.length;i++){
	 							html += `
							           <div class="broker-item">
						                <div class="broker-avatar">
						                <img style="border-radius: 50%" width="100%" height="100%" src="/myPage/displayFile?fileName=\${result.dataList[i].ccaProfileImg}" >
						                </div>
						                <div class="broker-info"  data-cca-no=\${result.dataList[i].userNo}>
						                    <div class="broker-name">\${result.dataList[i].ccaName}</div>
						                    `;
						                    for(let j = 0; j<result.dataList[i].specialtyNameList.length ; j++){
						                    	html+=`
						                    		<span class="broker-specialties">
					                    	  			\${result.dataList[i].specialtyNameList[j].specialtyName }
					                    	  			\${j<result.dataList[i].specialtyNameList.length -1 ? ',' : ''}
					                    	  		</span>
						                    	`;
						                    }
						                    html +=`
						                    <div class="broker-score">
						                    \${result.dataList[i].infallible }%
						                    </div>
						                    <div class="broker-meta">
						                        <div><i class="fas fa-location-dot"></i>\${result.dataList[i].ccaAddr}</div>
						                    </div>
						                </div>
						                <button class="detail-btn">상세 정보</button>
						            </div>
									
						           
									`;
	 							
	 						}
	 						
	 					}
	 					brokerList.html(html); 
	 		 			
	 					let pagingHtml = result.pagingHTML;
	 					pagingArea.html(pagingHtml); 
	 					
	 					
	 				},
	 				error(xhr,status,error){
	 					console.error(error);
	 				}
	 			})
	 			
	 			
			}
		})
 		
 		
 		
 		
 		fieldBtn.on("click",function(){
 			console.log("클릭")
 			checkBoxShow.toggle();
 		})
 		
 		searchCheckBox.on("click",function(){
 			console.log("ㅎㅇ")
 			let selected = [];
 			$('input[name="specialty"]:checked').each(function(){
 				selected.push($(this).val())
 			})
 			
 			console.log("선택분야 : " , selected)
 			let pageNo = $(this).data("page"); //page no값
			/* searchForm.find("#page").val(pageNo);
			searchForm.submit(); */
 			
 			$.ajax({
 				url: "/consignor/checkSpecialtyCodeList",
 				type:"post",
 				contentType : "application/json; charset=utf-8",
 				data : JSON.stringify({specialtyNameList : selected , pageNo : pageNo}),
 				success : function(result){
 					console.log("결과 : ",result)
 					checkBoxFlag = true;
 				 	let html = ``;
 					if(result.dataList.length > 0){
 						brokerList.empty();
 						
 						for(let i =0 ; i<result.dataList.length;i++){
 							html += `
						           <div class="broker-item">
					                <div class="broker-avatar">
					                <img style="border-radius: 50%" width="100%" height="100%" src="/myPage/displayFile?fileName=\${result.dataList[i].ccaProfileImg}" >
					                </div>
					                <div class="broker-info"  data-cca-no=\${result.dataList[i].userNo}>
					                    <div class="broker-name">\${result.dataList[i].ccaName}</div>
					                    `;
					                    for(let j = 0; j<result.dataList[i].specialtyNameList.length ; j++){
					                    	html+=`
					                    		<span class="broker-specialties">
				                    	  			\${result.dataList[i].specialtyNameList[j].specialtyName }
				                    	  			\${j<result.dataList[i].specialtyNameList.length -1 ? ',' : ''}
				                    	  		</span>
					                    	`;
					                    }
					                    html +=`
					                    <div class="broker-score"> \${result.dataList[i].infallible }%</div>
					                    <div class="broker-meta">
					                        <div><i class="fas fa-location-dot"></i>\${result.dataList[i].ccaAddr}</div>
					                    </div>
					                </div>
					                <button class="detail-btn">상세 정보</button>
					            </div>
								
					           
								`;
 							
 						}
 						
 					}
 					brokerList.html(html); 
 		 			
 					let pagingHtml = result.pagingHTML;
 					pagingArea.html(pagingHtml); 
 					
 					
 				},
 				error(xhr,status,error){
 					console.error(error);
 				}
 			})
 			
 			
 		})
 		
 		
 		searchBox.on("change",function(){
 			console.log(searchBox.val())
 			
 			performSearch();
 		})
 		

 		//
 		brokerList.on("click",".detail-btn",function(){
 			let ccaNo = $(this).closest(".broker-item").find(".broker-info").data("cca-no");
 			console.log("번호 : " + ccaNo);
			location.href = "/consignor/detailCcaProfile/" + ccaNo;			
 		})
 	})
 </script>
</body>
</html>