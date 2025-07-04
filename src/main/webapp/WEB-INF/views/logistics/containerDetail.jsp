<%@page import="java.util.concurrent.LinkedTransferQueue"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<%@ include file="../modules/modal.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<script type="text/javascript" src="https://map.vworld.kr/js/webglMapInit.js.do?version=3.0&apiKey="></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<sec:authentication property="principal" var="princ"/>
<c:set value="${princ.user }" var="userVO"></c:set>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area p-3">
			 <!-- 브레드크럼 엘리먼트 -->
				<div class="content-header">
				   <div class="breadcrumb-warp">
				      <div class="col-sm-12">
				         <ol class="breadcrumb">
				            <li class="breadcrumb-item"><a href="/">Home</a></li>
				            <c:if test="${param.from == 'list'}">
				            	<li class="breadcrumb-item"><a href="/logistics/myContainer.do?userNo=${userVO.userNo }">내 컨테이너 관리</a></li>
				            </c:if>
				            <c:if test="${param.from != 'list'}">
				            	<li class="breadcrumb-item"><a href="/logistics/myOrder.do">내 적재신청 관리</a></li>
				            </c:if>
				            <li class="breadcrumb-item"><a href="/logistics/containerDetail.do?containerNo=${containerNo }">컨테이너 상세</a></li>
				         </ol>
				      </div>
				   </div>
				 <div class="content-title">내 컨테이너 상세페이지</div>
				   <p class="desc">컨테이너의 기본정보와 적재된 물품의 상세사항을 볼수있습니다</p>
				</div>
				<!-- 브레드크럼 엘리먼트 끝 -->
				<div class="section">
					<div class="card-main">
						<div class="card-left">
							<div class="info-row">
								<span class="card-title">컨테이너 기본 정보</span>
							</div>
							<div class="info-row">
								<span class="info-label">컨테이너 이름</span> 
								<span class="info-value">${containerVO.containerName }</span>
							</div>

							<div class="info-row">
								<span class="info-label">컨테이너 위치</span> 
								<span class="info-value">${containerVO.containerLocation }</span>
							</div>

							<div class="info-row">
								<span class="info-label">컨테이너 종류</span> 
								<span class="info-value">${containerVO.containerType }</span>
							</div>

							<div class="info-row">
								<span class="info-label">컨테이너 크키</span> 
								<span class="info-value">${containerVO.containerSize } FT</span>
							</div>

							<div class="info-row">
							<span class="info-label">사용가능 여부</span> 
							  	<c:if test="${containerVO.containerUseYn}">
                                       <span class="info-value">사용 가능</span>
                               	</c:if>
                               	<c:if test="${!containerVO.containerUseYn }">
                                       <span class="info-value">사용 불가능</span>
                               	</c:if>   
							</div>
					 
							<div class="info-row">
								<span class="info-label">컨테이너 이용 비용(한달 기준)</span> 
								<span class="info-value"><fmt:formatNumber pattern="#,##0" value="${containerVO.containerPrice}" /> 원</span>
							</div>
						</div>
					</div>	
					<c:if test="${param.from == 'list'}">
					 	<div class="d-flex justify-content-end">
							<button type="button" class="btn btn-info me-2" id="openModifyModalBtn">수정</button>
							<button type="button" class="btn btn-danger" id="deleteBtn" data-status="${containerDetailList[0].containerDetailStatusCode }">삭제</button>
						</div>
					</c:if>	
				</div>
				<br/>
				<div class="section">
					<div class="card-main">
						<div class="card-left">
							<div class="info-row">
								<span class="card-title">컨테이너 물품 정보</span>
							</div>
							<c:set value="${containerDetailList }" var="DetailList"/>
							<c:if test="${empty DetailList}">
								<div>
									컨테이너 이용 정보가 없습니다
								</div>
							</c:if>
							<c:if test="${not empty DetailList }">
								<div class="info-row">
									<span class="info-label">물품명</span> 
									<span class="info-value">${DetailList[0].productVO.productName }</span>
								</div>
	
								<div class="info-row">
									<span class="info-label">물품 갯수</span> 
									<span class="info-value">${DetailList[0].containerDetailStowageQty } 개</span>
								</div>
	
								<div class="info-row">
									<span class="info-label">물품 중량</span> 
									<span class="info-value">${DetailList[0].containerDetailStowageQty * DetailList[0].productVO.productWeight} KG</span>
								</div>
	
								<div class="info-row">
									<span class="info-label">적재 부피</span> 
									<span class="info-value"><fmt:formatNumber pattern="#0.00" value="${DetailList[0].containerDetailStowageQty * DetailList[0].productVO.productVolume }"/> CBM</span>
								</div>
	
								<div class="info-row">
									<span class="info-label">물품 가격</span> 
									<span class="info-value"><fmt:formatNumber pattern="#,##0" value="${DetailList[0].containerDetailStowageQty * DetailList[0].productVO.productPrice }"/> 원</span>
								</div>	
								
								<div class="info-row" >
									<span class="info-label" data-container-detail-no="${DetailList[0].containerDetailNo}">물품 상태</span> 
										<select class="status-select form-select">
										    	<option value="입고대기" ${DetailList[0].containerDetailStatusCode eq '입고대기' ? 'selected' : ''}>입고대기</option>
										        <option value="입고완료" ${DetailList[0].containerDetailStatusCode eq '입고완료' ? 'selected' : ''}>입고완료</option>
										        <option value="출고완료" ${DetailList[0].containerDetailStatusCode eq '출고완료' ? 'selected' : ''}>출고완료</option>
										</select>
								</div>		
							</c:if>
					 	</div>
				 	<div class="card-right">
				 		<div class="info-row">
							<span class="card-title">적재 선박 정보</span>
						</div>
						<c:if test="${empty DetailList}">
								<div>
									적재 선박 정보가 없습니다
								</div>
						</c:if>
						<c:if test="${not empty DetailList }">
							<div class="info-row">
								<span class="info-label">선박명</span> 
								<span class="info-value">${DetailList[0].shipsVO.shipName }</span>
							</div>
							<div class="info-row">
								<span class="info-label">선박타입</span> 
								<span class="info-value">${DetailList[0].shipsVO.shipType }</span>
							</div>
							<div class="info-row">
								<span class="info-label">선박 용적가능부피</span> 
								<span class="info-value">${DetailList[0].shipsVO.shipGt } GT</span>
							</div>
							<c:if test="${not empty DetailList[0].shipsVO.shipImg}">
								<div class="info-row">
									<span class="info-label">선박 이미지</span> 
									<img src="${DetailList[0].shipsVO.shipImg }" style="width:400px; height: 200px;">
								</div>
							</c:if>
							<c:if test="${empty DetailList[0].shipsVO.shipImg}">
								<div class="info-row">
									<span class="info-label">선박 이미지</span> 
									<span class="info-value">이미지가 없습니다</span>
								</div>	
							</c:if>
		
								<div class="info-row">
									<span class="info-label">선박 실시간 위치</span> 
									<span class="info-value">	
										<a data-ship-lon="${DetailList[0].shipsVO.shipLon }"
										   data-ship-lat="${DetailList[0].shipsVO.shipLat }"
										   data-ship-3d-img="${DetailList[0].shipsVO.ship3dImg }"
										   data-ship-id="${DetailList[0].shipsVO.shipId }"
										   data-ship-Name="${DetailList[0].shipsVO.shipName }"
											class="goShip">
											위치 보기
										</a>
									</span>
								</div>

							<div class="info-row">
								<span class="info-label">출항지</span> 
								<span class="info-value">${DetailList[0].portFromName }</span>
							</div>
							<div class="info-row">
								<span class="info-label">출항 예정 시간</span> 
								<span class="info-value">${DetailList[0].shipScheduleVO.shipScheduleDeparture }</span>
							</div>
							<div class="info-row">
								<span class="info-label">도착항</span> 
								<span class="info-value">${DetailList[0].portToName }</span>
							</div>
							<div class="info-row">
								<span class="info-label">도착 예정 시간</span> 
								<span class="info-value">${DetailList[0].shipScheduleVO.shipScheduleArrival }</span>
							</div>
						</c:if>
				 	</div>
				</div>	
			</div>
			
		</main>
	</div>
<!-- 수정모달 -->	
<div class="modal fade" id="containerModifyModal" tabindex="-1" aria-labelledby="containerModifyModalLabel">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="containerModifyModalLabel">컨테이너 정보 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="containerModifyForm">
          <input type="hidden" id="modifyContainerNo" name="containerNo"> <%-- name 속성 containerNo로 변경 --%>
          <div class="mb-3">
            <label for="modifyContainerName" class="form-label">컨테이너 이름</label> <%-- 레이블 텍스트 변경 --%>
            <input type="text" class="form-control" id="modifyContainerName" name="containerName" required>
          </div>
          <div class="mb-3">
   			<label for="modifyContainerLocation" class="form-label">컨테이너 위치</label>
   			<input type="text" class="form-control" id="modifyContainerLocation" name="containerLocation" required="required">
          </div>
          <div class="mb-3">
   			<label for="modifyContainerPrice" class="form-label">컨테이너 금액</label>
   			<input type="number" class="form-control" id="modifyContainerPrice" name="containerPrice" required="required">
          </div>
          <div class="mb-3 form-check">
          	<input type="hidden" name="containerUseYn" value="false"> <%-- name 속성 변경 --%>
          	<input type="checkbox" class="form-check-input" id="modifyContainerUseYn" name="containerUseYn" value="true" checked> <%-- name, id 속성 변경, checked 기본값 --%>
            <label class="form-check-label" for="modifyContainerUseYn">사용 상태 (체크 시 사용, 미체크시 사용불가)</label> <%-- for 속성 변경 --%>
          </div>
      	  <div class="mb-3">
      		<input type="hidden" name="containerNo" value="${containerVO.containerNo }"> <%-- name 속성 변경 --%>
            나머지 기본 정보는 수정불가능합니다
      	  </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary" id="submitModifyContainerBtn">수정</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- 선박모달 -->	
<div class="modal fade" id="shipMapModal" tabindex="-1" aria-labelledby="shipMapModalLabel">
  <div class="modal-dialog" style="min-width: 1100px;">
    <div class="modal-content" style="min-width: 1100px;">
      <div class="modal-header">
        <h5 class="modal-title" id="shipMapModalLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="vmap" style="width: 100%; height: 600px;"></div>
      </div>
    </div>
  </div>
</div>


<!-- 운전자 선택 모달 -->
<div class="modal fade" id="carrierSelectModal" tabindex="-1" aria-labelledby="carrierSelectModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="carrierSelectModalLabel">입고 차량 운전자 선택</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <table class="table table-hover">
          <thead>
            <tr>
              <th style="text-align: center;">소속</th>
              <th>운전자명</th>
              <th>연락처</th>
              <th style="text-align: center;">선택</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="driver" items="${userVO.carrier}">
              <tr>
              	<td style="text-align: center;">${driver.affiliation }</td>
                <td>${driver.name}</td>
                <td>${driver.phone}</td>
                <td style="text-align: center;">
                  <button type="button" class="btn btn-sm btn-primary select-carrier-btn"
                          data-name="${driver.name}" data-phone="${driver.phone}">선택</button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
 	
<script type="text/javascript">
$(function(){
	
	var map = null; 
	var shipMapModal = new bootstrap.Modal(document.getElementById('shipMapModal'));
	/**
	 * VWorld Map을 초기화하고 3D 모델을 로드하는 함수
	 * @param {number} lon - 경도
	 * @param {number} lat - 위도
	 * @param {string} modelUrl - .gltf 또는 .glb 파일의 URL
	 * @param {string} shipName - 선박 이름
	 */
 	function initMapAndLoadModel(lon, lat, modelUrl, shipName) {
		const uniqueId = `vmap_${Date.now()}`;
	    $('#shipMapModalLabel').text(`${shipName} Location`);

	    // #vmap 교체
	    $('#vmap').replaceWith('<div id="vmap" style="width: 100%; height: 600px;"></div>');

	    // DOM 교체 후 브라우저가 렌더링을 반영한 다음 프레임에서 실행
	    const options = {
	            mapId: "vmap",
	            initPosition: new vw.CameraPosition(
	                new vw.CoordZ(lon, lat, 500),
	                new vw.Direction(0, -15, 0)
	            ),
	            logo: true,
	            navigation: true
	        };

	        try {
	            map = new vw.Map();
	            map.setOption(options);
	            map.start();

	            // 모델은 조금 더 나중에
	            setTimeout(() => {
	                loadShipModel(modelUrl, lon, lat);
	            }, 1500);
	        } catch (e) {
	            console.error("💥 map.start() 내부 오류:", e);
	            alertify.alert("지도를 초기화하는 중 오류가 발생했습니다.");
	        }

	}


	/**
	 * 선박 3D 모델을 지도에 로드하는 함수
	 * @param {string} url - 3D 모델 파일의 URL
	 * @param {number} lon - 경도
	 * @param {number} lat - 위도
	 */
	function loadShipModel(url, lon, lat) {
		if (!url) {
			console.warn("표시할 3D 모델의 URL이 없습니다.");
			return;
		}

		var id = "shipModel_" + new Date().getTime(); // 중복되지 않는 고유 ID 생성
		var point = new vw.CoordZ(lon, lat, 5); // 모델을 표시할 좌표 (고도는 1로 설정)
		
		// 모델 크기 옵션 (필요에 따라 값을 조절)
		var options = { scale: 1000, minimumPixelSize: 150 };

		var modelz = new vw.geom.ModelZ(id, url, point, options);
		modelz.create();

		// (선택 사항) 모델에 클릭 이벤트를 추가하여 팝업을 띄울 수 있습니다.
		var eventHandler = function(windowPosition, ecefPosition, cartographic, featureInfo) {
			if (featureInfo != null) {
				var html = `<strong>Ship Details</strong><br>위도: ${lat.toFixed(6)}<br>경도: ${lon.toFixed(6)}`;
				var title = "선박 정보";
				// 이전 팝업이 있다면 제거
				if (map.getPopup("shipPopup")) {
					map.getPopup("shipPopup").destroy();
				}
				var pop = new vw.Popup("shipPopup", "vmap", title, html, 250, 150, windowPosition.x, windowPosition.y);
				pop.create();
			}
		};
		modelz.addEventListener(eventHandler);
	}

	// fetchShipLocation 함수는 그대로 사용합니다.
	function fetchShipLocation(shipId, fallbackLat, fallbackLon) {
		return new Promise((resolve, reject) => { // reject를 추가하여 에러 처리
			$.ajax({
				url: "<%=request.getContextPath() %>/logistics/shipLocation.do",
				type: "post",
				dataType: "json",
				data: { shipId: shipId },
				success: function(result) {
					if (result && result.values) {
						resolve({
							lat: parseFloat(result.values.ship_lat),
							lon: parseFloat(result.values.ship_lon)
						});
					} else {
						// 성공했지만 데이터가 없는 경우, fallback 값 사용
						resolve({ lat: parseFloat(fallbackLat), lon: parseFloat(fallbackLon) });
					}
				},
				error: function(err) {
					console.error("AJAX Error:", err);
					// AJAX 요청 실패 시, fallback 값 사용
					resolve({ lat: parseFloat(fallbackLat), lon: parseFloat(fallbackLon) });
				}
			});
		});
	}
//----------------------------------------------------------------------------------------------------------
	// 배 이름을 클릭하여 위치를 지도에 표시
	$('.card-right').on('click', '.goShip', async function(event) {
		event.preventDefault();
		event.stopPropagation();

		const shipName = $(this).data("shipName");
//		const ship3dImg = $(this).data("ship3dImg"); // data-ship-3d-img 속성에서 URL 가져오기
		const shipId = $(this).data("shipId");
		const shipLon = $(this).data("shipLon");
		const shipLat = $(this).data("shipLat");
		//const ship3dImg = "${pageContext.request.contextPath}/ship3dImg/3dModelEx.glb";
		const ship3dImg = "/ship3dImg/3dModelEx.glb";
		console.log("shipId : " , shipId)
		console.log("shipLon : " , shipLon)
		console.log("shipLat : " , shipLat)
		try {

			// 1. 위경도 값을 비동기적으로 가져옵니다.
			const { lat, lon } = await fetchShipLocation(shipId, shipLat, shipLon);
			console.log("최종 좌표 -> 위도:", lat, "경도:", lon);

			// 2. Bootstrap 모달을 엽니다.
			shipMapModal.show();
			
			// 3. 모달이 완전히 화면에 표시된 후('shown.bs.modal' 이벤트) 지도를 초기화합니다.
			//    (div가 화면에 보여야 VWorld가 올바른 크기로 지도를 렌더링할 수 있습니다.)
			$('#shipMapModal').off('shown.bs.modal').on('shown.bs.modal', function () {
			    $('#vmap').replaceWith('<div id="vmap" style="width: 100%; height: 600px;"></div>');

			    // 🔐 100ms 지연 후 initMapAndLoadModel 실행
			    setTimeout(() => {
			        initMapAndLoadModel(lon, lat, ship3dImg, shipName);
			    }, 100);
			});



		} catch (err) {
			console.error("위치 정보를 가져오는데 실패했어요.", err);
			alertify.alert("선박 위치 정보를 가져오는 데 실패했습니다.");
		}
		
	});
//--------------------------------------------------------------------------------------------
// 모달 닫을때 이벤트
	$('#shipMapModal').on('hidden.bs.modal', function () {
	    location.href = location.href;
	});
	
//-----------------------------------------------------------------------------------------    
    // 수정 버튼 이벤트
    $("#openModifyModalBtn").on('click',()=>{
    	
    	var containerNo = "${containerVO.containerNo}";
    	var containerLocation = "${containerVO.containerLocation}";
    	var containerName = "${containerVO.containerName}";
    	var containerPrice = "${containerVO.containerPrice}";
    	var containerUseYn = "${containerVO.containerUseYn}";
    	
    	$('#modifyContainerNo').val(containerNo);
        $('#modifyContainerName').val(containerName);
        // select 태그의 경우, .val()로 값을 설정한 후 .prop('selected', true)로 해당 옵션을 선택 상태로 만듭니다.
        $('#modifyContainerLocation').val(containerLocation); // Bootstrap 5 select는 이 방식으로도 잘 작동합니다.
        $('#modifyContainerPrice').val(containerPrice);
        $('#modifycontainerUseYn').val(containerUseYn);
        
        
        if (containerUseYn==='true') { 
            $('#modifyContainerUseYn').prop('checked', true);
        } else {
            $('#modifyContainerUseYn').prop('checked', false);
        }
		
        $('#containerModifyModal').modal('show');
        
    });
    // 수정 완료 버튼 이벤트
    $('#submitModifyContainerBtn').on('click', function(){
    	
    	if (!$("#modifyContainerName").val()) { alertify.error("컨테이너이름를 입력해주세요!"); $('#modifyContainerName').focus(); return; }
		if (!$("#modifyContainerLocation").val()) { alertify.error("컨테이너 위치를 입력해 주세요."); $('#modifyContainerLocation').focus(); return; }
		if (!$("#modifyContainerPrice").val()) { alertify.error("컨테이너 이용금액을 입력해 주세요."); $('#modifyContainerPrice').focus(); return; }
		
		$("#modifyContainerUseYn").change(function(){
			  $("input[name='containerUseYn'][type='hidden']").val(this.checked ? true : false);
		});
		
    	
    	const formElement = document.querySelector('#containerModifyForm');
    	console.log(formElement);
		const formData = new FormData(formElement);
	  	console.log(formData);	
		
	  	$.ajax({
	  		url : "<%= request.getContextPath()%>/logistics/updateContainer.do",
	  		type : "POST", 
	  		processData: false, 
	        contentType: false,
	  		data : formData,
	  		dataType : "JSON",
			success : function(response){
				console.log(response)
				alertify.error("창고 기본 정보가 성공적으로 업데이트 되었습니다!")
				$('#containerModifyModal').modal('hide');
				location.reload();
			},
			error: function(xhr, status, error) {
                console.error("AJAX 오류:", error);
                alertify.error("업데이트 중 오류가 발생했습니다.");
            }
	  	});
    });
//--------------------------------------------------------
// 삭제버튼이벤트
    $('#deleteBtn').on('click',function(){
    	
    	var status = $(this).data("status");

    	var containerNo = "${containerVO.containerNo}";
    	
    	var userNo = `${userVO.userNo}`;
    	
    	if(status == "입고완료"){
    		alertify.error('입고된 물품이있어 삭제가 불가능합니다');
    		return;
    	}
    	
    	 $.confirm({
            title: '삭제 확인',
            content: '정말 삭제하시겠습니까?',
            buttons: {
                확인: {
                    btnClass: 'btn-primary',
                    action: function () {
                        $.ajax({
                            url: "<%= request.getContextPath()%>/logistics/deleteContainer.do",
                            type: "POST",
                            contentType: "application/json",
                            data: JSON.stringify({
                                containerNo: containerNo,
                            }),
                            dataType: "json",
                            success: function (response) {
                                $.alert({
                                    title: '알림',
                                    content: response.msg,
                                    onClose: function () {
                                        if (response.result === 1) {
                                            window.location.href = "<%=request.getContextPath()%>/logistics/myConatainer.do?userNo=" + userNo;
                                        }
                                    }
                                });
                            },
                            error: function () {
                                $.alert('삭제 중 오류가 발생했습니다.');
                            }
                        });
                    }
                },
                취소: {
                	btnClass: 'btn-red',
                	action: function () {}

                }
            }
        })
    });
 // ------------------------------------------------------------
    // 상세항목의 물품 상태 변경 적용 버튼 클릭 이벤트 (AJAX 요청)
    $('.status-select').on('change', function () {
    	const containerDetailNo = $(this).siblings('.info-label').data('containerDetailNo');
        const newStatus = $(this).val();
        let carrier = null;

        if (!newStatus) {
            $.alert("변경할 상태를 선택해주세요.");
            return;
        }

        // 입고완료 상태일 경우 모달로 운전자 선택 먼저
        if (newStatus === "입고완료") {
            $('#carrierSelectModal').modal('show');

            // 모달 내에서 운전자 선택 후 상태 변경 진행
            $(document).off('click.selectCarrier').on('click.selectCarrier', '.select-carrier-btn', function () {
                carrier = $(this).data('name');
                $('#carrierSelectModal').modal('hide');
                confirmAndSend(containerDetailNo, newStatus, carrier);
            });

        } else {
            // 다른 상태는 운전자 선택 없이 바로 상태 변경
            confirmAndSend(containerDetailNo, newStatus, carrier);
        }
    });

    // 상태 변경 확인 → Ajax 전송 함수
    function confirmAndSend(containerDetailNo, newStatus, carrier) {
        $.confirm({
            title: '상태 변경 확인',
            content: `물품의 상태를 '<strong>\${newStatus}</strong>' (으)로 변경하시겠습니까?`,
            buttons: {
                확인: {
                    btnClass: 'btn-primary',
                    action: function () {
                        $.ajax({
                            url: "<%=request.getContextPath()%>/logistics/updateContainerDetailStatus.do",
                            type: "POST",
                            contentType: "application/json",
                            data: JSON.stringify({
                                containerDetailNo: containerDetailNo,
                                containerDetailStatusCode: newStatus,
                                carrier: carrier
                            }),
                            dataType: "text",
                            success: function (cnt) {
                                if (cnt > 0) {
                                    $.alert({
                                        title: '완료',
                                        content: '업데이트 완료!',
                                        onClose: function () {
                                            location.reload();
                                        }
                                    });
                                } else {
                                    $.alert("상태 변경 실패: " + cnt);
                                }
                            },
                            error: function () {
                                $.alert("상태 변경 중 오류가 발생했습니다.");
                            }
                        });
                    }
                },
                취소: {
                    btnClass: 'btn-red',
                    action: function () {}
                }
            }
        });
    }

});
</script>	
</body>
</html>
