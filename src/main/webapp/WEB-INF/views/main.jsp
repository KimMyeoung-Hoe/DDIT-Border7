<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Border7</title>

	<%@ include file="./modules/header.jsp" %>
	<%@ include file="./modules/sidebar.jsp" %>
	<%@ include file="./modules/modal.jsp" %>
	<link rel="stylesheet" href="/css/sidebar.css">
	<link rel="stylesheet" href="/css/header.css">
	<link rel="stylesheet" href="/css/dashboard.css">
	<link rel="stylesheet" href="/css/main.css">
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
	<script src ="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js" ></script>
	<script src="https://cdn.jsdelivr.net/npm/echarts@5.6.0/dist/echarts.min.js"></script>
	<script src ="https://api.windy.com/assets/map-forecast/libBoot.js" ></script>
	
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
	
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

/* 환율 css  */
/* 이전 답변에서 제공된 CSS 코드 */
.exchange-comparison-container {
    max-width: 900px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    /* box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); */
}
.exchange-comparison-container {
max-width: none;
}

.search-bar {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    color: #000000;
    font-size: 16px;
    font-weight: 500;
}

.search-icon {
    font-size: 20px;
    margin-right: 8px;
}

.exchange-cards-wrapper {
    display: flex;
    gap: 15px;
    overflow-x: auto;
    padding-bottom: 10px;
    scrollbar-width: thin;
    scrollbar-color: #ccc transparent;
    position: relative;
    align-items: center;
}
.exchange-cards-wrapper::-webkit-scrollbar {
    height: 8px;
}
.exchange-cards-wrapper::-webkit-scrollbar-thumb {
    background-color: #ccc;
    border-radius: 4px;
}
.exchange-cards-wrapper::-webkit-scrollbar-track {
    background-color: transparent;
}

.exchange-card {
    flex-shrink: 0;
    width: 200px;
    padding: 15px;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    background-color: #fff;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    min-height: 100px;
}

.card-header {
    font-size: 14px;
    color: #5f6368;
    margin-bottom: 5px;
}

.card-value {
    font-size: 24px;
    font-weight: bold;
    color: #202124;
    margin-bottom: 10px;
}

.card-footer {
    display: flex;
    align-items: center;
    font-size: 13px;
}

.currency-code {
    color: #5f6368;
    margin-right: 8px;
}

.change-info {
    display: flex;
    align-items: center;
    padding: 2px 6px;
    border-radius: 4px;
    font-weight: 500;
}

.change-info.down {
    color: #d93025;
    background-color: #fce8e6;
}

.change-info.up {
    color: #1a73e8;
    background-color: #e8f0fe;
}

.change-info .arrow {
    margin-right: 3px;
}

.scroll-button {
    flex-shrink: 0;
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 50%;
    width: 48px;
    height: 48px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 24px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    color: #5f6368;
    margin-left: 15px;
}

.scroll-button:hover {
    background-color: #f8f8f8;
}

.scroll-button:active {
    background-color: #eee;
}
.grid-container-2.ratio55{
	display: flex;
}
.grid-container-2.ratio55 > .chart-section{
	width: 50%
}
.grid-container-2.ratio55 > .weather-section{
	width: 50%
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
        </div>
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
            	<div class="swiper-wrap">
					<div class="swiper mySwiper">
						<div class="swiper-wrapper">
							<div class="swiper-slide"><a href="https://www.customs.go.kr//kcs/na/ntt/selectNttList.do?mi=10600&amp;bbsId=2280" target="_blank" title="무역통계  A~Z까지 무역통계의 모든것을 알려드립니다! (새창으로 이동됩니다.)" ><img src="/upload/kcs/pm/img_5a0b586c-c5db-4a70-bc02-0f12a0ac8d571749608168832.jpg" alt="무역통계  A~Z까지 무역통계의 모든것을 알려드립니다"></a></div>
							<div class="swiper-slide"><a href="https://www.customs.go.kr//kcs/na/ntt/selectNttInfo.do?mi=2889&amp;bbsId=1341&amp;nttSn=10134954&amp;nttSnUrl=b572405a9436c68ca4f3b14434f4edd4" target="_blank" title="2025년 관세청 공공데이터 활용 경진대회 포스터 (새창으로 이동됩니다.)" ><img src="/upload/kcs/pm/img_12b97661-4a72-42d2-886f-9cb0a8d92f451747029552687.jpg" alt="2025년 관세청 공공데이터 활용 경진대회 - 2025.4.1(화) ~ 7.20(일)"></a></div>
							<div class="swiper-slide"><a href="https://www.customs.go.kr//kcs/na/ntt/selectNttInfo.do?mi=2913&amp;bbsId=1411&amp;nttSn=10084955&amp;nttSnUrl=220a1bda6e9e4b26ecde2d0f939d0671" target="_blank" title="기관사칭 보이스피싱 예방 (새창으로 이동됩니다.)" ><img src="/upload/kcs/pm/img_19bcbf8b-b772-486d-8e10-0284e5d98b5a1702451066226.jpg" alt="기관사칭 보이스피싱 예방 - 주요 체크사항 1. 세관은 국제번호를 이용하지 않습니다. 관세청 고객지원센터: 국번없이 125, 1660-4694는 민원실 번호가 아닙니다. 전자통관시스템 문의 1544-1285 2. 체납사실이 없는데 관세체납 안내? 세관에서 조사, 심사, 통관 등에 의한 관세 등을 미납한 경우가 아닌데 체납 안내는 받았다면 보이스피싱을 의심해봅시다. 문의는 해당번호가 아닌 관세청 고객지원센터 125나 해당세관으로! 보이스피싱 의심신고: 고객지원센터 국번없이 125, 보이스피싱 신고:  경찰청(112), 금융감독원(민원상담 1332)"></a></div>
							<div class="swiper-slide"><a href="https://unipass.customs.go.kr/csp/index.do?tgMenuId=MYC_MNU_00010987" target="_blank" title="관세청 홈페이지 밀수신고 (새창으로 이동됩니다.)" ><img src="/upload/kcs/pm/img_b63b21bb-b505-4a4e-8b94-a77d66bab4941674110457397.jpg" alt="밀수신고? 125 밀수신고센터로! 마약류, 밀수, 관세탈루, 불법외환, 기술유출 장비.물품 수출입 모두 125(이리로)!!"></a></div>
	                	</div>
					</div>
				</div>
                <div class="section ___card">
                    <div class="section-header">
                        <h3 class="section-title">수출입 집계</h3>
                    </div>
                    <div class="card-content">
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
                                <div class="stat-label">주요 HS코드 개수</div>
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
		<!-- 임시 start -->
		
		<div class="section">
			<div class="section-header">
                <h3 class="section-title">환율 정보</h3>
            </div>
			<div class="card-content">
				<div class="exchange-rates">
					<div class="rate-item">
						<span class="currency main-currency" style ="color:black; font-size:18px; font-weight:15px;"></span>
					</div>
					<div class="select-container">
                         <select id="SrcNationList" class="form-select"></select>
                         <select id="TgtNationList" class="form-select" ></select>
                     </div>
				</div>
				<div class="chart-placeholder">
 					<canvas id="exchangeChart" width="1434" height="300" ></canvas>
				</div>
				<div class="exchange-comparison-container">
				    <div class="search-bar">
				        <span class="search-icon">🔍</span>
				        <span class="search-text">전날 대비 환율 차이</span>
				    </div>
					<div class="exchange-cards-wrapper"></div>
				</div>
             </div>
		</div>
		
		<div class="grid-container-2">
			<div class="section ___card">
                    <div class="section-header">
                        <h3 class="section-title">날씨 정보</h3>
                    </div>
                    <div class="card-content">
                       <div id="windy" style=" width: 100%; height: 400px;"></div>
						<script type="text/javascript">
							const options = {
								    key:"xxx", // REPLACE WITH YOUR KEY !!!
								  	//key:"C2lokrIOuwWiHeyIgte87pfeEd9UAziE", // subKey 
								    verbose: true,
								    lat: 37.5666103,
								    lon: 126.9783882,
								    zoom: 5,
								};
								windyInit(options, windyAPI => {
								    const { map } = windyAPI;
								});
								
							
							</script>
                    </div>
                </div>
                
			<div class="section">
                <div class="section-header">
                    <h3 class="section-title api-title">관세청 유튜브</h3>
                </div>
                
                <div class="card-content">
                	<div class="">
                		<iframe width="100%" height="370" src="https://www.youtube.com/embed/yT0fqS64zF8?si=4zZb8ygiXAtHREmA" 
	                    title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; 
	                    encrypted-media; gyroscope; picture-in-picture; web-share" 
	                    referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                	</div>
                </div>
            </div>
		</div>
		<!-- 임시 end -->
        
    </main>
</div>
<script src ="${pageContext.request.contextPath}/js/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
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
var swiper = new Swiper(".mySwiper", {
    autoplay: {
       delay: 2500,
       disableOnInteraction: false,
     },
 });
 
 
 
 
 
 
 
 
document.addEventListener('DOMContentLoaded', () => {
	$.ajax({
		url : "/api/allExchangeRate",
		method: "GET",                           
	    dataType: "json" 
	})
	.then(function(resp) { 
		
		const ystRate = resp.yesterdayRates;
		const tdyRate = resp.todayRates;
		let html ="";
		for(let i = 0; i< tdyRate.length; i++){
			const tdyDealBasR = parseFloat(tdyRate[i].deal_bas_r);
            const ystDealBasR = parseFloat(ystRate[i].deal_bas_r);
            
            const change = tdyDealBasR - ystDealBasR;
            const percentageChange = (change / ystDealBasR * 100).toFixed(2);
            console.log("percentageChange", percentageChange)
			html += `
			
		        <div class="exchange-card">
		            <div class="card-header">KRW / \${ystRate[i].cur_unit}</div>
		            <div class="card-value">\${tdyRate[i].deal_bas_r}</div>
		            <div class="card-footer">
		                <span class="currency-code">\${ystRate[i].cur_unit}</span>
		                
		                
		    `
		    if(percentageChange>0){
			    html += `<span class="change-info up"> 
			    			<span class="arrow">↑
			    			</span>\${percentageChange}
			    `
		    }else{
			    html += ` <span class="change-info down">
	                		<span class="arrow">↓</span> \${percentageChange}
	                	  </span>
	            `
		    }
		   html += `
		            </div>
		        </div>
		   `
			
		
		}
		
		console.log("환율 html :",resp)
		$(".exchange-cards-wrapper").append(html);
	
	})
	
	  
})
</script>
</html>
