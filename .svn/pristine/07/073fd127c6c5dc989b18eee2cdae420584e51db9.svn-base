<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공무원 검사검역 이력 페이지</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<style type="text/css">
.status-chip { display: inline-block; padding: 4px 10px; border-radius: 12px; font-size: 0.85em; font-weight: bold; color: #fff; }
.status-completed { background-color: #007bff; }
.status-pass { background-color: #28a745; }
.status-fail { background-color: #dc3545; }
</style>
</head>
<body>
<div class="app-container">
	<main class="main-content-area">
		<div class="content-header">
		   <div class="breadcrumb-warp">
		      <div class="col-sm-12">
		         <ol class="breadcrumb">
		            <li class="breadcrumb-item"><a href="/">Home</a></li>
		            <li class="breadcrumb-item"><a href="#" onclick="event.preventDefault()">검사·검역 업무</a></li>
		            <li class="breadcrumb-item active"><a href="#">검사·검역 심사이력</a></li>
		         </ol>
		      </div>
		   </div>
		   <div class="content-title">검사·검역 심사이력</div>
		   <p class="desc">완료된 검사검역 이력을 확인합니다.</p>
		</div>
		
		<div class="section">
			<div class="search-filter-section">
			    <div class="filter-group">
			        <select id="searchType" class="form-select">
			            <option value="">검색 타입</option>
			            <option value="declDNo" ${pagingVO.searchType == 'declDNo' ? 'selected' : ''}>접수번호</option>
			            <option value="contractNo" ${pagingVO.searchType == 'contractNo' ? 'selected' : ''}>대리업무 번호</option>
			            <option value="userName" ${pagingVO.searchType == 'userName' ? 'selected' : ''}>담당자</option>
			        </select>
			        <select id="sortColumn" class="form-select">
			            <option value="" ${empty pagingVO.sortColumn ? 'selected' : ''}>정렬 속성</option>
			            <option value="DECL_D_NO" ${pagingVO.sortColumn == 'DECL_D_NO' ? 'selected' : ''}>접수번호</option>
			            <option value="CONTRACT_NO" ${pagingVO.sortColumn == 'CONTRACT_NO' ? 'selected' : ''}>수출입 구분</option>
			            <option value="USER_NAME" ${pagingVO.sortColumn == 'USER_NAME' ? 'selected' : ''}>담당자</option>
			            <option value="QRNT_RECEPT_DATE" ${pagingVO.sortColumn == 'QRNT_RECEPT_DATE' ? 'selected' : ''}>접수일</option>
			            <option value="QRNT_COMPLETION" ${pagingVO.sortColumn == 'QRNT_COMPLETION' ? 'selected' : ''}>완료일시</option>
			            <option value="QRNT_YN" ${pagingVO.sortColumn == 'QRNT_YN' ? 'selected' : ''}>합격여부</option>
			            <option value="QRNT_TYPE" ${pagingVO.sortColumn == 'QRNT_TYPE' ? 'selected' : ''}>검사 유형</option>
			        </select>
			    </div>
			    <div class="search-input-wrapper">
			        <div class="search-input-icon"></div>
			        <input type="text" id="searchWord" class="form-input search-input" placeholder="검색, 정렬 조건을 선택하여 검색할 수 있습니다." 
			            value="${pagingVO.searchWord != '' ? pagingVO.searchWord : ''}"
			        />
			    </div>
			    <div class="filter-group">
			    
			        <select id="sortDirection" class="form-select">
			            <option value="" ${empty pagingVO.sortDirection ? 'selected' : ''}>정렬 방향</option>
			            <option value="DESC" ${pagingVO.sortDirection == 'DESC' ? 'selected' : ''}>내림차순</option>
			            <option value="ASC" ${pagingVO.sortDirection == 'ASC' ? 'selected' : ''}>오름차순</option>
			        </select>
			        <button id="searchBtn" class="btn btn-primary">검색</button>
			    </div>
			</div>
			
			<c:if test="${not empty pagingVO.searchWord}">
				<span>'${pagingVO.searchWord}'에 대한 검색 결과 입니다. (총 ${pagingVO.totalRecord}건)</span>
			</c:if>
		
			<div class="table-section">
		        <table class="data-table">
		            <thead>
		                <tr>
					        <th align="center">번호</th>
					        <th align="center">접수번호</th>
					        <th align="center">대리업무 번호</th>
					        <th align="center">수출입 구분</th>
					        <th align="center">담당자</th>
					        <th align="center">검사 유형</th>
					        <th align="center">진행 상태</th>
					        <th align="center">합격여부</th>
					        <th align="center">접수일자</th>
					        <th align="center">완료일자</th>
					    </tr>
		            </thead>
			            <tbody>
						    <c:choose>
						        <c:when test="${empty pagingVO.dataList}">
						            <tr>
						                <td colspan="10" align="center">조회된 이력이 없습니다.</td>
						            </tr>
						        </c:when>
						        <c:otherwise>
						            <c:forEach items="${pagingVO.dataList}" var="history" varStatus="status">
						                <tr>
						                    <td>${pagingVO.startRow + status.index}</td>
						                    <td><a href="#" class="popup-link" data-hcno="${history.HC_NO}">${history.DECL_D_NO}</a></td>
						                    <td>${history.CONTRACT_NO}</td>
						                    <td>
						                        <c:choose>
						                            <c:when test="${fn:startsWith(history.CONTRACT_NO, 'IMP')}">수입</c:when>
						                            <c:when test="${fn:substring(history.CONTRACT_NO, 0, 3) == 'EXP'}">수출</c:when>
						                        </c:choose>
						                    </td>
						                    <td>${history.EMP_NO} / ${history.USER_NAME}</td>
						                    <td>${history.QRNT_TYPE}</td>
						                    <td><span class="status-chip status-completed">${history.QRNT_STATUS_CODE}</span></td>
						                    <td>
						                        <c:choose>
						                            <c:when test="${history.QRNT_YN == 1}"><span class="status-chip status-pass">합격</span></c:when>
						                            <c:otherwise><span class="status-chip status-fail">불합격</span></c:otherwise>
						                        </c:choose>
						                    </td>
						                    <td><fmt:formatDate value="${history.QRNT_RECEPT_DATE}" pattern="yyyy-MM-dd"/></td>
						                    <td><fmt:formatDate value="${history.QRNT_COMPLETION}" pattern="yyyy-MM-dd"/></td>
						                </tr>
						            </c:forEach>
						        </c:otherwise>
						    </c:choose>
						</tbody>
		        </table>
		        <div id="pagingArea" class="table-footer">
			   		${pagingVO.pagingHTML}
			   </div>
			</div>
		</div>
	</main>
</div>
</body>
<script type="text/javascript">
$(function(){
	
	let baseUrl = "/servant/inspectHistory.do";
	
	$("#searchBtn").on("click", function(){
		const searchType = $("#searchType").val();
		const searchWord = $("#searchWord").val();
		const sortColumn = $("#sortColumn").val();
	    const sortDirection = $("#sortDirection").val();

		location.href = baseUrl + "?searchType=" + searchType
								+ "&searchWord=" + searchWord 
								+ "&sortColumn=" + sortColumn 
								+ "&sortDirection=" + sortDirection;
	});

	$("#searchWord").on("keydown", function(e){
		if (event.which === 13) { // Enter 키 코드
            $("#searchBtn").click(); // 검색 버튼 클릭
		}
	});
	

	$("#pagingArea").on("click", "a", function(event){
        event.preventDefault();
        let page = $(this).data("page");
		const searchType = $("#searchType").val();
		const searchWord = $("#searchWord").val();
        const sortColumn = $("#sortColumn").val();
	    const sortDirection = $("#sortDirection").val();

		let url = baseUrl + "?page=" + page 
						  + "&searchType=" + searchType 
						  + "&searchWord=" + searchWord 
						  + "&sortColumn=" + sortColumn 
						  + "&sortDirection=" + sortDirection;
		
		location.href = url;
    });
    
    $(".popup-link").on("click", function(event) {
        event.preventDefault();
        
        const hcNo = $(this).data("hcno");
        const url = "/servant/inspectReviewResult.do?hcNo=" + hcNo;
        
        window.open(url, "_blank", "width=965, height=900, top=100, left=100, scrollbars=yes, resizable=yes");
    });
});
</script>
</html>