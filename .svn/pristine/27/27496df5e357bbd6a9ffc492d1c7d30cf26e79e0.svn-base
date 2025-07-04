<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수출입 통관 신고</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<style type="text/css">
.data-table th, .data-table td {
        text-align: center;
    }
</style>
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
		            <li class="breadcrumb-item"><a href="/servant/customsDeclaration.do">수출입 통관 신고</a></li>
		         </ol>
		      </div>
		      <!-- 브레드크럼 엘리먼트 끝 -->
		   </div>
		   <div class="content-title">수출입 통관 신고</div>
		   <p class="desc">접수된 모든 수출입 통관 업무를 확인하는 페이지입니다.</p>
		</div>
		<div class="section">
			<!-- 검색 엘리먼트 -->
			<div class="search-filter-section">
				<div class="filter-group">
			     	<select id="searchType" class="form-select">
			     		<option >검색 타입</option>
					    <option value="declDNo" ${pagingVO.searchType == 'declDNo' ? 'selected' : ''}>접수번호</option>
					    <option value="contractNo" selected >대리업무 번호</option>
					    <option value="consignorName" ${pagingVO.searchType == 'consignorName' ? 'selected' : ''}>신청인</option>
					    <option value="ccaName" ${pagingVO.searchType == 'ccaName' ? 'selected' : ''}>대리인</option>
					    <option value="statusCode" ${pagingVO.searchType == 'statusCode' ? 'selected' : ''}>절차 번호</option>
					</select>
		      	</div>
				<div class="search-input-wrapper">
			    	<div class="search-input-icon"></div>
			      	<input type="text" id="searchWord" class="form-input search-input" placeholder="검색, 정렬 조건을 선택하여 검색할 수 있습니다." 
			      	value="${pagingVO.searchWord != '' ? pagingVO.searchWord : ''}"
			      	/>
			    </div>
				<div class="filter-group">
					<select id="sortColumn" class="form-select">
						<option disabled selected>정렬 속성</option>
					    <option value="declDNO" ${pagingVO.sortColumn == 'declDNO' ? 'selected' : ''}>접수번호</option>
					    <option value="CONTRACTTYPE" ${pagingVO.sortColumn == 'CONTRACTTYPE' ? 'selected' : ''}>수출입 구분</option>
					    <option value="CONSIGNORNAME" ${pagingVO.sortColumn == 'CONSIGNORNAME' ? 'selected' : ''}>신청인</option>
					    <option value="CCANAME" ${pagingVO.sortColumn == 'CCANAME' ? 'selected' : ''}>대리인</option>
					    <option value="STATUSCODE" ${pagingVO.sortColumn == 'STATUSCODE' ? 'selected' : ''}>절차 번호</option>
					    <option value="DECLRECEPTDATE" ${pagingVO.sortColumn == 'DECLRECEPTDATE' ? 'selected' : ''}>접수일</option>
					</select>
			      
			      	<select id="sortDirection" class="form-select">
			      		<option disabled selected> 정렬 방향 </option>
					    <option value="ASC" ${pagingVO.sortDirection == 'ASC' ? 'selected' : ''}>오름차순</option>
					    <option value="DESC" ${pagingVO.sortDirection == 'DESC' ? 'selected' : ''}>내림차순</option>
					</select>
			      	<button id="searchBtn" class="btn btn-primary">검색</button>
		      	</div>
			</div>
			<!-- 검색 엘리먼트 끝 -->
			<c:if test="${not empty pagingVO.searchWord}">
				<span>
					"${pagingVO.searchWord}"의 검색 결과 입니다...
				</span>
			</c:if>
			<div class="table-section">
				<table class="data-table">
			        <thead>
			            <tr>
			                <th>번호</th>
			                <th>접수번호</th>
			                <th>대리업무 번호</th>
			                <th>수출입 구분</th>
			                <th>신청인</th>
			                <th>대리인</th>
			                <th>담당자</th>
			                <th>진행중인 업무</th>
			                <th>절차 번호</th>
			                <th>접수일</th>
			            </tr>
			        </thead>
			        <tbody>
				        <c:choose>
							<c:when test="${empty pagingVO.dataList}">
							    <tr>
							        <td colspan="11">조회된 업무가 없습니다.</td>
							    </tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="customs" items="${pagingVO.dataList}" varStatus="status" >
									<tr id="tr_index_${status.index}">
										<td id="td_index_${status.index}">
											${customs['RN']}
										</td>
									    <td id="td_declDNO_${status.index}">
								    		<a href="/servant/customsDetail.do?declDNo=${customs['DECLDNO']}&contractType=${customs['CONTRACTTYPE']}">
										        ${customs['DECLDNO']}
										    </a>
									    </td> 
										 <td id="td_contractType_${status.index}">
									    	${customs['CONTRACTNO']}
									    </td> 
							            <td id="td_contractType_${status.index}">
							            	${customs['CONTRACTTYPE']}
							            </td>
							            <td id="td_consignorName_${status.index}">
							            	${customs.CONSIGNORCOMPANYNAME} / ${customs.CONSIGNORNAME}
							            </td>
									    <td id="td_ccaName_${status.index}">
									    	${customs['CCANAME']}
									    </td>
									    <td id="td_svtNo${status.index}">
									    	${customs['SVTEMPNO']} / ${customs['SVTNAME']} 
									    </td>
									    <td id="td_mediumCategory_${status.index}"
									    	<c:choose>
										        <c:when test="${customs['STATUSCODENAME'] eq '대기'}">
										            class="text-warning fw-bold"
										        </c:when>
										        <c:when test="${customs['STATUSCODENAME'] eq '완료'}">
										            class="text-success fw-bold"
										        </c:when>
										        <c:when test="${customs['STATUSCODENAME'] eq '반려'}">
										            class="text-danger fw-bold"
										        </c:when>
											</c:choose>
										>
									    	${customs['MEDIUMCATEGORY']} ${customs['STATUSCODENAME']}
									    </td>
									    <td id="td_procedure_${status.index}">
									    	${customs['STATUSCODE']}
									    </td>
										<td id="td_date_${status.index}">
											<c:set var="declReceptDate" value="${customs['DECLRECEPTDATE']}" />
											<fmt:formatDate value="${declReceptDate}" pattern="yyyy-MM-dd" />
										</td>
									</tr>
					            </c:forEach>
							</c:otherwise>
						</c:choose>
			        </tbody>
			    </table>
			</div>
			<div class="table-footer" >
	      		<div class="pagination" id="pagingArea">
			   		${pagingVO.pagingHTML}
				</div>
			</div>
		</div>
	</main>
</div>
</body>
<script>
$(document).ready(function () {
	let baseUrl = "/servant/customsDeclaration.do"; 
	$("#searchWord").keypress(function(event) {			// 검색
        if (event.which === 13) { 
            $("#searchBtn").click(); 
        }
    });

	$("#searchBtn").on("click", function () {			// 검색
		let searchType = $("#searchType").val();
		let searchWord = $("#searchWord").val().trim();
		let sortColumn = $("#sortColumn").val();
        let sortDirection = $("#sortDirection").val();

        console.log("검색 유형 : ", searchType);
        console.log("검색어 : ", searchWord);
        console.log("정렬 속성 : ", sortColumn);
        console.log("정렬 순서 : ", sortDirection);
        
        window.location.href = baseUrl + "?searchType=" + encodeURIComponent(searchType)
								        + "&searchWord=" + encodeURIComponent(searchWord)
								        + "&sortColumn=" + encodeURIComponent(sortColumn)
								        + "&sortDirection=" + encodeURIComponent(sortDirection);
    });
	$(".page-link").on("click", function (event) {		// 페이징 이동
     	event.preventDefault(); 						// 기본 이벤트 제거 (클릭 시 페이지 새로고침 방지)
		
        let page = $(this).attr("data-page");
        
        let searchType = $("#searchType").val();
        let searchWord = $("#searchWord").val();
        let sortColumn = $("#sortColumn").val();
        let sortDirection = $("#sortDirection").val();

        console.log("현재 페이지 : ", page);
        console.log("검색 유형 : ", searchType);
        console.log("검색어 : ", searchWord);
        console.log("정렬 속성 : ", sortColumn);
        console.log("정렬 순서 : ", sortDirection);
        
        if(!page){page = 1;}					// 
        
        window.location.href = baseUrl + "?page=" + encodeURIComponent(page)
								        + "&searchType=" + encodeURIComponent(searchType)
								        + "&searchWord=" + encodeURIComponent(searchWord)
								        + "&sortColumn=" + encodeURIComponent(sortColumn)
								        + "&sortDirection=" + encodeURIComponent(sortDirection);
    });
});
</script>
</html>