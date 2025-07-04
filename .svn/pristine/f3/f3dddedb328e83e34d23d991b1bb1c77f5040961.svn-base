<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검사검역 리스트 페이지</title>	
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">

<style type="text/css">

.status-chip {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 12px;
    font-size: 0.85em;
    font-weight: bold;
    color: #fff;
}
.status-completed {
    background-color: #007bff;
}
.status-pending {
    background-color: #ffc107;
    color: #333;
}
</style>
</head>
<body>
<sec:authentication property="principal" var="princ"/>
<c:if test="${princ ne 'anonymousUser'}">
	<sec:authentication property="principal.user" var="user" />
	<sec:authentication property="authorities" var="auth"/>
</c:if>

<div class="app-container">
	<main class="main-content-area">
		<div class="content-header">
		   <div class="breadcrumb-warp">
		      <div class="col-sm-12">
		         <ol class="breadcrumb">
		            <li class="breadcrumb-item"><a href="/">Home</a></li>
		            <li class="breadcrumb-item"><a href="#">나의 업무(현장)</a></li>
		         </ol>
		      </div>
		   </div>
		
		   <div class="content-title">나의 업무(현장)</div>
		   <p class="desc">접수된 자신의 업무를 확인하는 페이지입니다.</p>
		   </div>

		<div class="section">
			<div class="search-filter-section">
			    <div class="filter-group">
			        <select id="searchType" class="form-select">
			            <option value="">검색 타입</option>
			            <option value="declDNo" ${pagingVO.searchType == 'declDNo' ? 'selected' : ''}>접수번호</option>
			            <option value="contractNo" ${pagingVO.searchType == 'contractNo' ? 'selected' : ''}>대리업무 번호</option>
			            <option value="userName" ${pagingVO.searchType == 'userName' ? 'selected' : ''}>담당자</option>
			            <option value="qrntStatusCode" ${pagingVO.searchType == 'qrntStatusCode' ? 'selected' : ''}>진행상태</option>
			            <option value="qrntType" ${pagingVO.searchType == 'qrntType' ? 'selected' : ''}>검사 유형</option>
			        </select>
			        
				    <select id="sortColumn" class="form-select">
				        <option value="" ${empty pagingVO.sortColumn ? 'selected' : ''}>정렬 속성</option>
				        <option value="DECL_D_NO" ${pagingVO.sortColumn == 'DECL_D_NO' ? 'selected' : ''}>접수번호</option>
				        <option value="CONTRACT_NO" ${pagingVO.sortColumn == 'CONTRACT_NO' ? 'selected' : ''}>수출입 구분</option>
				        <option value="USER_NAME" ${pagingVO.sortColumn == 'USER_NAME' ? 'selected' : ''}>담당자</option>
				        <option value="QRNT_RECEPT_DATE" ${pagingVO.sortColumn == 'QRNT_RECEPT_DATE' ? 'selected' : ''}>접수일</option>
				        <option value="QRNT_ANTC" ${pagingVO.sortColumn == 'QRNT_ANTC' ? 'selected' : ''}>예정완료일</option>
				        <option value="QRNT_STATUS_CODE" ${pagingVO.sortColumn == 'QRNT_STATUS_CODE' ? 'selected' : ''}>진행 상태</option>
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
				<span>
					"${pagingVO.searchWord}"에 대한 검색 결과 입니다. 총 ${pagingVO.totalRecord}건
				</span>
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
		                    <th align="center">접수일</th>
		                    <th align="center">예정완료일</th>
		                </tr>
		            </thead>
		            <tbody>
		            	<c:choose>
		            		<c:when test="${empty pagingVO.dataList}">
							    <tr>
							        <td colspan="8" align="center">조회된 검사검역 신청 내역이 없습니다.</td>
							    </tr>
		            		</c:when>
		            		<c:otherwise>
				            	<c:forEach items="${pagingVO.dataList }" var="qrnt" varStatus="status"> 
					                <tr>
					                    <td align="center">${pagingVO.startRow + status.index}</td>
					                    <td align="center"><a href="/servant/inspectReviewDetail.do?declNo=${qrnt.DECL_NO}">${qrnt.DECL_D_NO }</a></td>
					                    <td align="center">${qrnt.CONTRACT_NO }</td>
					                    <td align="center">
						                    <c:choose>
						                    	<c:when test="${fn:startsWith(qrnt.CONTRACT_NO, 'IMP')}">
						                    		수입
						                    	</c:when>
						                    	<c:when test="${qrnt.CONTRACT_NO.startsWith('EXP') }">
						                    		수출
						                    	</c:when>
						                    	<c:otherwise>
						                    		${qrnt.CONTRACT_NO }
						                    	</c:otherwise>
						                    </c:choose>
					                    </td>
					                    <td align="center">${qrnt.EMP_NO } / ${qrnt.USER_NAME}</td>
					                    <td align="center">${qrnt.QRNT_TYPE }</td>
					                    <td align="center">
					                    	<c:choose>
					                    		<c:when test="${qrnt.QRNT_STATUS_CODE eq '검사 진행중'}">
							                    	<span class="status-chip status-completed">${qrnt.QRNT_STATUS_CODE }</span>
					                    		</c:when>
					                    		<c:when test="${qrnt.QRNT_STATUS_CODE eq '검사 대기'}">
							                    	<span class="status-chip status-pending">${qrnt.QRNT_STATUS_CODE }</span>
					                    		</c:when>
					                    		<c:otherwise>
							                    	<span >${qrnt.QRNT_STATUS_CODE }</span>
					                    		</c:otherwise>
					                    	</c:choose>
					                    </td>
					                    <td align="center"><fmt:formatDate value="${qrnt.QRNT_RECEPT_DATE }" pattern="yyyy-MM-dd"/></td>
					                    <td align="center"><fmt:formatDate value="${qrnt.QRNT_ANTC}" pattern="yyyy-MM-dd"/></td>
				                	</tr>
				            	</c:forEach>
		            		</c:otherwise>
		            	</c:choose>
		            </tbody>
		        </table>
			</div>
			<div class="table-footer" >
	      		<div class="pagination" id="pagingArea">
			   		${pagingVO.pagingHTML} <%-- 페이징 HTML 출력 --%>
				</div>
				<%-- 버튼
					<div class="btn-container">
					   <input type="button" id="submitBtn" value="새 공지 등록" class="btn btn-primary btn-r" />
					</div>
				 --%> 
			</div>
		</div>
	</main>
</div>
	
</body>
<script type="text/javascript">
$(function(){
	
	let baseUrl = "/servant/inspectReview.do";
	
	$("#searchWord").keypress(function(event) {
        if (event.which === 13) { // Enter 키 코드
            $("#searchBtn").click(); // 검색 버튼 클릭
        }
    });

	// 검색 버튼 클릭 이벤트
	$("#searchBtn").on("click", function () {
		let searchType = $("#searchType").val();
	    let searchWord = $("#searchWord").val();
	    let sortColumn = $("#sortColumn").val();
	    let sortDirection = $("#sortDirection").val();
	    
	    window.location.href = baseUrl + "?searchType=" + encodeURIComponent(searchType)
	                                + "&searchWord=" + encodeURIComponent(searchWord)
	                                + "&sortColumn=" + encodeURIComponent(sortColumn)
	                                + "&sortDirection=" + encodeURIComponent(sortDirection);
	});

    // 페이지 링크 클릭 이벤트
	$(document).on("click", ".page-link", function (event) {
		event.preventDefault(); // 기본 이벤트 제거
		    
	    let page = $(this).data("page");
	    
	    let searchType = $("#searchType").val();
	    let searchWord = $("#searchWord").val();
	    let sortColumn = $("#sortColumn").val();
	    let sortDirection = $("#sortDirection").val();
	    
	    if(!page){ 
	    	page = 1; 
	    }
	    
	    let url = baseUrl + "?page=" + encodeURIComponent(page)
	            + "&searchType=" + encodeURIComponent(searchType)
	            + "&searchWord=" + encodeURIComponent(searchWord)
	            + "&sortColumn=" + encodeURIComponent(sortColumn)
	            + "&sortDirection=" + encodeURIComponent(sortDirection);
	    
	    window.location.href = url;
    });
});
</script>
</html>