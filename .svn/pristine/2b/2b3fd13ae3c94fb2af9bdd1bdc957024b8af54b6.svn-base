<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 의뢰 현황</title>
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

.back-btn {
	color: #007bff;
	text-decoration: none;
	margin-right: 10px;
	font-size: 14px;
}

.container {
	background-color: #f8f9fa;
}

.page-title {
	font-size: 24px;
	font-weight: bold;
	color: #333;
	background-color: #f8f9fa;
}

.subtitle {
	color: #666;
	font-size: 14px;
	margin-bottom: 20px;
}

.search-section {
	background-color: #f8f9fa;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 20px;
}

.search-row {
	display: flex;
	align-items: center;
	gap: 15px;
	margin-bottom: 15px;
}

.search-input {
	flex: 1;
	padding: 8px 12px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
}

.filter-controls {
	display: flex;
	align-items: center;
	gap: 10px;
}

.filter-select {
	padding: 8px 12px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
	background-color: white;
}

.search-btn {
	background-color: #6c757d;
	color: white;
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
}

.table-container {
	overflow-x: auto;
	margin-bottom: 20px;
}

.status-badge {
	padding: 4px 8px;
	border-radius: 12px;
	font-size: 12px;
	font-weight: bold;
}

.status-complete {
	background-color: #d4edda;
	color: #155724;
}

.status-progress {
	background-color: #d1ecf1;
	color: #0c5460;
}

.status-pending {
	background-color: #fff3cd;
	color: #856404;
}

.download-btn {
	background: none;
	border: none;
	color: #007bff;
	cursor: pointer;
	font-size: 16px;
}

.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 10px;
	margin: 20px 0;
}

.pagination a {
	padding: 8px 12px;
	text-decoration: none;
	color: #007bff;
	border: 1px solid #dee2e6;
	border-radius: 4px;
}

.pagination .current {
	background-color: #007bff;
	color: white;
}

.submit-request-btn {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 12px 24px;
	border-radius: 6px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	display: block;
	margin: 20px auto;
}

.submit-request-btn:hover {
	background-color: #0056b3;
}

.request-id {
	color: #007bff;
	font-weight: bold;
}

.department {
	color: #6c757d;
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
							<li class="breadcrumb-item"><a
								href="/consignor/myContract.do">내 의뢰 현황</a></li>
						</ol>
					</div>
				</div>

				<div class="content-title">내 의뢰 현황</div>
				<p class="desc">요청 의뢰 상태를 확인하고 관리할 수 있습니다.</p>
			</div>
			<div class="container section">
				<!-- Search Section -->
				<form method="post" id="searchForm">
					<div class="search-filter-section">
						<div class="filter-group">
							<select class="form-select" name="searchType"
								id="searchTypeOption">
								<option value="">수/출입</option>
								<option value="수입"
									<c:if test="${searchType eq '수입' }">selected</c:if>>수입</option>
								<option value="수출"
									<c:if test="${searchType eq '수출' }">selected</c:if>>수출</option>
							</select> <select class="form-select" name="searchCategory"
								id="categoryArea">

							</select> <select class="form-select" name="searchStatus">
								<option value="">상태</option>
								<option value="대기"
									<c:if test="${searchStatus eq '대기' }">selected</c:if>>대기</option>
								<option value="완료"
									<c:if test="${searchStatus eq '완료' }">selected</c:if>>완료</option>
								<option value="반려"
									<c:if test="${searchStatus eq '반려' }">selected</c:if>>반려</option>
								<option value="거절"
									<c:if test="${searchStatus eq '거절' }">selected</c:if>>거절</option>
							</select>
								</div>
							<div class="search-input-wrapper">
								<div class="search-input-icon"></div>
								<input type="hidden" name="page" id="page" />
								 <input type="text" class="form-input search-input"
									placeholder="접수번호, 담당 관세사 검색" name="searchWord"
									value="${searchWord }">
							</div>
							<div class="filter-group">
								 <select id="sortDirection" class="form-select" name="sortDirection">
									<option>정렬 방향</option>
									<option value="오름" <c:if test="${sortDirection eq '오름'}">selected</c:if>>오랜된순</option>
									<option value="내림" <c:if test="${sortDirection eq '내림'}">selected</c:if>>최신순</option>
								</select>
							</div>
							<button class="btn btn-primary">검색</button>
					
					</div>
				</form>

				<!-- Data Table -->
				<div class="table-section">
					<table class="data-table">
						<thead>
							<tr>
								<th>접수 번호</th>
								<th>의뢰 타입</th>
								<th>담당 관세사</th>
								<th>접수 내역</th>
								<th>접수 상태</th>
								<th>접수일</th>
								<!-- <th>선박위치</th> -->
							</tr>
						</thead>
						<tbody>
							<c:set value="${pageVo.dataList }" var="contractList" />
							<c:choose>
								<c:when test="${empty contractList }">
									<tr>
										<td colspan="7">없슴</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${contractList }" var="c">
										<tr class="contractArea">
											<td><a href="/consignor/detailContract/${c.contractNo }">${c.contractNo}</a></td>
											<td>${c.contractType }</td>
											<td><span>${c.ccaName }</span></td>
											<c:if
												test="${(c.contractRecordList[0].statusCodeMediumCategoryName)  == null || (c.contractRecordList[0].statusCodeMediumCategoryName == '')}">
												<td><span>없음</span></td>
											</c:if>
											<c:if
												test="${(c.contractRecordList[0].statusCodeMediumCategoryName) !=null }">
												<td>${c.contractRecordList[0].statusCodeMediumCategoryName }</td>
											</c:if>
											<c:choose>
												<c:when
													test="${(c.contractRecordList[0].statusCodeName) eq '대기' ||(c.contractRecordList[0].statusCodeName) eq '완료'}">
													<td><strong style="color: green;">${c.contractRecordList[0].statusCodeName}</strong></td>
												</c:when>
												<c:otherwise>
													<td><strong style="color: red;">${c.contractRecordList[0].statusCodeName}</strong></td>
												</c:otherwise>
											</c:choose>
											<fmt:parseDate value="${c.contractDate }" var="parseDate"
												pattern="yyyy-MM-dd" />
											<td><fmt:formatDate value="${parseDate }"
													pattern="yyyy-MM-dd" /></td>
											<!-- <td><button class="ship-btn" data-con-no=${c.contractNo}>
												<i class="fas fa-ship"></i><i class="fas fa-eye"></i>
											</button></td> -->
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div class="table-footer">
						<div class="pagination" id="pagingArea">${pageVo.pagingHTML}</div>
					</div>

				</div>


				<!-- Submit Request Button -->
				<button class="submit-request-btn" id="goNewContract">📝 의뢰
					신청하기</button>
			</div>
		</main>
	</div>

	<script>
     $(function(){
    		let contractArea = $(".contractArea");
    		let goNewContract = $("#goNewContract");
    		let searchTypeOption = $("#searchTypeOption");
    		
    		
    		
    		goNewContract.on("click",function(){
    			location.href = "/consignor/ccaList.do";
    		})
    		
    		//페이지 네이션
    		let pagingArea = $("#pagingArea");
    		let searchForm = $("#searchForm");
    		
    		pagingArea.on("click","a",function(e){
    			e.preventDefault();
    			let pageNo = $(this).data("page");
				searchForm.find("#page").val(pageNo);
				searchForm.submit();
    			
    		})
    		
    	    
    	        
    	        // Enter key search
    	        document.querySelector('.search-input').addEventListener('keypress', function(e) {
    	            if (e.key === 'Enter') {
    	                document.querySelector('.search-btn').click();
    	            }
    	        });
    		
    		
			
			//searchTypeOption 바뀌었을때
			searchTypeOption.on("change",function(e){
				initOptions(e);
			});
			
			initOptions();
			
			function initOptions(e){
				let data = null;
				if(e == undefined){
					data = $("#searchTypeOption").val();
				}else{
					data = e.target.value;	
				}
				
				 $.ajax({
					url:"/cca/selectOptionCategory",
					type : "get",
					data : {data : data},
					success : function(result){
						/* console.log(result); */
						let categoryArea = $("#categoryArea");
						let html = ``;
						
						html += `<option value="">카테고리</option>`;
						let selectedCategory = '${searchCategory}';
						for(let i =0; i < result.length; i++){
							let category = result[i].statusCodeMediumCategoryName;
							let selectedAttr = ``;
							if(selectedCategory ==  category){
								selectedAttr = `selected`;
							}
							html+= `
								<option value="\${result[i].statusCodeMediumCategoryName}" \${selectedAttr}>\${result[i].statusCodeMediumCategoryName}</option>
							`;							
						}
						
						categoryArea.html(html);
					}
				});
			}
     })
    </script>
</body>
</html>