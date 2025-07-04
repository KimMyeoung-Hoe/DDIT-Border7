<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/contract.css">
<style type="text/css">
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
							<li class="breadcrumb-item"><a href="/">보세창고 화물 내역</a></li>
					
						</ol>
					</div>
				</div>

				<div class="content-title">보세창고 화물 내역</div>
				<p class="desc">모든 의뢰 상태를 확인하고 관리할 수 있습니다.</p>

			</div>
			
			<div class="section">
				<div class="search-filter-section">
					<div class="filter-group">
					
							<select class="form-select searchType" id="allSearchType" name="searchType">
					        	<option value=" ">검색 타입</option>
					            <option value="bwhCd">보세창고 부호</option>
					            <option value="whSectionNo">섹션 번호</option>
					            <option value="contractNo">관세대리업무계약 일련번호</option>
					            <option value="productName">물품 명칭</option>
					            <option value="productQty">물품 수량</option>
					            <option value="productVolume">물품 부피</option>
					            <option value="productWeight">물품 중량</option>
					            <option value="productPrice">물품 가격</option>
					            <option value="bwArrivalDate">물품 입고일자</option>
					            <option value="bwSporageDuration">총 보관일수</option>
					        </select>
					        <select class="form-select searchType" id="exportSearchType" name="searchType">
					        	<option value=" ">검색 타입</option>
					            <option value="bwhCd">보세창고 부호</option>
					            <option value="whSectionNo">섹션 번호</option>
					            <option value="contractNo">관세대리업무계약 일련번호</option>
					            <option value="productName">물품 명칭</option>
					            <option value="productQty">물품 수량</option>
					            <option value="productVolume">물품 부피</option>
					            <option value="productWeight">물품 중량</option>
					            <option value="productPrice">물품 가격</option>
					            <option value="cdNo">신고필증 일련번호</option>
					            <option value="cdDate">신고필증 발급일자</option>
					            <option value="bwSporageDuration">총 보관일수</option>
					        </select>
					        <select class="form-select searchType"  id="importSearchType"  style="display: none" name="searchType">
					        	<option value=" ">검색 타입</option>
					            <option value="declNo">신고서접수 일련번호</option>
					             <option value="contractNo">관세대리업무계약 일련번호</option>
					            <option value="productName">물품 명칭</option>
					            <option value="productQty">물품 수량</option>
					            <option value="productVolume">물품 부피</option>
					            <option value="productWeight">물품 중량</option>
					            <option value="productPrice">물품 가격</option>
					          <!--   <option value="declRealDate">신고서처리업무 완료일자</option> -->
					        </select>
					</div>
				    <div class="search-input-wrapper">
				    	<div class="search-input-icon"></div>
				        <input type="text" class="form-input search-input searchWord" id="searchWord" placeholder="검색어를 입력해주세요.">
				    </div>
				    <div class="filter-group">
				    	<select class="form-select sortColumn" id="allSortColumn" >
					        	<option value=" ">정렬 조건</option>
					            <option value="bwh_cd">보세창고 부호</option>
					            <option value="wh_section_no">섹션 번호</option>
					            <option value="contract_no">관세대리업무계약 일련번호</option>
					            <option value="product_name">물품 명칭</option>
					            <option value="product_qty">물품 수량</option>
					            <option value="product_volume">물품 부피</option>
					            <option value="product_weight">물품 중량</option>
					            <option value="product_price">물품 가격</option>
					            <option value="bwArrival_date">물품 입고일자</option>
					            <option value="bwSporage_duration">총 보관일수</option>
					        </select>
				         <select class="form-select sortColumn"  id="exportSortColumn" >
				         		<option value=" ">정렬 조건</option>
					            <option value="bwh_cd">보세창고 부호</option>
					            <option value="wh_section_no">섹션 번호</option>
					            <option value="contract_no">관세대리업무계약 일련번호</option>
					            <option value="product_name">물품 명칭</option>
					            <option value="product_qty">물품 수량</option>
					            <option value="product_volume">물품 부피</option>
					            <option value="product_weight">물품 중량</option>
					            <option value="product_price">물품 가격</option>
					            <option value="cd_no">신고필증 일련번호</option>
					            <option value="cd_date">신고필증 발급일자</option>
					            <option value="bw_sporage_duration">총 보관일수</option>
					        </select>
					        <select class="form-select sortColumn" id="importSortColumn" style="display: none">
					        	<option value=" ">정렬 조건</option>
					            <option value="decl_no">신고서접수 일련번호</option>
					            <option value="contract_no">관세대리업무계약 일련번호</option>
					            <option value="product_name">물품 명칭</option>
					            <option value="product_qty">물품 수량</option>
					            <option value="product_volume">물품 부피</option>
					            <option value="product_weight">물품 중량</option>
					            <option value="product_price">물품 가격</option>
					           <!--  <option value="user_name">담당 행정 공무원 번호</option>
					            <option value="decl_real_date">신고서처리업무 완료일자</option> -->
					        </select>
				        <select class="form-select sortDirection" id="sortDirection">
				        	<option value=" ">정렬 방향</option>
				            <option value="asc">오름차순</option>
				            <option value="desc">내림차순</option>
				        </select>
				        <button class="btn btn-primary searchBtn">검색</button>
				    </div>
				</div>
				
				<div class="support-tabs">
				 	<div class="tab-item allBtn" data-tab="e">
				      <i class="fas fa-bullhorn tab-icon"></i> 보세창고 화물 내역
				   </div>
				
				   <div class="tab-item exportBtn" data-tab="e">
				      <i class="fas fa-bullhorn tab-icon"></i> 반출 대기 화물 내역
				   </div>
				
				   <div class="tab-item importBtn" data-tab="appeal">
				      <i class="fas fa-bullhorn tab-icon"></i> 반입 대기 화물 내역
				   </div>
				</div>
				
				<div class="table-section">
				
				
				    <table class="data-table" id="all">
				        <thead>
				            <tr>
				                <th>보세창고 부호</th>
				                <th>섹션 번호</th>
				            	<th>관세대리업무계약 일련번호</th>
				                <th>수출입 구분</th>
				                <th>물품 명칭</th>
				                <th>물품 수량</th>
				                <th>물품 부피</th>
				                <th>물품 중량</th>
				                <th>물품 가격</th>
				                <th>신고필증 일련번호</th>
				                <th>물품 입고일자</th>
				                <th>총 보관일수</th>
		
				                
				          	</tr>
				        </thead>
				        <tbody>
				        	<c:forEach items="${crtBw}" var="crt">
				            	<tr >
				            		<td>${crt.bwhVO.bwhCd}</td>
					                <td>${crt.whSectionVO.whSectionNo}</td>
					                <td>${crt.contractVO.contractNo}</td>				             
					                <td>${crt.contractVO.contractNo}</td>
					                <td>${crt.productVO.productName}</td>
					                <td>${crt.productVO.productQty}</td>
					                <td>${crt.productVO.productVolume}</td>
					                <td>${crt.productVO.productWeight}</td>
					                <td>${crt.productVO.productPrice}</td>
					        		<td><fmt:formatDate value="${crt.bwArrivalDate}" pattern="yyyy-MM-dd" /></td>
					                <td>${crt.bwSporageDuration}</td>
				               </tr>
				           </c:forEach>
				        </tbody>
				    </table>
				
				
				 <table class="data-table" id="export">
				        <thead>
				            <tr>
				                <th>보세창고 부호</th>
				                <th>섹션 번호</th>
				            	<th>관세대리업무계약 일련번호</th>
				                <th>수출입 구분</th>
				                <th>물품 명칭</th>
				                <th>물품 수량</th>
				                <th>물품 부피</th>
				                <th>물품 중량</th>
				                <th>물품 가격</th>
				                <th>신고필증 일련번호</th>
				                <th>신고필증 발급일자</th>
				                <th>총 보관일수</th>
		
				                
				          	</tr>
				        </thead>
				        <tbody id="exportList">
				        	<%-- <c:forEach items="${crtBw}" var="crt">
				        		
				        				<tr >
						            		<td>${crt.bwhVO.bwhCd}</td>
							                <td>${crt.whSectionVO.whSectionNo}</td>
							                <td>${crt.contractVO.contractNo}</td>				             
							                <td>${crt.contractVO.contractNo}</td>
							                <td>${crt.productVO.productName}</td>
							                <td>${crt.productVO.productQty}</td>
							                <td>${crt.productVO.productVolume}</td>
							                <td>${crt.productVO.productWeight}</td>
							                <td>${crt.productVO.productPrice}</td>
							                <td>${crt.cdVO.cdNo}</td>
							                <td>${crt.cdVO.cdDate}</td>
							                <td>${crt.bwArrivalDate}</td>
							                <td>${crt.bwSporageDuration}</td>
						               </tr>
				        			
				           </c:forEach> --%>
				        </tbody>
				    </table>
				    
				
				
				
				    
				     <!--               접수 대기 화물 내역                    -->
				     <table class="data-table" id="import"> 
				        <thead>
				            <tr>
				            	<th>신고서접수 일련번호</th>
				            	<th>관세대리업무계약 일련번호</th>
				                <th>수출입 구분</th>
				                <th>물품 명칭</th>
				                <th>물품 수량</th>
				                <th>물품 부피</th>
				                <th>물품 중량</th>
				                <th>물품 가격</th>
				                <th>담당 행정 공무원 이름</th>
				                <th>신고서처리업무 접수일자</th>
				                <th>화물 등록</th>
				          	</tr>
				        </thead>
				        <tbody id="importList">
				        	<%-- <c:forEach items="${bwAwaitlist}" var="bwAw">
				            	<tr>
				            	 	<td>${bwAw.declNo}</td>
					                <td>${bwAw.contractVO.contractNo}</td>
					                <td>${bwAw.declDVO.declDNo}</td>
					                <td>${bwAw.productVO.productName}</td>
					                <td>${bwAw.productVO.productQty}</td>
					                <td>${bwAw.productVO.productVolume}</td>
					                <td>${bwAw.productVO.productWeight}</td>
					                <td>${bwAw.productVO.productPrice}</td>
					                <td>${bwAw.userVO.userId} / ${bwAw.userVO.userName}</td>
					                <td>${bwAw.declRealDate}</td>
					                <td><button class="btn btn-secondary storageBtns" id="storageBtn" data-decl-no="${bwAw.declNo}" data-contract-no="${bwAw.contractNo}">입고</button></td> 
				               </tr>
				           </c:forEach> --%>
				        </tbody>
				    </table>
				
			        <div class="table-footer">
			        	<ul class="pagination pagination-sm m-0 float-right" id="pagingArea">
			        	</ul>
			        </div>
				</div>
			</div>
		</main>	
	</div>
</body>
<script type="text/javascript">
	// 여기부터 제가 드린 새로운 JavaScript 코드 전체를 붙여넣으세요.
	// -----------------------------------------------------------
	// contextPath는 한 번만 선언합니다.
	const contextPath = "<%=request.getContextPath()%>";
	let currentPage = 1;
	let currentIoType = "all"; // 현재 선택된 탭 (all, export, import)
	let searchType = "";
	let searchWord = "";
	let sortColumn = "";
	let sortDirection = "";

	$(document).ready(function() {
		// 초기 상태 설정
		$("#all").show();
		$("#import").hide();
		$("#export").hide();

		$("#exportSearchType").hide();
		$("#importSearchType").hide();
		$("#exportSortColumn").hide();
		$("#importSortColumn").hide();
		$("#allSearchType").show();
		$("#allSortColumn").show();
		$(".allBtn").addClass("active-tab");
		// 초기 데이터 로드 (모든 리스트)
		fetchList(currentIoType); // 페이지 로드 시 'all' 탭의 데이터 로드

		// 탭 클릭 이벤트
		$(".allBtn").on("click", function () {
			currentIoType = "all";
			currentPage = 1; // 탭 변경 시 페이지 리셋
			resetSearchParams(); // 검색 파라미터 초기화
			$(".tab-item").removeClass("active");
			$(this).addClass("active");
			toggleTableAndSearchFields();
			fetchList(currentIoType);
		});

		$(".importBtn").on("click", function () {
			currentIoType = "import";
			currentPage = 1; // 탭 변경 시 페이지 리셋
			resetSearchParams(); // 검색 파라미터 초기화
			toggleTableAndSearchFields();
			$(".tab-item").removeClass("active");
			$(this).addClass("active");
			fetchList(currentIoType);
		});

		$(".exportBtn").on("click", function () {
			currentIoType = "export";
			currentPage = 1; // 탭 변경 시 페이지 리셋
			resetSearchParams(); // 검색 파라미터 초기화
			toggleTableAndSearchFields();
			$(".tab-item").removeClass("active");
			$(this).addClass("active");
			fetchList(currentIoType);
		});

		// 입고 버튼
		$("#importList").on("click", ".storageBtns", function () {
			console.log('입고 버튼 클릭');
			let declNo = $(this).data("declNo");
			let contractNo = $(this).data("contractNo");
			console.log("declNo:", declNo, "contractNo:", contractNo);
			location.href = contextPath + "/servant/writeBw.do?declNo=" + declNo + "&contractNo=" + contractNo;
		});

		// 검색 버튼
		$(".searchBtn").on("click", function() {
			currentPage = 1; // 검색 시 첫 페이지로 리셋
			searchType = $(".searchType:visible").val();
			searchWord = $(".searchWord").val();
			sortColumn = $(".sortColumn:visible").val();
			sortDirection = $(".sortDirection").val();

			console.log("검색 실행 - 타입:", searchType, "단어:", searchWord, "컬럼:", sortColumn, "방향:", sortDirection);

			fetchList(currentIoType);
		});

		// 페이지 링크 클릭 이벤트 (이벤트 위임)
		$(document).on('click', '.page-link', function(e){
			e.preventDefault();
			currentPage = $(this).data("page");
			console.log("페이지 이동:", currentPage);
			fetchList(currentIoType);
		});

		// 검색 파라미터를 초기화하는 함수
		function resetSearchParams() {
			searchType = " "; // <option value=" ">검색 타입</option> 에 맞춰 공백으로 초기화
			searchWord = "";
			sortColumn = " "; // <option value=" ">정렬 조건</option> 에 맞춰 공백으로 초기화
			sortDirection = " "; // <option value=" ">정렬 방향</option> 에 맞춰 공백으로 초기화


			$(".searchType:visible").val(" ");
			$(".searchWord").val("");
			$(".sortColumn:visible").val(" ");
			$(".sortDirection").val(" ");
		}


		// 테이블 및 검색 필드 가시성 토글 함수
		function toggleTableAndSearchFields() {
			// 모든 테이블 숨기기
			$("#all").hide();
			$("#import").hide();
			$("#export").hide();

			// 모든 검색/정렬 필드 숨기기
			$(".searchType").hide();
			$(".sortColumn").hide();

			// 선택된 탭에 따라 테이블 및 검색 필드 표시
			if (currentIoType === "all") {
				$("#all").show();
				$("#allSearchType").show();
				$("#allSortColumn").show();
			} else if (currentIoType === "import") {
				$("#import").show();
				$("#importSearchType").show();
				$("#importSortColumn").show();
			} else if (currentIoType === "export") {
				$("#export").show();
				$("#exportSearchType").show();
				$("#exportSortColumn").show();
			}
		}

		function formatDateToYYYYMMDD(dateString) {
			console.log("데이트 포맷 : ", dateString)
		    if (!dateString) {
		        return '';
		    }
		    try {
		        
		        const date = new Date(dateString);

		        // Date 객체가 유효한지 확인
		        if (isNaN(date.getTime())) {
		            console.warn("Invalid date string provided:", dateString);
		            return dateString; // 유효하지 않으면 원본 문자열 반환 또는 빈 문자열
		        }

		        const year = date.getFullYear();
		        const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
		        const day = String(date.getDate()).padStart(2, '0');
		        
		        /* console.log("날짜는 ?", year, month, day ) */
		        return `\${year}-\${month}-\${day}`;
		    } catch (e) {
		        console.error("Error formatting date:", e);
		        return dateString; // 오류 발생 시 원본 문자열 반환
		    }
		}

		
		// 데이터를 가져와서 테이블을 업데이트하는 통합 함수
		function fetchList(ioType) {
			let apiUrl = "";
			let targetTableBodyId = ""; // 데이터를 넣을 tbody의 ID
			let tableHtmlGenerator;      // 테이블 row HTML을 생성할 함수

			// API URL 및 HTML 생성 함수 설정
			if (ioType === "all") {
				apiUrl = "/servant/api/ajaxcurrentBwList.do"; // 변경된 URL
				targetTableBodyId = "all"; // all 테이블의 tbody ID (all 테이블의 id와 동일하게 설정되어 있음)
				tableHtmlGenerator = function(item) {
                    let ioStatus = (item.contractVO && item.contractVO.contractNo && item.contractVO.contractNo.slice(1, 3) === "IMP") ? "수입" : "수출";
					return `
						<tr>
							<td>\${item.bwhVO ? item.bwhVO.bwhCd : ''}</td>
							<td>\${item.whSectionVO ? item.whSectionVO.whSectionNo : ''}</td>
							<td>\${item.contractVO ? item.contractVO.contractNo : ''}</td>
							<td>\${ioStatus}</td>
							<td>\${item.productVO ? item.productVO.productName : ''}</td>
							<td>\${item.productVO ? item.productVO.productQty : ''}</td>
							<td>\${item.productVO ? item.productVO.productVolume : ''}</td>
							<td>\${item.productVO ? item.productVO.productWeight : ''}</td>
							<td>\${item.productVO ? item.productVO.productPrice : ''}</td>
							<td>\${item.cdVO ? item.cdVO.cdNo : '대기'}</td>
							<td>\${formatDateToYYYYMMDD(item.bwArrivalDate)}</td> 
							<td>\${item.bwSporageDuration || '0'}</td>
						</tr>
					`;
				};
			} else if (ioType === "export") {
				apiUrl = "/servant/api/bwAwaitshipment.do";
				targetTableBodyId = "exportList"; // export 테이블의 tbody ID
				tableHtmlGenerator = function(item) {
					return `
						<tr>
							<td>\${item.bwhVO ? item.bwhVO.bwhCd : ''}</td>
							<td>\${item.whSectionVO ? item.whSectionVO.whSectionNo : ''}</td>
							<td>\${item.contractVO ? item.contractVO.contractNo : ''}</td>
							<td>\${item.contractVO.contractNo.slice(0,3) == "IMP" ? "수입" : "수출" }</td>
							<td>\${item.productVO ? item.productVO.productName : ''}</td>
							<td>\${item.productVO ? item.productVO.productQty : ''}</td>
							<td>\${item.productVO ? item.productVO.productVolume : ''}</td>
							<td>\${item.productVO ? item.productVO.productWeight : ''}</td>
							<td>\${item.productVO ? item.productVO.productPrice : ''}</td>
							<td>\${item.cdVO ? item.cdVO.cdNo : ''}</td>
                            <td>\${item.cdVO ? item.cdVO.cdDate : ''}</td>
							<td>\${item.bwSporageDuration || '0'}</td>
						</tr>
					`;
				};
				
			} else if (ioType === "import") {
				apiUrl = "/servant/api/bwAwaitReceive.do";
				targetTableBodyId = "importList"; // import 테이블의 tbody ID
				tableHtmlGenerator = function(item) {
                    let officerInfo = '';
                    if (item.userVO) {
                        officerInfo = `\${item.userVO.userId || ''}  \${item.userVO.userName || ''}`;
                        console.log(item.userVO)
                    }
					return `
						<tr>
							<td>\${item.declNo || ''}</td>
							<td>\${item.contractVO ? item.contractVO.contractNo : ''}</td>
							<td>\${item.contractVO && item.contractVO.contractNo && item.contractVO.contractNo.slice(1, 3) === "IMP" ? "수입" : "수출" }</td>
							<td>\${item.productVO ? item.productVO.productName : ''}</td>
							<td>\${item.productVO ? item.productVO.productQty : ''}</td>
							<td>\${item.productVO ? item.productVO.productVolume : ''}</td>
							<td>\${item.productVO ? item.productVO.productWeight : ''}</td>
							<td>\${item.productVO ? item.productVO.productPrice : ''}</td>
							<td>\${officerInfo}</td>
							<td>\${item.declReceptDate || ''}</td>
							<td><button class="btn btn-secondary storageBtns" data-decl-no="\${item.declNo}" data-contract-no="\${item.contractVO ? item.contractVO.contractNo : ''}">입고</button></td>
						</tr>
					`;
				};
			}

			// URLSearchParams를 사용하여 파라미터 구성 (더 안전하고 깔끔함)
			const urlParams = new URLSearchParams();
			// trim()을 사용하여 양쪽 공백 제거 후 비어있거나 " " 값인 경우 파라미터에 포함하지 않음
			if (searchType && searchType.trim() !== "" && searchType.trim() !== " ") {
				urlParams.set("searchType", searchType.trim());
			}
			if (searchWord && searchWord.trim() !== "") {
				urlParams.set("searchWord", searchWord.trim());
			}
			if (sortColumn && sortColumn.trim() !== "" && sortColumn.trim() !== " ") {
				urlParams.set("sortColumn", sortColumn.trim());
			}
			if (sortDirection && sortDirection.trim() !== "" && sortDirection.trim() !== " ") {
				urlParams.set("sortDirection", sortDirection.trim());
			}
			urlParams.set("currentPage", currentPage);

			let queryString = urlParams.toString();
			let fullUrl = contextPath + apiUrl + (queryString ? "?" + queryString : "");

			console.log("AJAX 요청 URL:", fullUrl);

			$.ajax({
				url: fullUrl,
				type: "GET",
				dataType: "json",

				success: function(res) {
					console.log("API 응답 데이터:", res);

					let dataList = [];
					let paginationInfo = {};

					// 응답 데이터 구조에 따라 dataList와 paginationInfo 설정
					if (ioType === "all") {
						dataList = res.crtBw || [];
						paginationInfo = res.paginationInfo || {};
					} else if (ioType === "export") {
						dataList = res.crtBw || []; // export도 crtBw 키를 사용
						paginationInfo = res.paginationInfo || {};
					} else if (ioType === "import") {
						dataList = res.bwAwait || [];
						paginationInfo = res.paginationInfo || {};
					}

					// 테이블 내용 업데이트
					let html = '';
					// `all` 테이블은 `id="all"`이고, `tbody`가 바로 하위에 있으므로 `#all tbody`를 사용
					// `export`, `import` 테이블은 `tbody`에 별도의 `id`가 있으므로 `#exportList`, `#importList`를 사용
					let currentTableBodySelector = (ioType === "all") ? "#all tbody" : `#\${targetTableBodyId}`;
					console.log("대상 tbody 셀렉터:", currentTableBodySelector); 
					let colspanCount = $(currentTableBodySelector).closest('table').find('thead th').length;

					console.log("dataList :  ", dataList)
					if (dataList.length > 0) {
						for (let i = 0; i < dataList.length; i++) {
							html += tableHtmlGenerator(dataList[i]);
						}
					} else {
						html = `<tr><td colspan="${colspanCount}" style="text-align:center;">데이터가 없습니다.</td></tr>`;
					}
					$(currentTableBodySelector).empty().append(html);
					 /* console.log("생성된 HTML:", html); */


					// 페이지네이션 업데이트
					let pagehtml = '';
					if (paginationInfo.totalPage > 0) { // totalPage가 0보다 클 때만 페이지네이션 표시
						if (paginationInfo.startPage > 1) {
							pagehtml += `<li class="page-item"><a class="page-link page-link-text" href="javascript:void(0);" data-page="\${paginationInfo.startPage - paginationInfo.blockSize}">이전</a></li>`;
						}

						let endPage = paginationInfo.endPage < paginationInfo.totalPage ? paginationInfo.endPage : paginationInfo.totalPage;
						for (let i = paginationInfo.startPage; i <= endPage; i++) {
							if (i == paginationInfo.currentPage) {
								pagehtml += `<li class="page-item active"><span class="page-link">\${i}</span></li>`;
							} else {
								pagehtml += `<li class="page-item"><a href="javascript:void(0);" class="page-link" data-page="\${i}">\${i}</a></li>`;
							}
						}

						if (paginationInfo.endPage < paginationInfo.totalPage) {
							// data-page 값을 paginationInfo.endPage + 1로 설정하여 다음 블록의 첫 페이지로 이동
							pagehtml += `<li class="page-item"><a href="javascript:void(0);" class="page-link page-link-text" data-page="\${paginationInfo.endPage + 1}">다음</a></li>`;
						}
					}
					$(".pagination").empty().append(pagehtml);

				},
				error: function(xhr, status, error) {
					console.error("AJAX 요청 실패:", status, error, xhr.responseText);
					let currentTableBodySelector = (ioType === "all") ? "#all tbody" : `\{targetTableBodyId}`;
					let colspanCount = $(currentTableBodySelector).closest('table').find('thead th').length;
					$(currentTableBodySelector).empty().append(`<tr><td colspan="${colspanCount}" style="text-align:center; color:red;">데이터를 불러오는데 실패했습니다. 오류: ${xhr.status}</td></tr>`);
					$(".pagination").empty(); // 페이지네이션도 비움
				}
			});
		}
	});

</script>
</html>