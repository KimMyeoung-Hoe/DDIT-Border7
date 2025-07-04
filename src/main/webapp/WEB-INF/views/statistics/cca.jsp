<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../modules/header.jsp"%>
<%@ include file="../modules/sidebar.jsp"%>
<link rel="stylesheet" href="/css/main.css">
</head>
<style>
.tabs {
	display: flex;
	background: #f8fafc;
	border-bottom: 1px solid #e2e8f0;
	overflow-x: auto;
}

.tab-buttons {
	background: none;
	border: none;
	padding: 20px 25px;
	cursor: pointer;
	font-size: 0.95rem;
	font-weight: 600;
	color: #64748b;
	transition: all 0.2s;
	white-space: nowrap;
	border-bottom: 3px solid transparent;
}

.tab-buttons:hover {
	background: #f1f5f9;
	color: #334155;
}

.tab-buttons.active {
	background: white;
	color: #1e293b;
	border-bottom-color: #3b82f6;
}

.tab-content {
	display: none;
	padding: 30px;
}

.tab-content.active {
	display: block;
}

.chart-container {
	width: 80%; /* 원하는 너비 설정 */
	height: 400px; /* 원하는 높이 설정 */
	margin: 20px auto; /* 중앙 정렬 */
	background-color: #f9f9f9;
	padding: 15px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
</style>
<body>
	<div class="app-container">
		<main class="main-content-area">
			<div class="content-header">
				<!-- 브레드크럼 엘리먼트 -->
				<div class="breadcrumb-warp">
					<div class="col-sm-12">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="/">Home</a></li>
							<li class="breadcrumb-item"><a href="/consignor/ccaList.do">관세사
									정보</a></li>
						</ol>
					</div>
				</div>

				<div class="content-title">상세 통계 분석</div>
				<p class="desc">각 제재 사유별 상세 현황을 확인하세요</p>

				<div class="container section">
					<a href="http://localhost:3000">메인으로</a><br />

					<div style="display: flex;flex-wrap: wrap;justify-content: space-between;">
						<div class="main-content">

							<button class="tab-buttons" value="1" style="border: 1px solid;">양식불충분</button><br/>
							<button class="tab-buttons" value="2" style="border: 1px solid;">검사/검역 불합</button><br/>
							<!-- <button class="tab-button" value="4" style="border: 1px solid;">유효기간 초과한 서류 이용</button><br/> -->
							<button class="tab-buttons" value="5" style="border: 1px solid;">보세창고 기간 초과</button><br/>

						</div>
						<div id="sanctionArea"></div>
					</div>
				</div>
			</div>

		</main>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">
 $(function(){
	 let mySanctionInstance = null;
	 let tabBtns = $(".tab-buttons");
	 let sanctionArea = $("#sanctionArea");
	 
	 tabBtns.on("click",function(){
		 let value = $(this).val();
		 console.log(value);
		 
		 $.ajax({
			url:"/statistics/selectSanctionList",
			type: "get",
			data : {sanctionCode : value},
			success:function(result){
				console.log(result);
				const labels = []; //월/년
				const counts = []; //건수
				
				if(result && result.length > 0){
					//데이터가 있으면
					result.forEach(function(item){
						labels.push(item.YEAR_MONTH);
						counts.push(item['COUNT(*)']);
					});
				}else{
					 sanctionArea.html("<p style='text-align: center; font-size: 1.2em; color: #888;'>데이터가 없습니다.</p>");
					 //기존 차트 인스턴스가 있으면 파괴
					  if (mySanctionInstance) {
                        mySanctionInstance.destroy();
                        mySanctionInstance = null;
                    }
					 return;
				}
				
				sanctionArea.empty();//일단 기존 내용 지워
				const canvasElement = document.createElement('canvas');
				canvasElement.id= "mySanctionChart";
				canvasElement.style.width = '100%';
				canvasElement.style.height = '400px';
				sanctionArea.append(canvasElement);
				
				const ctx = canvasElement.getContext('2d');
			
				 if (mySanctionInstance) {
	                    mySanctionInstance.destroy();
	              }

				 mySanctionInstance = new Chart(ctx, {
	                    type: 'bar', // 막대 그래프 (원하면 'line'으로 변경 가능)
	                    data: {
	                        labels: labels, // X축 레이블 (월/년)
	                        datasets: [{
	                            label: `제재 발생 건수 (Code: \${value})`, // 차트 제목 (범례)
	                            data: counts,          // Y축 데이터 (건수)
	                            backgroundColor: 'rgba(75, 192, 192, 0.6)', // 막대 색깔
	                            borderColor: 'rgba(75, 192, 192, 1)',
	                            borderWidth: 1
	                        }]
	                    },
	                    options: {
	                        responsive: true,
	                        maintainAspectRatio: false, // 컨테이너에 맞춰 크기 조절
	                        scales: {
	                            y: {
	                                beginAtZero: true, // Y축을 0부터 시작
	                                title: {
	                                    display: true,
	                                    text: '건수' // Y축 제목
	                                }
	                            },
	                            x: {
	                                title: {
	                                    display: true,
	                                    text: '월' // X축 제목
	                                }
	                            }
	                        },
	                        plugins: {
	                            title: {
	                                display: true,
	                                text: `월별 제재 발생 현황 (Code: \${value})`, // 차트 메인 제목
	                                font: { size: 16 }
	                            },
	                            legend: {
	                                display: true, // 범례 표시 여부
	                                position: 'top' // 범례 위치
	                            }
	                        }
	                    }
	                });
				
				
			}
			 
			 
		 })
	 })
	 
 }) 
</script>
</html>