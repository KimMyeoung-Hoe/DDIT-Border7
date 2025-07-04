<%@page import="kr.or.ddit.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authentication property="principal" var="princ" />
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authentication property="principal" var="princ"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/modules/header.jsp" />
<jsp:include page="/WEB-INF/views/modules/sidebar.jsp" />
<jsp:include page="../modules/modal.jsp" />
<link rel="stylesheet" href="/css/main.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
		
			<!-- 브레드크럼 엘리먼트 -->
			<div class="content-header">
				<div class="breadcrumb-warp">
					<div class="col-sm-12">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="/">Home</a></li>
							<li class="breadcrumb-item"><a href="/">내 메뉴</a></li>
							<li class="breadcrumb-item"><a href="/">내 물류창고 관리</a></li>
						</ol>
					</div>
				</div>
				<div class="content-title">적재 신청</div>
				<p class="desc" style="font-size: small;">
					물류관리자의 물류창고 관리페이지입니다 <br /> 각 창고부분을 클릭하면 상세페이지로 이동합니다
				</p>
			</div>
			<!-- 브레드크럼 엘리먼트 끝 -->
			<div class="section">
				<div class="myContractList">
					<table class="data-table" id="select">
						<tbody>
							<tr>
								<th hidden>물류창고 번호</th>
								<th>수출입 구분</th>
								<th>관세대리업무 일련번호</th>
								<th>물품 명칭</th>
								<th>HS 코드</th>
								<th>물품 수량</th>
								<th>물품 부피</th>
								<th>화주 이름</th>
								<th>화주 이메일</th>
							</tr>
							<!-- 전체 물류창고 목록 조회 > 나중에 세션에서 유저정보가져와서 유저id랑 맞는거만 출력  -->
							<c:if test="${not empty contractVO}">
								<c:forEach var="contract" items="${contractVO }">
									<tr onclick="myContract(event)"
										data-contract-no="${contract.contractNo}" id="contract">
										<td>${contract.contractType}</td>
										<td>${contract.contractNo}</td>
										<td>${contract.productName}</td>
										<td>${contract.hsCode }</td>
										<td>${contract.productQty }</td>
										<td>${contract.productVolume}</td>
										<td>${contract.userName }</td>
										<td>${contract.userEmail }</td>
										<!-- <td><button class="btn btn-primary modalBtn" id="openRegistModalBtn">등록</button></td> -->
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty warehousePagingVO.dataList}">
								<tr>
									<td colspan="8" class="text-center">조회된 물류창고가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<div class="myContractDetail">
					<div id="selected">
						<div>선택된 물류 화주 내요 ㅇ~~~~~</div>
						<div class="tab-pane" id="document">
							<div class="info-card">
								<div class="info-row">
									<span class="card-title">선택한 계약 정보</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="section">
			
				<div class="support-tabs">
					<div class="tab-item importBtn" data-tab="e">
						<i class="fas fa-bullhorn tab-icon"></i> 수입
					</div>

					<div class="tab-item exportBtn" data-tab="appeal">
						<i class="fas fa-bullhorn tab-icon"></i> 수출
					</div>
				</div>
				
				<div class="table-section">
					<div id="warehouse">
						<form method="post" id="warehouseSearchForm">
							<input type="hidden" id="warehousePage" name="page" value="${warehousePagingVO.currentPage }"/>
							<input type="hidden" id="warehouseSearchTarget" name="searchTarget" value="w"/>
							<div class="search-filter-section">
								<div class="filter-group">
									<select class="form-select" id="warehouseSearch" name="searchType">
										<option value="">검색 타입선택</option>
										<option value="WH_NAME" <c:if test="${warehousePagingVO.searchType == 'WH_NAME'}">selected</c:if>>
							         		창고 이름
							         	</option>
							         	<option value="WH_ADDR" <c:if test="${warehousePagingVO.searchType == 'WH_ADDR'}">selected</c:if>>
							        		기본 주소
							         	</option>
							         	<option value="WH_TYPE" <c:if test="${warehousePagingVO.searchType == 'WH_TYPE'}">selected</c:if>>
							         		창고 종류
							         	</option>
							         	<option value="WH_USE_YN" <c:if test="${warehousePagingVO.searchType == 'WH_USE_YN'}">selected</c:if>>
							         		창고 사용가능 여부
							         	</option>
							         	<option value="WH_REG_DATE" <c:if test="${warehousePagingVO.searchType == 'WH_REG_DATE'}">selected</c:if>>
							         		등록일
							         	</option>
									</select>
								</div>
								<div class="search-input-wrapper">
									<div class="search-input-icon"></div>
									<input type="text" class="form-input search-input" id="warehouseSearchWord" name="searchWord"
										value="<c:if test="${not empty warehousePagingVO.searchWord }">${warehousePagingVO.searchWord }</c:if>"
										placeholder="주소,창고 종류, 창고 이름,창고사용여부(사용가능/사용불가능) 검색">
								</div>
								
								<div class="filter-group">
									<select class="form-select" id="warehouseSortColumn" name="sortColumn">
								         <option value="DESC" <c:if test="${warehousePagingVO.sortColumn == 'DESC'}"></c:if>>
								         	내림차순
								         </option>
								         <option value="ASC" <c:if test="${warehousePagingVO.sortColumn == 'ASC'}"></c:if>>
								         	오름차순
								         </option>
									</select>
									<button class="btn btn-primary" type="button" id="warehouseSearchBtn">검색</button>
								</div>
							</div>
						</form>
						
						<table class="data-table">
							<tbody>
								<tr class="whtr">
									<th hidden>물류창고 번호</th>
									<th>선택</th>
									<th>물류창고 이름</th>
									<th>물류창고 주소</th>
									<th>물류창고 종류</th>
									<th>물류창고 잔여크기</th>
									<th>물류창고 크키</th>
									<th>물류창고 사용가능여부</th>
									<th>물류창고 등록일자</th>
								</tr>
								<!-- 전체 물류창고 목록 조회 > 나중에 세션에서 유저정보가져와서 유저id랑 맞는거만 출력  -->
								<c:set var="warehouseList" value="#{warehousePagingVO.dataList }"/>
								<c:if test="${not empty warehouseList}">
									<c:forEach var="warehouse" items="${warehouseList }">
										<tr data-residual-volume="${warehouse.residualVolume}" data-wh-no="${warehouse.whNo}" class="whtd">
											<td hidden>${warehouse.whNo }</td>
											<td><input type="checkbox" class="selectWhNo"
												data-wh-no="${warehouse.whNo }"
												data-residual-volume="${warehouse.residualVolume}" /></td>
											<td>${warehouse.whName}</td>
											<td>${warehouse.whAddr} ${warehouse.whDetailAddr }</td>
											<td>${warehouse.whType }</td>
											<td class="residualVolume">${warehouse.residualVolume }m³</td>
											<td>${warehouse.whVolume }m³</td>
											<td>${warehouse.whUseYn ? '사용가능' : '사용불가' }</td>
											<td>${warehouse.whRegDate }</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty warehouseList}">
									<tr>
										<td colspan="7" class="text-center">조회된 물류창고가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
						<div class="table-footer">
							<div class="pagination" id="pagingArea">${warehousePagingVO.pagingHTML}</div>
							
							<button class="btn btn-primary WhRegisterBtn" id="openRegistModalBtn">등록</button>
						</div>
					</div>
					
					<div id="container">
						<form method="post" id="containerSearchForm">
							<input type="hidden" id="containerPage" name="page" value="${containerPagingVO.currentPage }"/>
							<input type="hidden" id="containerSearchTarget" name="searchTarget" value="c"/>
							<div class="search-filter-section">
								<div class="filter-group">
									<select class="form-select" id="containerSearchType" name="searchType">
										<option value="">검색 타입선택</option>
										<option value="CONTAINER_NAME" <c:if test="${containerPagingVO.searchType == 'CONTAINER_NAME'}">selected</c:if>>
							         		컨테이너명
							         	</option>
							         	<option value="CONTAINER_LOCATION" <c:if test="${containerPagingVO.searchType == 'CONTAINER_LOCATION'}">selected</c:if>>
							        		컨테이너위치
							         	</option>
							         	<option value="CONTAINER_TYPE" <c:if test="${containerPagingVO.searchType == 'CONTAINER_TYPE'}">selected</c:if>>
							         		컨테이너타입
							         	</option>
							         	<option value="CONTAINER_SIZE" <c:if test="${containerPagingVO.searchType == 'CONTAINER_SIZE'}">selected</c:if>>
							         		컨테이너크기
							         	</option>
							         	<option value="CONTAINER_PRICE" <c:if test="${containerPagingVO.searchType == 'CONTAINER_PRICE'}">selected</c:if>>
							         		컨테이너이용비용
							         	</option>
									</select>
								</div>
								<div class="search-input-wrapper">
									<div class="search-input-icon"></div>
									<input type="text" class="form-input search-input" id="containerSearchWord" name="searchWord"
										value="<c:if test="${not empty containerPagingVO.searchWord }">${containerPagingVO.searchWord }</c:if>"
										placeholder="주소,창고 종류, 창고 이름,창고사용여부(사용가능/사용불가능) 검색">
								</div>
								
								<div class="filter-group">
									<select class="form-select" id="containerSortColumn" name="sortColumn">
								         <option value="ASC" <c:if test="${containerPagingVO.sortColumn == 'ASC'}"></c:if>>
								         	오름차순
								         </option>
								         <option value="DESC" <c:if test="${containerPagingVO.sortColumn == 'DESC'}"></c:if>>
								         	내림차순
								         </option>
									</select>
									<button class="btn btn-primary" type="button" id="containerSearchBtn">검색</button>
								</div>
							</div>
						</form>
						<table class="data-table">
							<tbody>
								<tr>
									<th hidden>컨테이너 번호</th>
									<th>선택</th>
									<th>컨테이너명</th>
									<th>컨테이너 위치</th>
									<th>컨테이너 타입</th>
									<th>컨테이너 잔여크기</th>
									<th>컨테이너 크기</th>
									<th>컨테이너 이용비용</th>
									<th>컨테이너 사용가능여부</th>
								</tr>
								<c:set var="containerList" value="#{containerPagingVO.dataList }"/>
								<c:if test="${not empty containerList}">
									<c:forEach var="container" items="${containerList }">
										<tr data-residual-volume="${container.residualVolume}"
											data-container-no="${container.containerNo}">
											<td hidden>${container.containerNo }</td>
											<td><input type="checkbox" class="selectContainerNo"
												data-container-no="${container.containerNo }"
												data-residual-volume="${container.residualVolume}" /></td>
											<td class="containerName">${container.containerName }</td>
											<td>${container.containerLocation }</td>
											<td>${container.containerType}</td>
											<td class="residualVolume">${container.residualVolume }m³</td>
											<td>${container.containerSize}FT</td>
											<td class="containerPrice">${container.containerPrice }</td>
											<td>${container.containerUseYn ? '사용가능' : '사용불가' }</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty containerList}">
									<tr>
										<td colspan="8" class="text-center">조회된 컨테이너가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
						<div class="table-footer">
							<div class="pagination" id="pagingArea">${containerPagingVO.pagingHTML}</div>
							
							<button class="btn btn-primary ContainerRegisterBtn" id="containerBtn">등록</button>
						</div>
						
						
					</div>
				</div>
				<form action="/cca/shipSeheduleList.do" method="post"
					id="formSubmit">
					<input type="hidden" id="contractNos" name="contractNos" /> <input
						type="hidden" id="containerNos" name="containerNos" /> <input
						type="hidden" id="containerDetailStowageQtys"
						name="containerDetailStowageQtys" />
				</form>
				<div class="table-footer">
					<div class="d-flex justify-content-center mt-4">

					</div>
					<div class="footer-buttons"></div>
				</div>
			</div>
		</main>
	</div>
	<!-- -----------------------모달---------------------- -->
	<div class="modal fade" id="RegistModal" tabindex="-1"
		aria-labelledby="registModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="registModalLabel">적재 수량 입력</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="stowageForm">
						<div id="selectedItemsInModal"></div>
					</form>
				</div>
				<div class="modal-footer">
					<!-- <button type="button" class="btn btn-secondary closeBtn" data-bs-dismiss="modal">닫기</button> -->
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(document).ready(function() {
	let searchTarget =  "${searchTarget}";
	
	if(searchTarget == "w"){
		$("#container").hide();
		$("#warehouse").show();
		$(".importBtn").addClass("active");
	}else{
		$("#container").show();
		$("#warehouse").hide();
		$(".exportBtn").addClass("active");
	}
	
	$("#warehouse").find("a.page-link").attr("data-searchTarget", "w");
	$("#container").find("a.page-link").attr("data-searchTarget", "c");
	
	//창고
	//페이지 네이션
	let warehousePagingArea = $("#warehouse #pagingArea");
	let warehouseSearchForm = $("#warehouseSearchForm");

	//페이지네이션 클릭이벤트
	warehousePagingArea.on("click", "a", function(e) {
		e.preventDefault();
		let pageNo = $(this).data("page");
		warehouseSearchForm.find("#warehousePage").val(pageNo);
		warehouseSearchForm.submit();
	})
	
	//컨테이너
	//페이지네이션 클릭이벤트
	let containerPagingArea = $("#container #pagingArea");
	let containerSearchForm = $("#containerSearchForm");
	containerPagingArea.on("click", "a", function(e) {
		e.preventDefault();
		let pageNo = $(this).data("page");
		containerSearchForm.find("#containerPage").val(pageNo);
		containerSearchForm.submit();
	})
	
	// 체크박스 하나만 선택되도록 하는 로직 추가
	// 물류창고 체크박스
	$(document).on('change', '.selectWhNo', function() {
	    $('.selectWhNo').not(this).prop('checked', false);
	});
	
	// 컨테이너 체크박스
	$(document).on('change', '.selectContainerNo', function() {
	    $('.selectContainerNo').not(this).prop('checked', false);
	});
	
	
	//엔터키 이벤트
	document.getElementById("warehouseSearchWord").addEventListener("keydown", function(event) {
		if (event.keyCode === 13) {
			event.preventDefault();
			let ele = this.closest("form");
			iptValCheck(ele);
		}
	});
	
	document.getElementById("containerSearchWord").addEventListener("keydown", function(event) {
		if (event.keyCode === 13) {
			event.preventDefault();
			let ele = this.closest("form"); //엘리먼트
			iptValCheck(ele);
		}
	});
	
	//검색 버튼 클릭이벤트
	document.getElementById("warehouseSearchBtn").addEventListener("click", function(event) {
		let ele = this.closest("form");
		iptValCheck(ele);
	})
	
	document.getElementById("containerSearchBtn").addEventListener("click", function(event) {
		let ele = this.closest("form");
		iptValCheck(ele);
	})
	
	//검색 함수 벨리데이션
	function iptValCheck(ele){
		let searchType = ele.querySelector('[name="searchType"]').value;
		let searchWord = ele.querySelector('[name="searchWord"]').value;
		
		if(searchType == ""){
			alertify.error('검색타입을 선택해주세요');
			return false;
		}
		if(searchWord == ""){
			alertify.error('검색어를 입력해주세요');
			return false;
		}
		
		ele.submit();
	}
	
	/* $("#container").hide();
	$("#warehouse").show(); */
	
	
	$(".importBtn").on("click", function () {
		if($(this).prop('disabled')) {
			console.log("수입 버튼이 비활성화");
			return false;
		}
		$("#container").hide();
		$("#warehouse").show();
		//디세이블 추가할것
	});
	
	$(".exportBtn").on("click", function () {
		if($(this).prop('disabled')) {
			console.log("수입 버튼이 비활성화");
			return false; 
        }
		$("#warehouse").hide();
		$("#container").show();
		//디세이블 추가할것
	});
	
	/** 적재신청할 물품 선택 하기 전*/
	$("#select").show(); 
	$("#selected").hide();
	
	const initcontractNo = "${contractNo}"
	
	if(initcontractNo && initcontractNo.trim() !== ""){
		console.log("init 들어오라고ㅗㅗㅗㅗㅗ", initcontractNo)
		 const fakeEvent = {
                 currentTarget: {
                     dataset: {
                         contractNo: initcontractNo
                     }
                 }
             };
             myContract(fakeEvent);
             console.log("initcontractNo   ",fakeEvent.currentTarget.dataset.contractNo)
	}

	
})

	let data =[];
	let productQty = 0;
	let productVolume = 0;
	let contractType ="";
	let htmlContent  =""
	let contractNo = "";
	
	/**적재신청 할 건 선택 했을 시 */
	function myContract(e){
		$(".tab-item").off("click",tabItemClickHandler);
		contractNo = e.currentTarget.dataset.contractNo
		$("#select").hide();
		$("#selected").show();
		console.log(contractNo)
		let html = "";
		
		$.ajax({
			url : "/cca/contractSelect.do",
			method : "post",
			contentType: "application/json", 
		    data: contractNo, 
			success : function(resp){
				data = resp;	
				console.log(data);
				productQty = data.productVO.productQty;
				productVolume = data.productVO.productVolume;
				contractType = data.contractType;
				
				$(".importBtn").prop('disabled', true);
	            $(".exportBtn").prop('disabled', true);
	            $(".tab-item").removeClass("active");

				if(contractType =="수출"){
					$("#warehouse").hide();
					$("#container").show();
					$(".exportBtn").addClass("active");
					
				}else{ 
					$("#container").hide();
					$("#warehouse").show();
					$(".importBtn").addClass("active");
					
				}
				
				htmlContent  += `
					<div class="info-row">
						<span class="info-label">관세대리업무 일련번호</span> 
						<span class="info-value">\${resp.contractNo}</span>
					</div>

					<div class="info-row">
						<span class="info-label">수출입 구분</span> 
						<span class="info-value">\${resp.contractType}</span>
					</div>

					<div class="info-row">
						<span class="info-label">화주 이름</span>
						<span class="info-value">\${resp.consignorVO.consignorName}</span>
					</div>

					<div class="info-row">
						<span class="info-label">화주 전화번호</span> 
						<span class="info-value">\${resp.consignorVO.consignorTel}</span>
					</div>

					<div class="info-row">
						<span class="info-label">물품 이름</span> <span
							class="info-value">\${resp.productVO.productName}</span>
					</div>
					<div class="info-row">
						<span class="info-label">물품 중량</span> <span
							class="info-value">\${resp.productVO.productWeight} </span>
					</div>
					<div class="info-row">
						<span class="info-label">물품 수량</span> <span
							class="info-value">\${resp.productVO.productQty} 개</span>
					</div>
		
					<div class="info-row">
						<span class="info-label">물품 부피</span> <span
							class="info-value">\${resp.productVO.productVolume } m³</span>
					</div>
					<div class="info-row" >
						<span class="info-label" style=" font-size:15px; font-weight:30px;">물품 총부피&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;  </span> <span
							class="info-value" style="font-size:15x; font-weight:30px;">\${resp.productVO.productVolume * resp.productVO.productQty} m³</span>
					</div>
				`;
				
		
				console.log(resp)
				console.log(resp)
				$(".myContractDetail").empty().append(htmlContent);

				
			}
		})  
	}
	
	const tabItemClickHandler = function() {
	    $(".tab-item").removeClass("active");
	    $(this).addClass("active");
	};
	$(".tab-item").on("click",tabItemClickHandler);
	
	/** 수입시 물류창고 
		필요 정보 : 물류창고 일련번호, 관세대리업무계약 일련번호
	*/

	let selectWhNo = 0;
	let selectContainerNo = 0;

    /** 물류창고 등록 버튼을 눌렀을 때 -> 
    	
    	확인 사항 : 
    		1)갯수가 계약시 물류 갯수랑 동일한가?
    		2) 각각의 창고 부피보다 입력 부피보다 크지 않는가?
    				
    	보낼 데이터
    		창고번호와 매핑된 갯수
    		contractNo
    */
	 $(".WhRegisterBtn").on('click', function(){
		 $(".modal-footer").empty().append('<button type="button" class="btn btn-secondary closeBtn" data-bs-dismiss="modal">닫기</button><button type="button" class="btn btn-primary" id="submitWhStowageBtn">적재 신청</button>');
		 let modalContentHtml ="";
		 let whStowageData = [];
		 modalContentHtml += ` 
			 <p><strong>적재할 물품 개수:</strong> \${data.productVO.productQty}</p>
			 <p><strong>적재할 물품 부피:</strong> \${data.productVO.productVolume}</p>
			 <p><strong>적재할 물품 총 부피:</strong> \${data.productVO.productQty * data.productVO.productVolume}</p>
			 <hr>
			 ` 
		 $('input.selectWhNo:checked').each(function() {
			 	const whNo = $(this).data("whNo");
		        const whName = $(this).closest("tr").find(".wgName").text(); //물류창고명
		        const whType = $(this).closest("tr").find("whType").text(); 
		        const residualVolume = parseFloat($(this).closest("tr").find(".residualVolume").text());

		        modalContentHtml += `
		            <div class="mb-3 p-2 border rounded stowage-item">
		                <p><strong>유형:</strong> 물류창고</p>
		                <p><strong>번호:</strong> \${whNo}</p>
		                <p><strong>이름:</strong> \${whName}</p>
		                <p><strong>잔여 크기:</strong> <span class="modalResidualVolumeText">\${residualVolume}m³</span></p>
		                <div class="row align-items-center">
		                    <label class="col-sm-4 col-form-label inputQty">적재할 물품 수량</label>
		                    <div class="col-sm-8">
		                    <input type="number" class="form-control stowageQtyInputModal"
	                               data-wh-no="\${whNo}"
	                               data-residual-volume="${residualVolume}"
	                               data-item-type="wh"
	                               placeholder="수량" min="1" required />
		                         <div id="totalVolume"></div>
		                         <div class="col-sm-12 text-end">
		                         <strong>현재 부피:</strong> <span class="totalVolumeDisplay">m³</span>
		                     </div>
		                    </div>
		                </div>
		            </div>
		        `;

		 })
		 
		 // 모달 띄우기
		$("#selectedItemsInModal").empty().append(modalContentHtml);
		/* modalContentHtml = `<button type="button" class="btn btn-primary" id="submitWhStowageBtn">적재 신청</button>`
		$(".modal-footer").append(modalContentHtml); */
	    $("#RegistModalLabel").text("물류창고 적재 수량 입력");
	    $("#contractNoForStowage").val(data.contractNo);
	    $("#stowageType").val("wh");
	
	    const stowageModal = new bootstrap.Modal(document.getElementById('RegistModal'));
	    stowageModal.show();
	    
	    // 모달에 input 값을 입력했을때 실시간으로 부피 계산
	    $(".stowageQtyInputModal").on("input", function(){
	    	let $parentStowageItem = $(this).closest('.stowage-item');
	    	inputQty = $(this).val();
	    	console.log(inputQty * productVolume);
	    	$parentStowageItem.find(".totalVolumeDisplay").text(`\${(inputQty * productVolume).toFixed(2)} m³`);
	    })
	    // 적재신청 버튼  클릭
	    $("#submitWhStowageBtn").on("click", function(){
	    	console.log("클릭")
	    	let totalQty=0;

	    	// 모든 개수를 더하기 위해 모든 input 찾기
	    	 $(".stowageQtyInputModal").each(function() {

	    		const inputQty = parseInt($(this).val());
	    		if(inputQty == 0 || inputQty == NaN){
	    			alertify.alert("수량을 적지 않으셨습니다. 다시 작성해주세요")
	    			totalQty = 0;
	    			
	    			return
	    		}
	    		
	    		totalQty += inputQty;
	    		console.log("현재 input의 수량:", inputQty);
	            console.log("누적 총 수량:", totalQty);
	            
	            selectWhNo = $(this).data("wh-no"); 
	            
	            whStowageData.push({ 
	                whNo: selectWhNo, 
	                whDetailStowageQty: inputQty 
	            });
	    	})
	    	
	    	if(totalQty != productQty){
	    		alertify.alert("입력하신 물품의 갯수가 적재하실 물품의 갯수와 맞지 않습니다. 다시 작성해주세요")
	    		return
	    	}
	    	// ajax로 보내기
	    	 $.ajax({
			        url: "/cca/whStowage.do", 
			        method: "POST",
			        contentType: "application/json", 
			        data: JSON.stringify({ 
			            contractNo: data.contractNo, 
			            whDetailList: whStowageData 
			        }),
			        success: function(resp) {
			        	
			        	
			           location.href ="ccaDetailContract/"+ data.contractNo;
			           
			        }
			    });
	    })
	  });
	
		/** 수출 시 컨테이너
			필요 정보 : 컨테이너 일련번호, 관세대리업무계약 일련번호
		*/
		
	 /** 컨테이너 등록 버튼을 눌렀을 때 -> 
	    	
	    	확인 사항 : 
	    		1) 갯수가 계약시 물류 갯수랑 동일한가?
	    		2) 각각의 컨테이너 부피보다 입력 부피보다 크지 않는가?
	    				
	    	보낼 데이터
	    		컨테이너와 매핑된 갯수
	    		contractNo
	    */
 	 $(".ContainerRegisterBtn").on('click', function(){
 		// 기존 모달 푸터 버튼을 모두 제거하고 새로 추가
 		$(".modal-footer").empty().append('<button type="button" class="btn btn-secondary closeBtn" data-bs-dismiss="modal">닫기</button><button type="button" class="btn btn-primary" id="submitContainerStowageBtn">적재 신청</button>');
 		 let modalContentHtml ="";
		 let inputStowageQtySum = 0;
		 let ContainerStowageData = [];
		 let contractNos = "";
	     let containerNos = "";
	     let containerDetailStowageQtys = "";
		
		modalContentHtml += ` 
			 <p><strong>적재할 물품 개수:</strong> \${data.productVO.productQty}</p>
			 <p><strong>적재할 물품 부피:</strong> \${data.productVO.productVolume}</p>
			 <p><strong>적재할 물품 총 부피:</strong> \${data.productVO.productQty * data.productVO.productVolume}</p>
			 <hr>
			 ` 
		$('input.selectContainerNo:checked').each(function() {
			const containerNo = $(this).data("containerNo");
	        const containerName = $(this).closest("tr").find(".containerName").text(); // 컨테이너명
	        const containerType = $(this).closest("tr").find("containerType").text(); // FT
	        const residualVolume = parseFloat($(this).closest("tr").find(".residualVolume").text());

	        modalContentHtml += `
	            <div class="mb-3 p-2 border rounded stowage-item">
	                <p><strong>유형:</strong> 컨테이너</p>
	                <p><strong>번호:</strong> \${containerNo}</p>
	                <p><strong>이름:</strong> \${containerName}</p>
	                <p><strong>잔여 크기:</strong> <span class="modalResidualVolumeText">\${residualVolume}m³</span></p>
	                <div class="row align-items-center">
	                    <label class="col-sm-4 col-form-label inputQty">적재할 물품 수량</label>
	                    <div class="col-sm-8">
	                    <input type="number" class="form-control stowageQtyInputModal"
                               data-container-no="\${containerNo}"
                               data-residual-volume="${residualVolume}"
                               data-item-type="${container}"
                               placeholder="수량" min="1" required />
	                         <div id="totalVolume"></div>
	                         <div class="col-sm-12 text-end">
	                         <strong>현재 부피:</strong> <span class="totalVolumeDisplay">m³</span>
	                     </div>
	                    </div>
	                </div>
	            </div>
	        `;
		})
		$("#selectedItemsInModal").empty().append(modalContentHtml);
		//modalContentHtml = `<button type="button" class="btn btn-primary" id="submitContainerStowageBtn">적재 신청</button>`;
		//$(".modal-footer").append(modalContentHtml);
	    $("#RegistModalLabel").text("컨테이너 적재 수량 입력");
	    $("#contractNoForStowage").val(data.contractNo);
	    $("#stowageType").val("container");
	
	    const stowageModal = new bootstrap.Modal(document.getElementById('RegistModal'));
	    stowageModal.show();
	    $(".stowageQtyInputModal").on("input", function(){
	    	let $parentStowageItem = $(this).closest('.stowage-item');
	    	inputQty = $(this).val();
	    	console.log(inputQty * productVolume)
	    	$parentStowageItem.find(".totalVolumeDisplay").text(`\${inputQty * productVolume} m³`);
	    })
		    
	    $("#submitContainerStowageBtn").on("click", function(){
	    	console.log("submitContainerStowageBtn 클릭")
	    	let totalQty=0;
	    	let contractNos = "";
	    	let containerNos = "";
	    	let containerDetailStowageQtys = "";

	    	// 모든 개수를 더하기 위해 모든 input 찾기
	    	 $(".stowageQtyInputModal").each(function() {

	    		const inputQty = parseInt($(this).val());
	    		if(inputQty == 0 || inputQty == NaN){
	    			alertify.alert("컨테이너에 수량을 적지 않으셨습니다. 다시 작성해주세요")
	    			totalQty = 0;
	    			contractNos == "";
	    			containerNos == "";
	    			containerDetailStowageQtys  =="";
	    			return
	    		}
	    		totalQty += inputQty;
	    		console.log("현재 input의 수량:", inputQty);
	            console.log("누적 총 수량:", totalQty);
	            contractNos += contractNo + ",";
	            containerNos += $(this).data("container-no") + ","; 
	            containerDetailStowageQtys += inputQty + ",";
	            console.log("contractNos ", contractNos)
	            console.log("containerNos ", containerNos)
	            console.log("containerDetailStowageQtys ", containerDetailStowageQtys);
	    	})
	    	if(totalQty != productQty){
	    		alertify.alert("입력하신 물품의 갯수가 적재하실 물품의 갯수와 맞지 않습니다. 다시 작성해주세요")
	    		return
	    	}
	    	//form에 넣기
	    	$("#contractNos").val(contractNos);
	 		$("#containerNos").val(containerNos);
	 		$("#containerDetailStowageQtys").val(containerDetailStowageQtys);
	   		$("#formSubmit").submit();
		    modalContentHtml ="";
	    })
 	 });
	    		
	
</script>
</body>
</html>
