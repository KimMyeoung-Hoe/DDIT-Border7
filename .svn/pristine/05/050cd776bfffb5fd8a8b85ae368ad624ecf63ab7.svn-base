<%@page import="kr.or.ddit.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<%@ include file="../modules/modal.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>    
<sec:authentication property="principal" var="princ"/>
<c:set value="${princ.user }" var="userVO"></c:set>
<style type="text/css">
.pagination .page-link {
  border-radius: 999px !important;
}

</style>
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
			            <li class="breadcrumb-item"><a href="/logistics/myWarehouse.do?userId=${userVO.userId }">내 물류창고 관리</a></li>
			         </ol>
			      </div>
			   </div>
			
			   <div class="content-title">내 물류창고 관리</div>
			   <p class="desc" style="font-size: small;">물류관리자의 물류창고 관리페이지입니다 <br/> 각 창고부분을 클릭하면 상세페이지로 이동합니다</p>
			</div>
			<!-- 브레드크럼 엘리먼트 끝 -->
			<div class="section">
				
				<div class="search-filter-section">
					<div class="filter-group">
						<select class="form-select" id="searchType" >
				     	 <option>
				     		검색 타입선택
				         </option>
				         <option value="WH_TYPE" <c:if test="${searchType == 'WH_TYPE'}">selected</c:if>>
				         	창고 종류
				         </option>
				         <option value="WH_ADDR" <c:if test="${searchType == 'WH_ADDR'}">selected</c:if>>
				        	기본 주소
				         </option>
				         <option value="WH_NAME" <c:if test="${searchType == 'WH_NAME'}">selected</c:if>>
				         	창고 이름
				         </option>
				         <option value="WH_USE_YN" <c:if test="${searchType == 'WH_USE_YN'}">selected</c:if>>
				         	창고 사용가능 여부
				         </option>
				      </select>
					</div>
				   <div class="search-input-wrapper">
				      <div class="search-input-icon"></div>
				      <input type="text" class="form-input search-input" value="${searchWord }" placeholder="주소,창고 종류, 창고 이름,창고사용여부(사용가능/사용불가능) 검색">
				   </div>
				   <div class="filter-group">
				      
				      <select class="form-select" id="sortColumn1">
				         <option>
				     		순서 정렬
				         </option> 
				         <option value="WH_REG_DATE" <c:if test="${fn:startsWith(sortColumn, 'WH_REG_DATE')}">selected</c:if>>
				         	등록일자 정렬
				         </option>
				         <option value="WH_VOLUME" <c:if test="${fn:startsWith(sortColumn, 'WH_VOLUME')}">selected</c:if>>
				         	크기 정렬
				         </option>
				         <option value="WH_PRICE" <c:if test="${fn:startsWith(sortColumn, 'WH_PRICE')}">selected</c:if>>
				         	이용금액 정렬
				         </option>
				      </select>
				      <select class="form-select" id="sortColumn2">
				         <option>
				     		정렬 방향
				         </option>
				         <option value="DESC" <c:if test="${fn:endsWith(sortColumn, 'DESC')}">selected</c:if>>
				         	내림차순 정렬
				         </option>
				         <option value="ASC" <c:if test="${fn:endsWith(sortColumn, 'ASC')}">selected</c:if>>
				         	오름차순 정렬
				         </option>
				      </select>
				      <button class="btn btn-primary" id="searchBtn">검색</button>
				   </div>
				</div>
				<div class="table-section">
  				<table class="data-table">
				<tbody>
					<tr>
						<th hidden>물류창고 번호</th>
						<th>물류창고 이름</th>
						<th>물류창고 주소</th>
						<th>물류창고 크키</th>
						<th>물류창고 종류</th>
						<th>물류창고 등록일자</th>
						<th>물류창고 이용금액</th>
						<th>물류창고 사용가능여부</th>
					</tr>
					<!-- 전체 물류창고 목록 조회 > 나중에 세션에서 유저정보가져와서 유저id랑 맞는거만 출력  -->
					<c:if test="${not empty warehouseList}"> 
 						<c:forEach var="warehouse" items="${warehouseList }" >						
							<tr >
								<td hidden>${warehouse.whNo }</td>
								<td><a class="goWhDetail" data-warehouse-no="${warehouse.whNo}">${warehouse.whName}</a></td>
								<td>${warehouse.whAddr} ${warehouse.whDetailAddr } </td>
								<td>${warehouse.whVolume } m³</td>
								<td>${warehouse.whType }</td>
								<td>${warehouse.whRegDate }</td>
								<td><fmt:formatNumber pattern="#,##0" value="${warehouse.whPrice }"/> 원/ 1개월</td>
								<td>${warehouse.whUseYn ? '사용가능' : '사용불가' }</td>
							</tr>				
						</c:forEach>
					</c:if>
					<c:if test="${empty warehouseList}">
					    <tr><td colspan="7" class="text-center">등록된 물류창고가 없습니다.</td></tr>
					</c:if>
				</tbody>	
				</table>
				<div class="table-footer">
					<div class="d-flex justify-content-center mt-4">
					    <ul class="pagination">
					        <c:if test="${paginationInfo.startPage > 1}">
					            <li class="page-item">
					                <a class="page-link page-link-text" href="#" data-page="${paginationInfo.startPage - paginationInfo.blockSize}">이전</a>
					            </li>
					        </c:if>
					
					        <c:forEach var="i" begin="${paginationInfo.startPage}" end="${paginationInfo.endPage < paginationInfo.totalPage ? paginationInfo.endPage : paginationInfo.totalPage}">
					            <li class="page-item ${i == paginationInfo.currentPage ? 'active' : ''}">
					                <a class="page-link" href="#" data-page="${i}">${i}</a>
					            </li>
					        </c:forEach>
					
					        <c:if test="${paginationInfo.endPage < paginationInfo.totalPage}">
					            <li class="page-item">
					                <a class="page-link page-link-text" href="#" data-page="${paginationInfo.endPage + 1}">다음</a>
					            </li>
					        </c:if>
					    </ul>
					</div>
			        <div class="footer-buttons">
			            <button class="btn btn-primary" id="openRegistModalBtn">등록</button>
			        </div>
			    </div>
			</div>
		</div>
		</main>
	</div>
	
<div class="modal fade" id="warehouseRegistModal" tabindex="-1" aria-labelledby="warehouseRegistModalLabel">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="warehouseRegistModalLabel">새 물류창고 등록</h5>
      </div>
      <div class="modal-body">
        <form id="warehouseRegistForm">
          <div class="mb-3">
            <label for="whName" class="form-label">물류창고 이름</label>
            <input type="text" class="form-control" id="whName" name="whName" required>
          </div>
          <div class="mb-3">
			<label for="zipcode" class="form-label">우편번호</label>
			<div class="input-group">
				<input type="text" id="zipcode" name="consignorVO.consignorPost" class="form-control" readonly placeholder="우편번호">
				<button type="button" id="zipbtn" class="btn btn-success">우편번호찾기</button>
			</div>
		  </div>
          <div class="mb-3">
            <label for="whAddr" class="form-label">주소</label>
            <input type="text" class="form-control" id="whAddr" name="whAddr" placeholder="기본 주소" required readonly>
          </div>
          <div class="mb-3">
            <label for="whDetailAddr" class="form-label">상세 주소</label>
            <input type="text" class="form-control" id="whDetailAddr" name="whDetailAddr" placeholder="상세 주소 (선택 사항)">
          </div>
          <div class="mb-3">
            <label for="whVolume" class="form-label">크기 (단위: m³)</label>
            <input type="number" class="form-control" id="whVolume" name="whVolume" required>
          </div>
          <div class="mb-3">
            <label for="whType" class="form-label">종류</label>
            <select class="form-select" id="whType" name="whType" required>
              <option value="">선택</option>
              <option value="일반">일반</option>
              <option value="냉동">냉동</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="whPrice" class="form-label">이용금액(1m³당,한달 기준, 원화)</label>
            <input type="number" class="form-control" id="whPrice" name="whPrice" required>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary" id="submitWarehouseBtn">등록</button>
      </div>
    </div>
  </div>
</div>
	
<script type="text/javascript">
$(function(){ // 문서 로드 완료 시 실행
	// 공용사용할 부분
	var userId = `${userVO.userId}`;

    // 물류창고 상세 페이지 이동(여러 이벤트 겹처쓸때는 클래스로 id값으로하면 하나만적용됨)
    $('.goWhDetail').on('click',function(event){
    	
        const warehouseNo = $(this).data('warehouse-no');
	
        if (warehouseNo) {
            window.location.href = "<%=request.getContextPath()%>/logistics/warehouseDetail.do?whNo=" + warehouseNo +"&from=list";
        }
	});
    
    // 3단계: '등록' 버튼 클릭 시 모달 열기
    $('#openRegistModalBtn').on('click', function(){
        // 모달 열기 전에 폼 초기화 (이전 입력값 남아있지 않도록)
        $('#warehouseRegistForm')[0].reset(); // 폼 초기화
        $('#warehouseRegistModal').modal('show'); // 모달 보이기
    });

    // 4단계: 모달 내 '등록' 버튼 클릭 시 AJAX POST 요청
   $("#submitWarehouseBtn").on("click", function (event) {
    	event.preventDefault();
    	
    	var userNo = `${userVO.userNo}`;
     	
    	var formData = new FormData(document.getElementById("warehouseRegistForm"));
    	formData.append("logistMngNo",userNo);
        
    	$.ajax({
            url: "<%=request.getContextPath()%>/logistics/warehouseRegist.do", // POST 요청을 보낼 URL
            type: "POST",
            data: formData, // 직렬화된 폼 데이터
            processData: false,
            contentType: false,
            dataType: "text", // 서버 응답을 JSON으로 예상 (서버가 JSON을 반환하지 않으면 변경)
            success: function(cnt){
                if(cnt > 0){ // 서버 응답에 따라 성공 여부 판단
                    alertify.alert("물류창고 등록 성공!");
                    $('#warehouseRegistModal').modal('hide'); // 모달 닫기
                    location.reload(); // 페이지 새로고침하여 목록 업데이트
                } else {
                    alertify.alert("물류창고 등록 실패 ");
                }
            },
            error: function(xhr, status, error){
                console.error("등록 실패 오류:", error);
                console.error("XHR 응답:", xhr.msg);
                alertify.alert("물류창고 등록 중 오류 발생했습니다. 다시 시도해주세요.");
            }
        });
    });
  //--------------------------------------------------------------------------    
	//우편번호검색 이벤트 - 
	$('#zipbtn').on('click', function(){
		// Daum 카카오의 우편번호 검색
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
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
	            $("#zipcode").val(data.zonecode);
	            $('#whAddr').val(addr);
	            // 커서를 상세주소 필드로 이동한다.
	            $('#whDetailAddr').focus();
	        }
	    }).open();
	});
//-----------------------------------------------------------------------
// 페이지네이션의 검색, 정렬기능 사용 이벤트
	$('#searchBtn').on('click',function(){
		
		var contextPath = "<%=request.getContextPath()%>"; 
	    var searchParams = new URLSearchParams();
		var userId = `${userVO.userId}`;
	    
		var searchWord = $(".search-input").val();
        var searchType = $("#searchType").val();
        var sortColumn1 = $("#sortColumn1").val();
		var sortColumn2 = $("#sortColumn2").val();
		
		  // 검색어와 검색 타입 유효성 검사
        if (searchWord) {
            if (!searchType || searchType === "검색 타입선택") {
                alertify.alert("검색 타입을 선택해주세요.");
                return;
            }
            searchParams.set("searchWord", searchWord);
            searchParams.set("searchType", searchType);
        } else if (searchType && searchType !== "검색 타입선택") {
            alertify.alert("검색어를 입력해주세요.");
            return;
        }
		  
		if(sortColumn2 && sortColumn2 !== "정렬 방향"){
			if(!sortColumn1 || sortColumn1 === "순서 정렬"){
				alertify.alert("정렬 종류를 선택해주세요");
				return
			}
		}  

     // 정렬 조건 유효성 검사
        if (sortColumn1 && sortColumn1 !== "순서 정렬") {
            if (!sortColumn2 || sortColumn2 === "정렬 방향") {
                alertify.alert("정렬 방향을 선택해주세요.");
                return;
            } else {
                const sortColumn = sortColumn1 + " " + sortColumn2;
                searchParams.set("sortColumn", sortColumn);
            }
        } else {
            // 정렬 컬럼 자체가 선택되지 않았으면 아무것도 안 함
            searchParams.delete("sortColumn");
        }
		

        //  새로운 검색 조건 추가
        window.location.href = contextPath + "/logistics/myWarehouse.do?userId="+userId+"&"+ searchParams.toString();
    });

//------------------------------------------------------------------
// 페이지 이동 이벤트
	$(".pagination .page-link").click(function (e) {
	        e.preventDefault(); // 기본 이벤트 막기
	        
	        var currentPage = $(this).attr("data-page"); // data-page 값 가져오기
	    	var contextPath = "<%=request.getContextPath()%>"; 
	        var queryString = window.location.search; // 기존 쿼리 스트링 가져오기
	        
	        window.location.href = contextPath + "/logistics/myWarehouse.do"+ queryString +"&currentPage=" + currentPage;
	  });
});
</script>
</body>
</html>
