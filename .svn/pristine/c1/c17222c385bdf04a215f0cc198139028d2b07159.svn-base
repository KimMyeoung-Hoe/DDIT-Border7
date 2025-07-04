<%@page import="kr.or.ddit.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Border7 - 물류창고 관리</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<%@ include file="../modules/modal.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
			            <li class="breadcrumb-item"><a href="/logistics/myContainer.do?userNo=${userVO.userNo }">내 컨테이너 관리</a></li>
			         </ol>
			      </div>
			   </div>
			   <div class="content-title">내 컨테이너 관리</div>
			   <p class="desc" style="font-size: small;">물류관리자의 컨테이너 목록페이지입니다 <br/> 각 컨테이너부분을 클릭하면 상세페이지로 이동합니다<br/>또한 선박 이름을 클릭하면 선박정보를 볼수있습니다</p>
			</div>
			<!-- 브레드크럼 엘리먼트 끝 -->
			<div class="section">
				<div class="search-filter-section">
				<div class="filter-group">
					<select class="form-select" id="searchType" >
				     	 <option>
				     		검색 타입선택
				         </option>
				         <option value="CONTAINER_TYPE" <c:if test="${searchType == 'CONTAINER_TYPE'}">selected</c:if>>
				         	컨테이너 종류
				         </option>
				         <option value="CONTAINER_NAME" <c:if test="${searchType == 'CONTAINER_NAME'}">selected</c:if>>
				        	컨테이너 이름
				         </option>
				         <option value="CONTAINER_USE_YN" <c:if test="${searchType == 'CONTAINER_USE_YN'}">selected</c:if>>
				         	컨테이너 사용가능 여부
				         </option>
				      </select>
				</div>
				   <div class="search-input-wrapper">
				      <div class="search-input-icon"></div>
				      <input type="text" value="${searchWord }" class="form-input search-input" placeholder="컨테이너 종류, 이름, 사용여부(사용가능/사용불가능) 검색">
				   </div>
				   <div class="filter-group">
				      <select class="form-select" id="sortColumn1">
				         <option>
				     		정렬
				         </option>
				         <option value="CONTAINER_TYPE" <c:if test="${fn:startsWith(sortColumn,'CONTAINER_TYPE')}">selected</c:if>>
				         	컨테이너 종류 정렬
				         </option>
				         <option value="CONTAINER_SIZE" <c:if test="${fn:startsWith(sortColumn,'CONTAINER_SIZE')}">selected</c:if>>
				         	크기 정렬
				         </option>
				         <option value="CONTAINER_PRICE" <c:if test="${fn:startsWith(sortColumn,'CONTAINER_PRICE')}">selected</c:if>>
				         	이용금액 정렬
				         </option>
				         <option value="CONTAINER_USE_YN" <c:if test="${fn:startsWith(sortColumn,'CONTAINER_USE_YN')}">selected</c:if>>
				         	이용상태 정렬
				         </option>
				      </select>
				      <select class="form-select" id="sortColumn2">
				         <option>
					     	정렬 방향
					     </option>
				         <option value="DESC" <c:if test="${fn:endsWith(sortColumn,'DESC')}">selected</c:if>>
				         	내림차순
				         </option>
				         <option value="ASC" <c:if test="${fn:endsWith(sortColumn,'ASC')}">selected</c:if>>
				         	오름차순
				         </option>
				      </select>
				      <button class="btn btn-primary" id="searchBtn">검색</button>
				   </div>
				</div>
				<div class="table-section">
	  				<table class="data-table" id="containerTable">
						<tr>
							<th>컨테이너명</th>
							<th>컨테이너 위치</th>
							<th>컨테이너 크기</th>
							<th>컨테이너 종류</th>
							<th>컨테이너 이용비용</th>
							<th>컨테이너 사용가능여부</th>
						</tr>
						<tbody>
							<c:if test="${not empty containerList}"> 
							<c:forEach var="container" items="${containerList }">						
								<tr >
									<td><a data-container-no="${container.containerNo }" class="detail">${container.containerName }</a></td>
									<td >${container.containerLocation }</td>
									<td>${container.containerSize } FT</td>
									<td>${container.containerType }</td>
									<td style="text-align: center;"><fmt:formatNumber pattern="#,##0" value="${container.containerPrice }"/> 원 / 월</td>
									<td>${container.containerUseYn ? '사용가능' : '사용불가' }</td>
								</tr>					
							</c:forEach>
							</c:if>
	                        <c:if test="${empty containerList}">
	                            <tr><td colspan="9" class="text-center">등록된 컨테이너가 없습니다.</td></tr>
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
			            <button class="btn btn-primary" id="goContainerRegistButton">컨테이너 등록</button>
			        </div>
			    </div>
				</div>
			</div>
		</main>
	</div>
	
<div class="modal fade" id="containerRegistModal" tabindex="-1" aria-labelledby="containerRegistModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="containerRegistModalLabel">새 컨테이너 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="containerRegistForm"> 
          <div class="row mb-3">
            <label class="col-sm-3 col-form-label">컨테이너 명칭</label>
            <div class="col-sm-9"> 
                <input class="form-control" type="text" placeholder="컨테이너 이름"
                        id="containerName" name="containerName" required /> 
            </div>
          </div>
          <div class="row mb-3">
            <label class="col-sm-3 col-form-label">컨테이너 위치</label>
            <div class="col-sm-9">
                <input class="form-control" type="text" placeholder="컨테이너 위치"
                        id="containerLocation" name="containerLocation" required />
            </div>
          </div>
          <div class="row mb-3">
              <label class="col-sm-3 col-form-label">컨테이너 종류/크기</label> 
              <div class="col-sm-4">
                  <label class="form-label visually-hidden">컨테이너 종류</label> 
                  <select class="form-select" id="containerType" name="containerType" required>
                      <option value="">종류 선택</option> 
                      <option value="냉동">냉동</option>
                      <option value="일반">일반</option>
                  </select>
              </div>
              <div class="col-sm-5"> 
                  <label class="form-label visually-hidden">컨테이너 크기</label>
                  <select class="form-select" id="containerSize" name="containerSize" required>
                      <option value="">크기 선택</option>
                      <option value="20">20ft</option>
                      <option value="40">40ft</option>
                  </select>
              </div>
          </div>
          <div class="row mb-3">
            <label class="col-sm-3 col-form-label">컨테이너 이용비용(한달기준)</label>
            <div class="col-sm-9">
                <input class="form-control" type="number" placeholder="컨테이너 이용비용(한달)"
                        id="containerPrice" name="containerPrice" required />
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary" id="submitContainerRegistBtn">등록</button> <%-- 등록 버튼 ID 추가 --%>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
$(function(){
//---------------------------------------------------------------------------
    // 등록 버튼 클릭 이벤트 
    $('#goContainerRegistButton').on('click', function(){
    	 $('#containerRegistForm')[0].reset(); // 폼 초기화
    	 $('#containerRegistModal').modal('show'); // 새 모달 ID 사용
    });

//-----------------------------------------------------------------------------
	$('#submitContainerRegistBtn').on('click',function(){
		
		var userNo = `${userVO.userNo}`;
		
		const form = $('#containerRegistForm')[0];
		const formData = new FormData(form);
		
		formData.append("logistMngNo",userNo);
		
		if (!$("#containerName").val()) { alertify.alert("컨테이너 이름를 입력해주세요!"); $('#containerName').focus(); return; }
		if (!$("#containerLocation").val()) { alertify.alert("컨테이너 위치를 입력해 주세요."); $('#containerLocation').focus(); return; }
		if (!$("#containerType").val()) { alertify.alert("컨테이너 종류와 크기를 선택해 주세요."); $('#containerType').focus(); return; }
		if (!$("#containerSize").val()) { alertify.alert("컨테이너 크기를 선택해 주세요."); $('#containerSize').focus(); return; }
		if (!$("#containerPrice").val()) { alertify.alert("컨테이너 이용비용을 입력해 주세요."); $('#containerPrice').focus(); return; }
	
	    $.ajax({
            url: "<%=request.getContextPath()%>/logistics/registContainer.do",
            type: "POST",
            data : formData,
            processData: false,
            contentType: false,
            dataType: "text",
            success: function(cnt) {
            	if(cnt > 0){ 
	            	alertify.alert("컨테이너 등록 성공!");
	                $('#containerRegistModal').modal('hide'); // 모달 닫기
	                location.reload();
            	} else {
                	alertify.alert("컨테이너 등록 실패 ");
            	}
            },
            error: function(xhr, status, error){
                console.error("등록 실패 오류:", error);
                console.error("XHR 응답:", xhr.msg);
                alertify.alert("컨테이너 등록 중 오류 발생했습니다. 다시 시도해주세요.");
            }
        });
	});

//-----------------------------------------------------------------------------
// 상세페이지 이동
    $('.detail').on('click', function(event){ 
    	
        const containerNo = $(this).data('containerNo'); 
        
		if(containerNo){
			window.location.href="<%=request.getContextPath()%>/logistics/containerDetail.do?containerNo=" + containerNo+"&from=list"; 
		}
	});
//-----------------------------------------------------------------------------
	// 검색 버튼 이벤트
	$('#searchBtn').on('click',function(){
		
		var contextPath = "<%=request.getContextPath()%>"; 
	    var searchParams = new URLSearchParams();
	    var userNo = `${userVO.userNo}`;
		
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
        if (sortColumn1 && sortColumn1 !== "정렬") {
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


        // 최종 이동
        window.location.href = contextPath + "/logistics/myContainer.do?userNo=" + userNo + "&" + searchParams.toString();
    });


//------------------------------------------------------------------
// 페이지 이동 이벤트
	$(".pagination .page-link").click(function (e) {
	    e.preventDefault();

	    var currentPage = $(this).attr("data-page");
	    var contextPath = "<%=request.getContextPath()%>";
	    var url = new URL(window.location.href);

	    // 기존 currentPage 파라미터 제거
	    url.searchParams.delete("currentPage");

	    // 새로운 currentPage 파라미터 추가
	    url.searchParams.append("currentPage", currentPage);

	    window.location.href = contextPath + "/logistics/myContainer.do" + url.search;
	});

});
</script>	
</body>
</html>