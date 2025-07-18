<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Border7</title>

	<%@ include file="../modules/header.jsp" %>
	<%@ include file="../modules/sidebar.jsp" %>
	<%@ include file="../modules/modal.jsp" %>
	<link rel="stylesheet" href="/css/sidebar.css">
	<link rel="stylesheet" href="/css/header.css">
	<link rel="stylesheet" href="/css/dashboard.css">
	<link rel="stylesheet" href="/css/main.css">
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
	<script src ="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js" ></script>
	<script src="https://cdn.jsdelivr.net/npm/echarts@5.6.0/dist/echarts.min.js"></script>
	<script src ="https://api.windy.com/assets/map-forecast/libBoot.js" ></script>
	
</head>
<style>
.select-container {
    display: flex; /* Flexbox 활성화 */
    gap: 10px;    /* 두 요소 사이에 간격 추가 (선택 사항) */
    align-items: center; /* 세로 중앙 정렬 (선택 사항) */
}
.yt-wrap{
	display: flex;
    justify-content: center;
    gap: 60px;
}
.yt-wrap > div {
	width: calc(50% - 60px);
    display: flex;
    align-items: center;
    justify-content: center;
}
.app-container{
		display: block;
	}
</style>
<body>
<sec:authentication property="principal" var="princ"/>
<c:if test="${princ ne 'anonymousUser'}">
	<sec:authentication property="authorities" var="auth"/>
	<c:set var="userVO" value="${princ.user }"/>
	<%-- <%@ include file="./roleMain/${auth}.jsp" %> --%>
</c:if>
<!------------------------------------>
<div class="app-container">
    <main class="main-content-area">
        <div class="content-header">
        	<c:choose>
        		<c:when test="${userVO.authCode eq 'ROLE_LOGISTICS' }">
        			<div class="titleTop"></div>
        			<div class="content-title">업무 대시보드</div>
        		</c:when>
        		<c:otherwise>
					<div class="welcome-section">
			            <div class="welcome-card">
			                <h2 class="welcome-title">환영합니다!</h2>
			                <p class="welcome-text">지금 Border7을 통해서 웹사이트 제작 수주와 사업의 확장을 노려보고 있습니다</p>
			            </div>
			        </div>
        		</c:otherwise>
        	</c:choose>
				<!-- 물류관리자의 메인 대시보드 시작-->
		<c:if test="${userVO.authCode eq 'ROLE_LOGISTICS' }">
		<div class="grid-container-2 ratio73">
			<div class="section ___card">
				<div class="section-header card-header">
                       <h3 class="section-title">최근 적재신청</h3>
                   </div>
				<div class="table-section">
	  				<table class="data-table" id="stowageTable">
	  					<thead>
							<tr>
								<th>번호</th>
								<th>적재신청 일시</th>
								<th>적재신청 타입</th>
								<th>컨테이너/물류창고 명</th>
								<th>물품명</th>
								<th>물품갯수</th>
								<th>물품 총부피(CBM)</th>
								<th>물품 가격(원)</th>
								<th>물품 상태</th>
							</tr>
						</thead>
	  					<tbody>
	  						<c:forEach items="${stowageList }" var="stowage" varStatus="vs" end="4">
	  							<tr>
									<td>${vs.index +1 }</td>
									<td>${stowage.stowageDate }</td>
									<td>${stowage.stowageType }</td>
									<td>
										<c:if test="${not empty stowage.warehouseVO}" >
											<a data-warehouse-no=${stowage.warehouseVO.whNo } 
												class="detail">
												${stowage.warehouseVO.whName }
											</a>
										</c:if>
										<c:if test="${not empty stowage.containerVO}">
											<a data-container-no=${stowage.containerVO.containerNo }
												class="detail">
												${stowage.containerVO.containerName }
											</a>	
										</c:if>
									</td>
									<td>${stowage.productVO.productName }</td>
									<td>${stowage.productVO.productQty } 개</td>
									<td>
									    <fmt:formatNumber value="${stowage.productVO.productQty * stowage.productVO.productVolume}"
									                      pattern="#0.00" /> CBM
									</td>
									<td>
										<fmt:formatNumber pattern="#,##0" value="${stowage.productVO.productQty  * stowage.productVO.productPrice  }" /> 원
									</td>
									<c:if test="${not empty stowage.warehouseVO}" >
										<td>${stowage.whDetailList[0].whDetailStatusCode}</td>
									</c:if>
									<c:if test="${not empty stowage.containerVO}">
										<td>${stowage.containerDetailList[0].containerDetailStatusCode }</td>
									</c:if>				
	  							</tr>
	  						</c:forEach>
	  					</tbody>	
	  				</table>
  				</div>
			</div>
			<div class="chart-section">
				<div class="section ___card">
					<div class="section-header card-header">
                        <h3 class="section-title">HS-CODE별 기간별 / 수입+수출 금액 통계 차트</h3>
                    </div>
                    <c:out value="${allStatistics }"></c:out>
                    <c:out value="${myStatistics }"></c:out>
                    <select id="hsCodeSelect" class="form-select"></select>
					<canvas id="myChart" width="500px" height="400px"></canvas>

				</div>
			</div>
		</div>			
		</c:if>
		
		<!-- 물류관리자의 메인 대시보드 끝 -->
        <!-- Middle Row -->
        <div class="grid-container-2 ratio73">
            <!-- News Section -->
            <div class="news-section">
                <div class="section ___card">
                    <div class="section-header card-header">
                        <h3 class="section-title">무역 뉴스</h3>
                    </div>
                    <div class="card-content-news">
                        <!-- 이미지 같은걸로 바꿀예정 -->
                        <div class="Loading"  style="text-align: center;">
	                        <div class=" spinner-border" role="status">
							  <span class="visually-hidden"></span>
							</div>        
                        </div>
                        
                    </div>
                </div>
            </div>
			<!-- News Section -->
            <!-- HS Code Statistics -->
            <div class="stats-section">
                <div class="section ___card">
                    <div class="section-header">
                        <h3 class="section-title">HS코드 분석</h3>
                    </div>
                    <div class="card-content">
                        <p class="stats-subtitle">HS코드 분석 및 통계 정보</p>
                        <div class="stats-grid">
                            <div class="stat-item">
                                <div class="stat-number">${exportCount}</div>
                                <div class="stat-label">수출 품목수</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">${importCount }</div>
                                <div class="stat-label">수입 품목수</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">${hsCodeCount }</div>
                                <div class="stat-label">주요 HS코드</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">${contractCount }</div>
                                <div class="stat-label">최근 7일 신규 등록 건수</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- HS Code Statistics -->
        </div>
		<!-- Middle Row -->
		
        <!-- Bottom Row -->
        <div class="grid-container-2">
            <!-- Exchange Rate Chart -->
            <div class="chart-section">
                <div class="section ___card">
                    <div class="section-header">
                        <h3 class="section-title">환율 정보</h3>
                    </div>
                    <div class="card-content">
                        <div class="exchange-rates">
                            <!-- <div class="rate-item">
                                <span class="currency">USD</span>
                                <span class="rate rate-up">1,350.50 원</span>
                            </div>
                            <div class="rate-item">
                                <span class="currency">EUR</span>
                                <span class="rate rate-down">1,480.70 원</span>
                            </div> -->
                            <div class="rate-item">
                                <span class="currency" style ="color:black; font-size:18px; font-weight:15px;"></span>
                            </div>
                            <div class="select-container">
	                            <select id="SrcNationList" class="form-select"></select>
	                            <select id="TgtNationList" class="form-select" ></select>
	                            </div>
                        </div>
                        <div class="chart-placeholder">
                            <canvas id="exchangeChart" width="600" height="300" >
                            </canvas>
                            
                        </div>
                    </div>
                </div>
            </div>
			<!-- Exchange Rate Chart -->
            <!-- Weather Section -->
            <div class="weather-section">
                <div class="section ___card">
                    <div class="section-header">
                        <h3 class="section-title">날씨 정보</h3>
                    </div>
                    <div class="card-content">
                       <div id="windy" style=" width: 100%; height: 400px;"></div>
						<script type="text/javascript">
							const options = {
								   
								    key:"Se3DHbwv2JTKrpLVl9A4vyvwTl3Sicfd", // REPLACE WITH YOUR KEY !!!
							
								    verbose: true,
							
								    lat: 37.5666103,
								    lon: 126.9783882,
								    zoom: 5,
								};
							
								// Initialize Windy API
								windyInit(options, windyAPI => {
							
								    const { map } = windyAPI;
							
							
								   /*  L.popup()
								        .setLatLng(["37.5666103", "126.9783882"])
								        .setContent('Hello World')
								        .openOn(map); */
								});
								
							
							</script>
                    </div>
                </div>
            </div>
             <!-- Weather Section -->
        </div>
		<!-- Bottom Row -->
		
        <!-- 유튜브 API Section -->
        <div class="api-section">
            <div class="section ___card">
                <div class="section-header">
                    <h3 class="section-title api-title">관세청 유튜브</h3>
                </div>
                <div class="card-content yt-wrap">
                	<div class="">
                		<iframe width="100%" height="370" src="https://www.youtube.com/embed/yT0fqS64zF8?si=4zZb8ygiXAtHREmA" 
	                    title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; 
	                    encrypted-media; gyroscope; picture-in-picture; web-share" 
	                    referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                	</div>
                	<div>
                		<iframe width="100%" height="370" src="https://www.youtube.com/embed/NGqHrZTL8Io?si=A2rQ7CpC7AcG7vue"
							title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                	</div>
                </div>
            </div>
        </div>
        <!-- 유튜브 API Section -->
    </main>
</div>
<script src ="${pageContext.request.contextPath}/js/chart.js"></script>
</body>
<script type="text/javascript">


let newshtml ="";
$.ajax({
    url: "/api/news",               
    method: "GET",                           
    dataType: "json"                        
}).
then(function(resp) { 
	console.log(resp[0]);
	for(let i = 0; i<5; i++){
		newshtml += ` 
			<div class="news-item">
				<h4 class="news-title">
					<a href="\${resp[i].kotraNewsUrl}" target="_blank" >\${resp[i].newsTitl} </a>
					<p class="timeStamp">\${date}</p>
				</h4>
			`;
		if(resp[i].cntntSumar != null ){
			newshtml += `<div class="news-con">\${resp[i].cntntSumar}</div>`;	
		}		
		newshtml += `</div>`;
	}
	console.log("html : ", newshtml);
	let targetHtml = $('.card-content-news .Loading')
	if(targetHtml.length >0){
		targetHtml.remove();
	}
	$('.card-content-news').append(newshtml)
   }).
   catch(function(error) { 
    console.log("API 뉴스 로드 중 오류 발생:", error);
    dbNews();
});


function dbNews(){
    $.ajax({
        url: "/api/dbNews",
        method: "GET",
        dataType: "json"
    })
    .then(function(resp) { 
        console.log(resp[0]);
      
        for(let i = 0; i<5; i++){
        	const dateString = resp[i].othbcDt;
        	const date = dateString.substring(0, 10);
        	newshtml += ` 
    			<div class="news-item">
    				<h4 class="news-title">
    					<a href="\${resp[i].kotraNewsUrl}" target="_blank" >\${resp[i].newsTitl} </a>
    					<p class="timeStamp">\${date}</p>
    				</h4>
    			`;
    		if(resp[i].cntntSumar != null ){
    			newshtml += `<div class="news-con">\${resp[i].cntntSumar}</div>`;	
    		}		
    		newshtml += `</div>`;
		}
        console.log("dbNewsHtml : ", newshtml);
 
		let targetHtml = $('.card-content-news .Loading')
		if(targetHtml.length >0){
			targetHtml.remove();
		}
		$('.card-content-news').append(newshtml)
    })
    .catch(function(error) { 
        console.log("DB 뉴스 로드 중 오류 발생:", error);
    });
}


document.addEventListener('DOMContentLoaded', () => {
	//코드분석 섹션 html 동적으로 만들기
	document.querySelectorAll('.stat-number').forEach(statNumberElement => {
	    const targetNumber = parseInt(statNumberElement.innerHTML, 10);
	    statNumberElement.innerHTML = '0'; // 초기값을 0으로 설정
	    let currentNumber = 0;
	    const duration = 2000; // 애니메이션 지속 시간 (밀리초)
	    const frameRate = 60; // 초당 프레임 수
	    const interval = 1000 / frameRate; // 각 프레임 간의 간격
	    const totalFrames = duration / interval; // 총 프레임 수
	    const increment = targetNumber / totalFrames; // 각 프레임당 증가량

	    let frame = 0;
	    const timer = setInterval(() => {
	        currentNumber += increment;
	        frame++;

	        if (frame >= totalFrames) {
	            currentNumber = targetNumber; // 최종 값으로 정확히 설정
	            clearInterval(timer); // 애니메이션 종료
	        }

	        // 숫자를 정수로 표시 (소수점 제거)
	        statNumberElement.textContent = Math.floor(currentNumber);
	    }, interval);
	});
	//$("#mainprocess").addClass("show")
});
//----------------------------------------------------------------------------
//물류관리자의 차트
$(function () {
  let allChartData = {}; // 모든 HS 코드의 전체 기간 데이터를 저장할 변수

  const hsCodeSelect = document.getElementById('hsCodeSelect');
  const ctx = document.getElementById('myChart');
  let mixedChart = null; // 차트 인스턴스를 저장할 변수

  // 차트 생성/업데이트 함수
  function createOrUpdateChart(selectedHsCodeKey) {
    if (!allChartData.myStatistics || !allChartData.allStatistics) {
      console.warn("차트 데이터를 불러오지 못했습니다.");
      return;
    }

    const myStats = allChartData.myStatistics;
    const allStats = allChartData.allStatistics;

    // 선택된 HS 코드에 대한 데이터 가져오기
    const myDataForSelectedHsCode = myStats[selectedHsCodeKey] || {};
    const allDataForSelectedHsCode = allStats[selectedHsCodeKey] || {};

    const chartLabels = []; // 월별 레이블 (예: 2025-01, 2025-02)
    const chartMyAmounts = [];
    const chartAllAmounts = [];

    // 모든 기간 키를 추출하여 정렬 >> 6개월 
    const periods = new Set();
    for (const month in myDataForSelectedHsCode) periods.add(month);
    for (const month in allDataForSelectedHsCode) periods.add(month);

    let sortedPeriods = Array.from(periods).sort(); // 기간을 오름차순으로 정렬

    // 최근 6개월 데이터만 선택 (가장 최신 월부터 역순으로 6개)
    // 데이터가 6개월 미만이면 있는 데이터만 사용
    if (sortedPeriods.length > 6) {
      sortedPeriods = sortedPeriods.slice(sortedPeriods.length - 6);
    }

    sortedPeriods.forEach(period => {
      chartLabels.push(period); // 레이블에 기간 추가
      chartMyAmounts.push(myDataForSelectedHsCode[period]?.amount || 0);
      chartAllAmounts.push(allDataForSelectedHsCode[period]?.amount || 0);
    });

    // HS 코드와 한글명 추출하여 제목에 사용
    const hsCodeMatch = selectedHsCodeKey.match(/hsCode=([0-9]{10})/);
    const hsKrNameMatch = selectedHsCodeKey.match(/hsKrName=([^\s,)]*)/);
    const hsCode = hsCodeMatch ? hsCodeMatch[1] : selectedHsCodeKey;
    const hsKrName = hsKrNameMatch ? decodeURIComponent(hsKrNameMatch[1]) : '';
    const chartTitle = `\${hsCode} (\${hsKrName}) 기간별 금액 비교 (MY vs ALL)`;

    // 기존 차트가 있다면 파괴하고 새로 생성
    if (mixedChart) {
      mixedChart.destroy();
    }

    mixedChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: chartLabels, // 기간별 레이블
        datasets: [
          {
            label: '내 거래 금액 (MY)',
            data: chartMyAmounts,
            backgroundColor: 'rgba(54, 162, 235, 0.6)',
            order: 2,
          },
          {
            label: '전체 거래 금액 (ALL)',
            data: chartAllAmounts,
            type: 'line',
            borderColor: 'rgba(255, 99, 132, 1)',
            fill: false,
            tension: 0.3,
            order: 1,
          },
        ],
      },
      options: {
        responsive: true,
        plugins: {
          title: {
            display: true,
            text: chartTitle, // HS 코드에 따른 동적 제목
          },
        },
        scales: {
          y: {
            beginAtZero: true,
            title: {
              display: true,
              text: '금액 (원)',
            },
          },
          x: { // x축도 시간 순서대로 정렬되도록 설정
            title: {
              display: true,
              text: '기간',
            }
          }
        },
      },
    });
  }

  $.ajax({
    url: "<%=request.getContextPath()%>/api/chartInfo.do",
    type: "POST",
    contentType: "application/json",
    success: function (response) {
      allChartData = response; // 전체 API 응답 데이터를 저장

      const allStats = response.allStatistics;
      const hsCodeKeys = Object.keys(allStats); // 모든 HS 코드 키 추출

      // HS 코드 셀렉트 박스 채우기
      hsCodeSelect.innerHTML = ''; // 기존 옵션 비우기
      hsCodeKeys.forEach(key => {
        const hsKrNameMatch = key.match(/hsKrName=([^\s,)]*)/);
        const hsKrName = hsKrNameMatch ? decodeURIComponent(hsKrNameMatch[1]) : '';
        const option = document.createElement('option');
        option.value = key;
        option.textContent = hsKrName ? `\${hsKrName} (\${key.split(',')[0].replace('HsCodeVO(hsCode=', '')})` : key;
        hsCodeSelect.appendChild(option);
      });

      // 셀렉트 박스 변경 이벤트 리스너
      hsCodeSelect.addEventListener('change', (event) => {
        createOrUpdateChart(event.target.value);
      });

      // 초기 차트 로드: 첫 번째 HS 코드 데이터를 사용하여 차트 표시
      if (hsCodeKeys.length > 0) {
        hsCodeSelect.value = hsCodeKeys[0]; // 첫 번째 HS 코드 선택
        createOrUpdateChart(hsCodeKeys[0]);
      } else {
        console.log("HS 코드 데이터가 없습니다.");
        // 차트 대신 메시지를 표시할 수 있습니다.
        ctx.style.display = 'none'; // 캔버스 숨기기
        const noDataMessage = document.createElement('p');
        noDataMessage.textContent = "표시할 HS 코드 데이터가 없습니다.";
        document.querySelector('.chart-section .section.___card').appendChild(noDataMessage);
      }
    },
    error: function (xhr, status, error) {
      console.error("차트 데이터 로드 실패 오류:", error);
      alertify.error("차트 데이터를 불러오는 데 오류가 발생했습니다. 다시 시도해주세요.");
    },
  });

  //----------------------------------------------------------------------------------------------
  // 상세페이지 이동 이벤트
  $('#stowageTable').on('click', '.detail', function (event) {
    const containerNo = $(this).data("containerNo");
    const warehouseNo = $(this).data("warehouseNo");

    if (containerNo != null) {
      window.location.href = "<%= request.getContextPath() %>/logistics/containerDetail.do?containerNo=" + containerNo;
    }

    if (warehouseNo != null) {
      window.location.href = "<%= request.getContextPath() %>/logistics/warehouseDetail.do?whNo=" + warehouseNo;
    }
  });
//----------------------------------------------------------------------------------------------
});
</script>
</html>
