<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>제재이력</title>
	<%@ include file="../modules/header.jsp" %>
	<%@ include file="../modules/sidebar.jsp" %>
	<%@ include file="../modules/modal.jsp" %>
	<link rel="stylesheet" href="/css/main.css" />
	<style>
		/* 메인 탭 스타일 */
		.mainTabDiv { /* 각 탭 영역 */
			display: none;
		}
		.mainTabDiv.active { /* 선택된 탭 영역 */
			display: block;
		}
		.filter-group.mainTabDiv { /* 각 탭 영역 */
			display: none;
		}
		.filter-group.mainTabDiv.active { /* 선택된 탭 영역 */
			display: flex;
		}
		.form-select {
			width: 160px !important;
		}
		.search-filter-section.sanctionS {
			display: flex;
			align-items: center; /* 세로 중앙 정렬 */
	        flex-wrap: wrap; /* 공간이 부족하면 다음 줄로 넘어가도록 설정 */
		}
	    .search-filter-section .form-input.search-input {
	        flex-grow: 1; /* 가능한 공간을 채움 */
	        min-width: 150px; /* 최소 너비 */
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
							<li class="breadcrumb-item"><a href="/servant/sanctionList.do">제재이력</a></li>
						</ol>
					</div>
				</div>
				<div id="contentTitle" class="content-title">제재이력</div>
				<p id="contentDesc" class="desc">제재건별 혹은 관세사별 제재이력을 조회합니다.</p>
			</div>
		
			<!--  본문 영역 시작 -->
			<div class="section">
				<!-- 검색 엘리먼트 -->
				<div class="search-filter-section">
					<!-- (제재건별) 검색영역 -->
					<div class="filter-group mainTabDiv sanctionS active">
				     	<select id="sSearchType" class="form-select">
				     		<option disabled selected>검색 타입</option>
						    <option value="userId" ${sPagingVO.searchType == 'userId' ? 'selected' : ''}>담당공무원</option>
						    <option value="declDNo" ${sPagingVO.searchType == 'declDNo' ? 'selected' : ''}>업무번호</option>
						    <option value="sanctioName" ${sPagingVO.searchType == 'sanctioName' ? 'selected' : ''}>제재사유</option>
						    <option value="ccaRegistrationNumber" ${sPagingVO.searchType == 'ccaRegistrationNumber' ? 'selected' : ''}>관세사번호</option>
						    <option value="ccaName" ${sPagingVO.searchType == 'ccaName' ? 'selected' : ''}>관세사명</option>
						</select>
			      	</div>
			      	<!-- 검색단어 -->
					<div class="search-input-wrapper mainTabDiv sanctionS active">
				    	<div class="search-input-icon"></div>
				      	<input type="text" id="sSearchWord" class="form-input search-input" placeholder="검색, 정렬 조건을 선택하여 검색할 수 있습니다." 
				      	value="${sPagingVO.searchWord != '' ? sPagingVO.searchWord : ''}"
				      	/>
				    </div>
				    <!-- 정렬 조건 -->
					<div class="filter-group mainTabDiv sanctionS active">
						<select id="sSortColumn" class="form-select">
							<option disabled selected>정렬 속성</option>
						    <option value="sanctionDate" ${sPagingVO.sortColumn == 'sanctionDate' ? 'selected' : ''}>제재발생일시</option>
						</select>
				      	<select id="sSortDirection" class="form-select">
				      		<option disabled selected>정렬 방향</option>
						    <option value="ASC" ${sPagingVO.sortDirection == 'ASC' ? 'selected' : ''}>오름차순</option>
						    <option value="DESC" ${sPagingVO.sortDirection == 'DESC' ? 'selected' : ''}>내림차순</option>
						</select>
				      	<button class="btn btn-primary searchBtn">검색</button>
			      	</div>
			      	<!-- (제재건별) 검색영역 끝 -->
			      	
			      	<!-- (관세사별) 검색영역 -->
					<!-- 검색타입 선택 -->
					<div class="filter-group mainTabDiv sanctionC">
				     	<select id="cSearchType" class="form-select">
				     		<option disabled selected>검색 타입</option>
				     		<option value="ccaRegistrationNumber" ${sPagingVO.searchType == 'ccaRegistrationNumber' ? 'selected' : ''}>관세사번호</option>
				     		<option value="ccaName" ${cPagingVO.searchType == 'ccaName' ? 'selected' : ''}>관세사명</option>
						</select>
			      	</div>
			      	<!-- 검색단어 -->
					<div class="search-input-wrapper mainTabDiv sanctionC">
				    	<div class="search-input-icon"></div>
				      	<input type="text" id="cSearchWord" class="form-input search-input" placeholder="검색, 정렬 조건을 선택하여 검색할 수 있습니다." 
				      	value="${cPagingVO.searchWord != '' ? cPagingVO.searchWord : ''}"
				      	/>
				    </div>
				    <!-- 정렬 조건 -->
					<div class="filter-group mainTabDiv sanctionC">
						<select id="cSortColumn" class="form-select">
							<option disabled selected>정렬 속성</option>
						    <option value="ccaName" ${cPagingVO.sortColumn == 'ccaName' ? 'selected' : ''}>관세사명</option>
						    <option value="ccaSanctionScore" ${cPagingVO.sortColumn == 'ccaSanctionScore' ? 'selected' : ''}>누적오류점수</option>
						    <option value="ccaSanctionCount" ${cPagingVO.sortColumn == 'ccaSanctionCount' ? 'selected' : ''}>오류발생건수</option>
						    <option value="ccaDeclCount" ${cPagingVO.sortColumn == 'ccaDeclCount' ? 'selected' : ''}>전체업무건수</option>
						</select>
				      	<select id="cSortDirection" class="form-select">
				      		<option disabled selected>정렬 방향</option>
						    <option value="ASC" ${cPagingVO.sortDirection == 'ASC' ? 'selected' : ''}>오름차순</option>
						    <option value="DESC" ${cPagingVO.sortDirection == 'DESC' ? 'selected' : ''}>내림차순</option>
						</select>
				      	<button class="btn btn-primary searchBtn">검색</button>
			      	</div>
			      	<!-- (관세사별) 검색타입 끝 -->
				</div>
				<!-- 검색 엘리먼트 끝 -->

				<!-- 탭 영역 -->
				<div class="support-tabs">
					<div id="sanctionSTab" class="tab-item active" data-tab="sanctionS">
						<i class="fas fa-question-circle tab-icon"></i> 제재건별 제재이력
					</div>
					<div id="sanctionCTab" class="tab-item" data-tab="sanctionC">
						<i class="fas fa-question-circle tab-icon"></i> 관세사별 제재이력
					</div>
				</div>
				
				<!-- 제재건별 제재이력 테이블 영역 -->
				<div id="sanctionS" class="table-section mainTabDiv active">
				    <table class="data-table" id="sanctionRecode">
				        <thead>
							<tr>
								<th>번호</th>
								<th>제재담당공무원</th>
								<th>제재발생업무일련번호</th>
								<th>제재사유</th>
								<th>제재발생일시</th>
								<th>관세사</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty sPagingVO.dataList}">
								    <tr>
								        <td colspan="6">조회된 결과가 없습니다.</td>
								    </tr>
								</c:when>
								<c:otherwise>
								    <c:forEach var="customs" items="${sPagingVO.dataList}" varStatus="status" >
								        <tr id="tr_index_${status.index}" >
								            <td>
								            	${customs['RN']}
							            	</td>
							            	 <td>
											    ${customs['USER_ID']} / ${customs['USER_NAME']}
								            </td>
								            <td>
								            	<c:set var="declPrefix" value="${fn:substring(customs['DECL_D_NO'], 0, 2)}" />
												<c:choose>
												    <c:when test="${declPrefix eq 'ID'}">
												        <c:set var="declUrl" value="${customs['DECL_D_NO']}&contractType=수입" />
												    </c:when>
												    <c:when test="${declPrefix eq 'ED'}">
												        <c:set var="declUrl" value="${customs['DECL_D_NO']}&contractType=수출" />
												    </c:when>
												</c:choose>
								            	<a href="/servant/customsDetail.do?declDNo=${declUrl }">
								            		${customs['DECL_D_NO']}
								            	</a>
								            </td>
								            <td>
								            	${customs['SANCTION_NAME']} (${customs['SANCTION_SCORE']}점)
								            </td>
								            <td>
												<fmt:formatDate value="${customs['SANCTION_DATE']}" pattern="yyyy-MM-dd" />
								            </td>
								            <td>
												${customs['CCA_REGISTRATION_NUMBERID']} / ${customs['CCA_NAME']}
										    </td>
								        </tr>
								    </c:forEach>
								</c:otherwise>
							</c:choose>
				        </tbody>
					</table>
					<div class="table-footer" >
			      		<div class="pagination paginationS" id="pagingArea">
					   		${sPagingVO.pagingHTML}
						</div>
					</div>
				</div>
				<!-- 제재건별 제재이력 테이블 영역 끝 -->
				
				<!-- 관세사별 제재이력 테이블 영역 -->
				<div id="sanctionC" class="table-section mainTabDiv">
				    <table class="data-table" id="sanctionRecode">
				        <thead>
							<tr>
								<th>번호</th>
								<th>관세사</th>
								<th>누적오류점수</th>
								<th>오류발생건수</th>
								<th>전체업무건수</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty cPagingVO.dataList}">
								    <tr>
								        <td colspan="5">조회된 결과가 없습니다.</td>
								    </tr>
								</c:when>
								<c:otherwise>
								    <c:forEach var="customs" items="${cPagingVO.dataList}" varStatus="status" >
								        <tr id="tr_index_${status.index}" >
								            <td>
								            	${customs['RN']}
							            	</td>
							            	<td>
							            	 	<a href="/servant/sanctionList.do?tabType=sanctionS&sSearchType=ccaRegistrationNumber&sSearchWord=${customs['CCA_REGISTRATION_NUMBER']}">
											    	${customs['CCA_REGISTRATION_NUMBER']} / ${customs['CCA_NAME']}
											    </a>
								            </td>
								            <td>
								            	${customs['CCA_SANCTION_SCORE']}
								            </td>
								            <td>
								            	${customs['CCA_SANCTION_COUNT']}
								            </td>
								            <td>
												${customs['CCA_DECL_COUNT']}
								            </td>
								        </tr>
								    </c:forEach>
								</c:otherwise>
							</c:choose>
				        </tbody>
					</table>
					<div class="table-footer" >
			      		<div class="pagination paginationC" id="pagingArea">
					   		${cPagingVO.pagingHTML}
						</div>
					</div>
				</div>

				<!-- 제재건별 제재이력 테이블 영역 끝 -->
			</div>
			
		</main>
	</div>
</body>
<script>
	$(document).ready(function () {

		let tabType = '${tabType}';
		let searchType = "";
        let searchWord = "";
        let sortColumn = "";
        let sortDirection = "";
        
		window.addEventListener('load', function() {
			$(".tab-item").removeClass("active");
			$('#' + tabType + 'Tab').addClass("active");

			// 현재 선택한 탭의 data-tab과 동일한 id를 가진 탭 영역만 active class를 적용한다.
			$(".mainTabDiv").removeClass("active");
			$('.' + tabType).addClass("active");
			$('#' + tabType).addClass("active");
		});
		
		// 메인 탭을 클릭하면
		$(".tab-item").on("click", function() {
			// 현재 선택한 탭만 active class를 적용한다.
			$(".tab-item").removeClass("active");
			$(this).addClass("active");

			// 현재 선택한 탭의 data-tab과 동일한 id를 가진 탭 영역만 active class를 적용한다.
			$(".mainTabDiv").removeClass("active");
			tabType = $(this).data("tab");
			$('.' + tabType).addClass("active");
			$('#' + tabType).addClass("active");
			
		});
		
		// 기본 URL
		let baseUrl = "/servant/sanctionList.do";
		
		// 엔터키로 검색
		$("#searchWord").keypress(function(event) {
	        if (event.which === 13) { 
	            $("#searchBtn").click();
	        }
	    });
		
		// 검색 버튼을 눌러 검색
		$(".searchBtn").on("click", function () {
			sSearchType = $("#sSearchType").val();
			sSearchWord = $("#sSearchWord").val();
			sSortColumn = $("#sSortColumn").val();
			sSortDirection = $("#sSortDirection").val();
			cSearchType = $("#cSearchType").val();
			cSearchWord = $("#cSearchWord").val();
			cSortColumn = $("#cSortColumn").val();
			cSortDirection = $("#cSortDirection").val();

	        window.location.href = baseUrl + "?tabType=" + encodeURIComponent(tabType)
	        								+ "&sSearchType=" + encodeURIComponent(sSearchType)
									        + "&sSearchWord=" + encodeURIComponent(sSearchWord)
									        + "&sSortColumn=" + encodeURIComponent(sSortColumn)
									        + "&sSortDirection=" + encodeURIComponent(sSortDirection)
	        								+ "&cSearchType=" + encodeURIComponent(cSearchType)
									        + "&cSearchWord=" + encodeURIComponent(cSearchWord)
									        + "&cSortColumn=" + encodeURIComponent(cSortColumn)
									        + "&cSortDirection=" + encodeURIComponent(cSortDirection)
	    });
		
		// 페이징을 눌러 페이지 이동
		$(".paginationS").find(".page-link").on("click", function (event) {
	     	event.preventDefault(); // 기본 이벤트 제거 (클릭 시 페이지 새로고침 방지)
			
	        let sPage = $(this).attr("data-page");
	        
	        sSearchType = $("#sSearchType").val();
			sSearchWord = $("#sSearchWord").val();
			sSortColumn = $("#sSortColumn").val();
			sSortDirection = $("#sSortDirection").val();
			cSearchType = $("#cSearchType").val();
			cSearchWord = $("#cSearchWord").val();
			cSortColumn = $("#cSortColumn").val();
			cSortDirection = $("#cSortDirection").val();
	        
	        if(!sPage){page = 1;}
	        
	        window.location.href = baseUrl + "?sPage=" + encodeURIComponent(sPage)
	        								+ "&tabType=" + encodeURIComponent(tabType)
									        + "&sSearchType=" + encodeURIComponent(sSearchType)
									        + "&sSearchWord=" + encodeURIComponent(sSearchWord)
									        + "&sSortColumn=" + encodeURIComponent(sSortColumn)
									        + "&sSortDirection=" + encodeURIComponent(sSortDirection);
									        + "&cSearchType=" + encodeURIComponent(cSearchType)
									        + "&cSearchWord=" + encodeURIComponent(cSearchWord)
									        + "&cSortColumn=" + encodeURIComponent(cSortColumn)
									        + "&cSortDirection=" + encodeURIComponent(cSortDirection)
	    });
		
		// 페이징을 눌러 페이지 이동
		$(".paginationC").find(".page-link").on("click", function (event) {
	     	event.preventDefault(); // 기본 이벤트 제거 (클릭 시 페이지 새로고침 방지)
			
	        let cPage = $(this).attr("data-page");
	        
	        sSearchType = $("#sSearchType").val();
			sSearchWord = $("#sSearchWord").val();
			sSortColumn = $("#sSortColumn").val();
			sSortDirection = $("#sSortDirection").val();
			cSearchType = $("#cSearchType").val();
			cSearchWord = $("#cSearchWord").val();
			cSortColumn = $("#cSortColumn").val();
			cSortDirection = $("#cSortDirection").val();
	        
	        if(!cPage){page = 1;}
	        
	        window.location.href = baseUrl + "?cPage=" + encodeURIComponent(cPage)
	        								+ "&tabType=" + encodeURIComponent(tabType)
									        + "&sSearchType=" + encodeURIComponent(sSearchType)
									        + "&sSearchWord=" + encodeURIComponent(sSearchWord)
									        + "&sSortColumn=" + encodeURIComponent(sSortColumn)
									        + "&sSortDirection=" + encodeURIComponent(sSortDirection);
									        + "&cSearchType=" + encodeURIComponent(cSearchType)
									        + "&cSearchWord=" + encodeURIComponent(cSearchWord)
									        + "&cSortColumn=" + encodeURIComponent(cSortColumn)
									        + "&cSortDirection=" + encodeURIComponent(cSortDirection)
	    });
	});
</script>
</html>