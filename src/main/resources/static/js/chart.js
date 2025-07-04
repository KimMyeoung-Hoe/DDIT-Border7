
// 5초마다 한번씩 


let myChart = echarts.init(document.getElementById('exchangeChart'));
let data = [];
let total = {
	srcNationKrName: "",
	srcCurrencyName: "",
	tgtNationKrName: "",
	tgtCurrencyName: "",
	rate: "",
	date: ""
};
setInterval(rate, 50000);

function rate() {
	$.ajax({
		url: "/api/exchangeRate",
		method: "GET",
		dataType: "json",
		success: function(resp) {
			console.log(resp);
			data = resp.map(obj => { return [new Date(obj.time), obj.value] })
			console.log(data)
			total.date = resp[resp.length - 1].date;
			total.rate = resp[resp.length - 1].value;
			renderEChart(data)

			console.log(rateContent1)
		}
	})
}

let nationlist = [];


let rateContent1 = "";
let rateContent2 = "";
let srchtml = "";
let tgthtml = "";


$.when(
	$.ajax({
		url: "/api/nationlist",
		method: "GET",
		dataType: "json",
		success: function(resp) {
			console.log(resp);

			for (let i = 0; i < resp.length; i++) {

				if (resp[i].nationNo == "205") {
					total.srcCurrencyName = resp[i].currencyName;
					total.srcNationKrName = resp[i].nationKrName;
					srchtml += `<option value="${resp[i].nationNo}" selected>${resp[i].currencyName}</option>`;
				} else {
					srchtml += `<option value="${resp[i].nationNo}">${resp[i].currencyName}</option>`;
				}
			}

			console.log("nationlist : ", srchtml);
			$("#SrcNationList").append(srchtml);

		}
	}),


	$.ajax({
		url: "/api/nationlist",
		method: "GET",
		dataType: "json",
		success: function(resp) {
			console.log(resp);
			for (let i = 0; i < resp.length; i++) {
				if (resp[i].nationNo == "63") {
					total.tgtCurrencyName = resp[i].currencyName;
					total.tgtNationKrName = resp[i].nationKrName;
					tgthtml += `<option value="${resp[i].nationNo}" selected>${resp[i].currencyName}</option>`;
				} else {
					tgthtml += `<option value="${resp[i].nationNo}">${resp[i].currencyName}</option>`;
				}
			}
			console.log("nationlist : ", tgthtml);
			$("#TgtNationList").append(tgthtml);
		}
	})
).done(function() {
	console.log("리스트 완료")
	let initialSource = $("#SrcNationList :selected").val();
	let initialTarget = $("#TgtNationList :selected").val();

	nationChange(initialSource, initialTarget);
});

$("#SrcNationList").change(function() {
	let source = $("#SrcNationList :selected").val();
	let target = $("#TgtNationList :selected").val();
	nationChange(source, target)
});

$("#TgtNationList").change(function() {
	let source = $("#SrcNationList :selected").val();
	let target = $("#TgtNationList :selected").val();
	nationChange(source, target)

});


function nationChange(source, target) {
	$.ajax({
		url: `/api/exchangeRate?source=${source}&target=${target}`,
		method: "GET",
		dataType: "json",
		success: function(resp) {
			console.log(resp);
			data = resp.map(obj => { return [new Date(obj.time), obj.value] })
			total.date = resp[resp.length - 1].date;
			total.rate = resp[resp.length - 1].value
			console.log(data)
			nationUpdate(resp[0].source, resp[0].target)
			renderEChart(data)
			updateRateDisplay()


		}
	})
};

/*		1) name code가 각각 다른 테이블이야 // 백엔드 쪽에서 처릴를 할려 이렇게 하면 4개나 생겨 컬럼? 너무 드럽지 않나?
		2) 이거를 각각 source랑 target별로 저장해야돼*/
/*		 rateContent1 = `1 ${nationKrName} ${currencyCode} = ${data[length-1].value} ${nationKrName} ${currencyCode}
		${data[length-1].date}

		`; */

function updateRateDisplay() {
	let rateContentHtml = "";
	let rateContentHtml2 = "";
	// total 객체에 유효한 데이터가 있을 때만 표시
	if (total.rate && total.date && total.srcNationKrName && total.tgtNationKrName) {
		rateContentHtml = `
				<div class="nationSelect1" style="font-size:22px;">1 ${total.srcNationKrName} (${total.srcCurrencyName}) = </div>
				<span class ="rateDate" style="color:red; font-size:40px;">${total.rate} </span> 
				<span class="nationSelect2" style="font-size:30px;"> ${total.tgtNationKrName} (${total.tgtCurrencyName})</span>
		                           <div class ="rateDate" style="color: #65707f;">${total.date}시</div><div></div>`;
	   rateContentHtml2 = `
	   				<span class="nationSelect1" style="font-size:22px;">1 ${total.srcNationKrName} (${total.srcCurrencyName}) = </span>
	   				<span class ="rateDate" style="color:red; font-size:40px;">${total.rate} </span> 
	   				<span class="nationSelect2" style="font-size:30px;"> ${total.tgtNationKrName} (${total.tgtCurrencyName})</span>
	   		        <span class ="rateDate" style="color: #65707f;">${total.date}시</span>`;
	} else {
		rateContentHtml = "환율 정보 없음 또는 로딩 중...";
	}
	// ".currency" 클래스를 가진 요소에 내용을 삽입 (기존 내용 대체)
	// HTML에 <div class="currency" id="currentRateInfo"></div> 와 같이 ID를 부여하는 것이 좋습니다.
	$(".currency").html(rateContentHtml);
	$(".currency.main-currency").html(rateContentHtml2);
	console.log("화면 업데이트된 환율 정보:", rateContentHtml);
}

function nationUpdate(source, target) {
	$.ajax({
		url: "/api/nationlist",
		method: "GET",
		dataType: "json",
		success: function(resp) {
			console.log(resp);
			for (let i = 0; i < resp.length; i++) {
				if (resp[i].currencyCode == source) {
					total.srcCurrencyName = resp[i].currencyName;
					total.srcNationKrName = resp[i].nationKrName;

				} else if (resp[i].currencyCode == target) {
					total.tgtCurrencyName = resp[i].currencyName;
					total.tgtNationKrName = resp[i].nationKrName;

				}
			}
			console.log("바뀐 값 : ", total)

			updateRateDisplay()


		}
	})
}


function renderEChart(data) {
   console.log("renderEChart ", data)
   option = {

      xAxis: {
         type: 'time',
         // 데이터의 최대값에 맞춤
         splitLine: {
            show: false
         }
      },
      yAxis: {
         type: 'value',
         min: 'dataMin', // 데이터의 최소값에 맞춤
         max: 'dataMax',
         boundaryGap: [0, '100%'],
         splitLine: {
            show: false
         }
      },
      tooltip: {
         trigger: 'item'
         , axisPointer: {
              type: 'cross',
			  snap : false
          }
      },
      series: [
         {
            type: 'line',
            showSymbol: false,
            data: data,
			color: 'rgba(255, 0, 0, 0.5)', // 라인 컬러
			lineStyle: {
			                width: 3,
							},
			areaStyle: { // 영역 그라데이션
			                color: new echarts.graphic.LinearGradient(
			                    0, 0, 0, 1, 
			                    [
			                        { offset: 0.5, color: 'rgba(255, 0, 0, 0.4)' }, // 상단 (빨간색, 50% 투명도)
			                        { offset: 1, color: 'rgba(255, 255, 255, 0.1)' }  // 하단 (흰색, 10% 투명도)
			                    ]
			                )
			            },
            encode: {
                x: 'time',
                y: 'value',
                itemName: 'time',
                tooltip: ['value']
              }
         }
      ]
   };
   myChart.setOption(option, true);
}
