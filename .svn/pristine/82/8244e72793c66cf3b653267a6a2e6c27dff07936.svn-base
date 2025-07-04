<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공무원 통계 지원</title>
<%@ include file="../modules/header.jsp"%>
<%@ include file="../modules/sidebar.jsp"%>
<link rel="stylesheet" href="/css/main.css">
</head>
<style>
/* cca.jsp와 동일한 스타일을 적용 */
.tabs {
	display: flex;
	background: #f8fafc;
	border-bottom: 1px solid #e2e8f0;
	overflow-x: auto;
}
.tab-button {
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
.tab-button:hover {
	background: #f1f5f9;
	color: #334155;
}
.tab-button.active {
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
							<li class="breadcrumb-item"><a href="/statistics/servant.do">통계지원</a></li>
						</ol>
					</div>
				</div>

				<div class="content-title">통계 조회</div>
				<p class="desc">Border7 이용 통계를 조회하는 화면입니다.</p>
			</div>
            
            <div class="container section">
            <div id="appealChartArea"></div>
                    <div class="main-content"style="display: flex;justify-content: center;">
                        <button class="tab-button btn" value="기타" ><small><strong>기타</strong></small></button><br/>
                        <button class="tab-button btn" value="건의사항" ><small><strong>건의사항</strong></small></button><br/>
                        <button class="tab-button btn" value="불편사항" ><small><strong>불편사항</strong></small></button><br/>
                    </div>
            </div>
            
           	<div class="container section">
				<div id="sanctionArea"></div>
					<div class="main-content"style="display: flex;justify-content: center;">
						<button class="tab-buttons btn " value="1" ><small><strong>양식불충분</strong></small></button><br/>
						<button class="tab-buttons btn" value="2" ><small><strong>검사/검역 불합</strong></small></button><br/>
						<button class="tab-buttons btn" value="5" style="width: 200px" ><small><strong>보세창고 기간 초과</strong></small></button><br/>
					</div>
			</div>
           
           	<div class="container section">
				<div style="display: flex;flex-wrap: wrap;justify-content: space-between;">
					<div class="main-content">
						<div id="workLoadArea"></div>
					</div>
				</div>
			</div>
			
           	<div class="container section">
				<div style="display: flex; flex-wrap: wrap; justify-content: space-between;">
					<div class="main-content">
						<div id="userLoadArea">
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">
 $(function(){
	 let myChartInstance = null;
	 let tabBtn = $(".tab-button");
	 let appealChartArea = $("#appealChartArea"); 
	 
	 tabBtn.on("click",function(){
		 let value = $(this).val();
		 console.log(value);
		 
		 $.ajax({
			url: "/statistics/selectAppealList", 
			type: "get",
			data : { appealType : value }, 
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
					 appealChartArea.html("<p style='text-align: center; font-size: 1.2em; color: #888;'>데이터가 없습니다.</p>");
					 //기존 차트 인스턴스가 있으면 파괴
					 if (myChartInstance) {
                        myChartInstance.destroy();
                        myChartInstance = null;
                     }
					 return;
				}
				
				appealChartArea.empty(); //일단 기존 내용 지워
				const canvasElement = document.createElement('canvas');
				canvasElement.id= "myAppealChart"; // id 변경
				canvasElement.style.width = '100%';
				canvasElement.style.height = '400px';
				appealChartArea.append(canvasElement);
				
				const ctx = canvasElement.getContext('2d');
			
				if (myChartInstance) {
	                myChartInstance.destroy();
	            }

				myChartInstance = new Chart(ctx, {
	                type: 'line', // 라인 그래프 ('bar'로 변경 가능)
	                data: {
	                    labels: labels, // X축 레이블 (월/년)
	                    datasets: [{
	                        label: '[' + value + '] 민원 월별 발생 건수', // 차트 제목 (범례)
	                        data: counts,          // Y축 데이터 (건수)
                            fill: false,
	                        borderColor: 'rgb(54, 162, 235)',
	                        tension: 0.1
	                    }]
	                },
	                options: {
	                    responsive: true,
	                    maintainAspectRatio: false, // 컨테이너에 맞춰 크기 조절
	                    scales: {
	                        y: {
	                            beginAtZero: true, // Y축을 0부터 시작
                                ticks: {
                                    stepSize: 1
                                },
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
	                            text: '[' + value + '] 민원 월별 발생 현황', // 차트 메인 제목
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
		 });
	 });
	 
	 // 페이지가 로드되면 첫 번째 버튼을 클릭한 효과를 줌
	 tabBtn.first().trigger('click');
	 
	 /* 다진 */
	 let dajinChartInstance = null;
	 let workLoadArea = $("#workLoadArea"); 
	 
		
        function getRandomColor() {
            const letters = '0123456789ABCDEF';
            let color = '#';
            for (let i = 0; i < 6; i++) {
                color += letters[Math.floor(Math.random() * 16)];
            }
            return color;
        }
	
	$.ajax({
		url:"/statistics/servantWorkCount",
		type : "get",
		success:function(result){
			console.log(result);
			const labels = []; //월/년
			const datasets = {}; //건수
			let finalDatasets = [];
			
			if(result && result.length > 0){
				result.forEach(function(item){
					 const userName = item.USER_NAME + ' (' + item.SERVANT_NO + ')'; // 공무원 이름 (번호)
		                const workMonth = item.WORK_MONTH; // YYYY-MM 형식의 월

		                // 모든 unique한 work_month를 labels에 추가 (정렬된 상태로)
		                if (!labels.includes(workMonth)) {
		                    labels.push(workMonth);
		                }

		                // 공무원별 dataset 준비
		                if (!datasets[userName]) {
		                    datasets[userName] = {
		                        label: userName,
		                        data: [],
		                        borderColor: getRandomColor(), // 공무원별 다른 색상
		                        backgroundColor: 'rgba(0, 0, 0, 0)', // 라인 그래프이므로 배경 투명
		                        fill: false, // 라인 아래 영역을 채울지 여부
		                        tension: 0.1 // 라인의 부드러움 정도 (꺾은선형)
		                    };
		                }
		                
		                datasets[userName].data.push({
		                    x: workMonth,
		                    y: item.TOTAL_COUNT
		                });
				})
				  
	                
	                labels.sort();
					
					  finalDatasets = Object.values(datasets).map(dataset => {
			                const sortedData = [];
			                labels.forEach(month => {
			                    // 해당 월의 데이터 찾기, 없으면 0
			                    const dataPoint = dataset.data.find(d => d.x === month);
			                    sortedData.push(dataPoint ? dataPoint.y : 0);
			                });
			                dataset.data = sortedData;
			                return dataset;
			            });
	                
			}else {
	            workLoadArea.html("<p style='text-align: center; font-size: 1.2em; color: #888;'>데이터가 없습니다.</p>");
	            if (dajinChartInstance) {
	                dajinChartInstance.destroy();
	                dajinChartInstance = null;
	            }
	            return;
	        }
			  workLoadArea.empty(); // 기존 내용 지우기
		        const canvasElement = document.createElement('canvas');
		        canvasElement.id = "myServantWorkChart"; // ID 변경
		        canvasElement.style.width = '1500px';
		        canvasElement.style.height = '400px';
		        workLoadArea.append(canvasElement);

		        const ctx = canvasElement.getContext('2d');

		        if (dajinChartInstance) {
		            dajinChartInstance.destroy(); // 기존 차트 인스턴스 파괴
		        }

		        dajinChartInstance = new Chart(ctx, {
		            type: 'line', // 꺾은선형 그래프로 변경
		            data: {
		                labels: labels, // X축 레이블 (월/년)
		                datasets: finalDatasets // 여러 공무원의 데이터셋
		            },
		            options: {
		                responsive: true,
		                maintainAspectRatio: false, // 컨테이너에 맞춰 크기 조절
		                scales: {
		                    y: {
		                        beginAtZero: true, // Y축을 0부터 시작
		                        title: {
		                            display: true,
		                            text: '업무 처리 건수' // Y축 제목
		                        }
		                    },
		                    x: {
		                        title: {
		                            display: true,
		                            text: '월 (YYYY-MM)' // X축 제목
		                        }
		                    }
		                },
		                plugins: {
		                    title: {
		                        display: true,
		                        text: '직원별 기간별 총 업무 처리량', // 차트 메인 제목
		                        font: { size: 18 }
		                    },
		                    legend: {
		                        display: true, // 범례 표시 여부
		                        position: 'bottom', // 범례 위치
		                        labels: {
		                            font: {
		                                size: 10 // 글꼴 크기 줄이기
		                            },
		                            boxWidth: 10, // 색상 상자 크기 줄이기
		                            padding: 8 // 범례 항목 간의 여백 줄이기
		                        }
		                    },
		                    tooltip: { // 툴팁 커스터마이징 (필요시)
		                        callbacks: {
		                            label: function(context) {
		                                let label = context.dataset.label || '';
		                                if (label) {
		                                    label += ': ';
		                                }
		                                if (context.parsed.y !== null) {
		                                    label += context.parsed.y + '건';
		                                }
		                                return label;
		                            }
		                        }
		                    }
		                }
		            }
		        });
			
			
		}
	})
	
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
	 // 페이지가 로드되면 첫 번째 버튼을 클릭한 효과를 줌
	 tabBtns.first().trigger('click');
	
	 // 기간별 회원 가입/탈퇴 수 그래프 ----------------------------------------------------------
	 let userLoadChartInstance = null;
	 let userLoadArea= $("#userLoadArea");
	 
	 const authCodeMap = {
         'ROLE_CONSIGNOR': '화주',
         'ROLE_CCA': '관세사',
         'ROLE_LOGISTICS': '물류관리자'
	 };
	 
	 $.ajax({
			url:"/statistics/userCount",
			type : "get",
			success:function(result){
				console.log("기간별 회원 가입/탈퇴 수 데이터:", result);
				const labels = []; // 월 (YYYY-MM)
				const joinDatasets = {}; // 가입자 수를 위한 데이터셋
				const withdrawDatasets = {}; // 탈퇴자 수를 위한 데이터셋
				let finalDatasets = [];
				
	            if(result && result.length > 0){
					result.forEach(function(item){
						const authCode = item.AUTH_CODE;
						const month = item.MONTH;
	                    // 매핑된 한글 이름 가져오기 (없으면 원래 AUTH_CODE 사용)
	                    const displayAuthName = authCodeMap[authCode] || authCode;
						
						if (!labels.includes(month)) {
		                    labels.push(month);
		                }
						
						// 가입자 데이터셋 준비
		                if (!joinDatasets[authCode]) {
		                    joinDatasets[authCode] = {
	                            // 수정된 부분: displayAuthName 사용
		                        label: displayAuthName + ' (가입)', 
		                        data: [],
		                        backgroundColor: getRandomColor(), 
		                        borderColor: 'rgba(0, 0, 0, 0)',
		                        borderWidth: 1,
		                        stack: 'joinStack' 
		                    };
		                }
		                joinDatasets[authCode].data.push({
		                    x: month,
		                    y: item.JOIN_COUNT
		                });

						// 탈퇴자 데이터셋 준비
		                if (!withdrawDatasets[authCode]) {
		                    withdrawDatasets[authCode] = {
	                            // 수정된 부분: displayAuthName 사용
		                        label: displayAuthName + ' (탈퇴)', 
		                        data: [],
		                        backgroundColor: adjustColor(getRandomColor(), -30), 
		                        borderColor: 'rgba(0, 0, 0, 0)',
		                        borderWidth: 1,
		                        stack: 'withdrawStack' 
		                    };
		                }
		                withdrawDatasets[authCode].data.push({
		                    x: month,
		                    y: item.WITHDRAW_COUNT
		                });
					});
					
					labels.sort(); 
		            
		            // 가입 데이터셋 최종화
		            Object.values(joinDatasets).forEach(dataset => {
		                const sortedData = [];
		                labels.forEach(month => {
		                    const dataPoint = dataset.data.find(d => d.x === month);
		                    sortedData.push(dataPoint ? dataPoint.y : 0);
		                });
		                dataset.data = sortedData;
		                finalDatasets.push(dataset);
		            });

		            // 탈퇴 데이터셋 최종화
		            Object.values(withdrawDatasets).forEach(dataset => {
		                const sortedData = [];
		                labels.forEach(month => {
		                    const dataPoint = dataset.data.find(d => d.x === month);
		                    sortedData.push(dataPoint ? dataPoint.y : 0);
		                });
		                dataset.data = sortedData;
		                finalDatasets.push(dataset);
		            });
					
	            }else {
	            	userLoadArea.html("<p style='text-align: center; font-size: 1.2em; color: #888;'>데이터가 없습니다.</p>");
		            if (userLoadChartInstance) {
		            	userLoadChartInstance.destroy();
		            	userLoadChartInstance = null;
		            }
		            return;
		        }
	            
	            userLoadArea.empty(); 
		        const canvasElement = document.createElement('canvas');
		        canvasElement.id = "userStatsChart"; 
		        canvasElement.style.width = '1500px';
		        canvasElement.style.height = '400px';
		        userLoadArea.append(canvasElement);

		        const ctx = canvasElement.getContext('2d');

		        if (userLoadChartInstance) {
		        	userLoadChartInstance.destroy(); 
		        }
		        
		        userLoadChartInstance = new Chart(ctx, {
		            type: 'bar', 
		            data: {
		                labels: labels, 
		                datasets: finalDatasets 
		            },
		            options: {
		                responsive: true,
		                maintainAspectRatio: false, 
		                scales: {
		                    y: {
		                        beginAtZero: true, 
		                        stacked: true, 
		                        title: {
		                            display: true,
		                            text: '회원수' 
		                        }
		                    },
		                    x: {
		                        stacked: true, 
		                        title: {
		                            display: true,
		                            text: '월 (YYYY-MM)' 
		                        },
		                        ticks: {
	                                maxRotation: 45, 
	                                minRotation: 0
	                            }
		                    }
		                },
		                plugins: {
		                    title: {
		                        display: true,
		                        text: '회원유형별 월별 가입/탈퇴 현황', 
		                        font: { size: 18 }
		                    },
		                    legend: {
		                        display: true, 
		                        position: 'bottom', 
		                        labels: {
		                            font: {
		                                size: 10 
		                            },
		                            boxWidth: 10, 
		                            padding: 8
		                        }
		                    },
		                    tooltip: { 
		                        mode: 'index', 
		                        intersect: false, 
		                        callbacks: {
		                            label: function(context) {
		                                let label = context.dataset.label || '';
		                                if (label) {
		                                    label += ': ';
		                                }
		                                if (context.parsed.y !== null) {
		                                    label += context.parsed.y + '건';
		                                }
		                                return label;
		                            }
		                        }
		                    }
		                }
		            }
		        });

	            // 색상 조정을 위한 헬퍼 함수 
	            function adjustColor(hex, lum) {
	                // validate hex string
	                hex = String(hex).replace(/[^0-9a-f]/gi, '');
	                if (hex.length < 6) {
	                    hex = hex[0]+hex[0]+hex[1]+hex[1]+hex[2]+hex[2];
	                }
	                lum = lum || 0;

	                // convert to decimal and change luminosity
	                var rgb = "#", c, i;
	                for (i = 0; i < 3; i++) {
	                    c = parseInt(hex.substr(i*2,2), 16);
	                    c = Math.round(Math.min(Math.max(0, c + (c * lum)), 255)).toString(16);
	                    rgb += ("00"+c).substr(c.length);
	                }
	                return rgb;
	            }
			}
		 });
	 
 }); 
</script>
</html>