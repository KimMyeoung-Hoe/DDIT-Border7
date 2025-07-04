<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<%@ include file="../modules/modal.jsp" %>

<link rel="stylesheet" href="/css/main.css">
<!-- <link rel="stylesheet" href="/css/contract.css"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.js"></script>
<style type="text/css">
.dropdown-wrap{
	max-height: 330px;
	overflow: auto;
}
.dropdown-item{
	border-radius: 6px;
    width: calc(100% - 20px);
	padding: 4px 10px 4px 10px;
	margin: 10px;
}
.dropdown-item:hover{
	color: #fff;
    text-decoration: none;
    background-color: #007bff;
}
#hsSearchType{
	width: 200px !important;
}
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
							<li class="breadcrumb-item"><a href="/consignor/ccaList.do">관세사 정보</a></li>
							<c:choose>
								<c:when test="${not empty ccaVO.userNo }">
									<li class="breadcrumb-item"><a href="/consignor/detailCcaProfile/${ccaVO.userNo }">관세사 상세 정보</a></li>
								</c:when>
								<c:when test="${not empty contractVO.ccaName }">
									<li class="breadcrumb-item"><a href="/consignor/detailCcaProfile/${contractVO.ccaNo }">관세사 상세 정보</a></li>
								</c:when>
								<c:otherwise>
									<li class="breadcrumb-item"><a href="/">관세사 상세 정보</a></li>
								</c:otherwise>
							</c:choose>
							<li class="breadcrumb-item"><a href="#">기본 정보 입력</a></li>
						</ol>
					</div>
				</div>

				<div class="content-title">기본 정보 입력</div>
				<p class="desc">물품의 기본 정보를 입력하여 통관 의뢰 신청서를 작성해주세요.</p>

			</div>

			<div class="section">
				<!-- Progress Section -->
				<div class="progress-section">
					<div class="progress-bar-container">
						<div class="progress-bar">
							<div class="progress-step">
								<button class="step-circle active">1</button>
								<span class="step-label">관세사 선택</span>
							</div>
							<div class="progress-step">
								<button class="step-circle active"> 2 </button>
								<span class="step-label">기본 정보 입력</span>
							</div>
							<div class="progress-step">
								<button class="step-circle inactive"> 3 </button>
								<span class="step-label">서류 제출</span>
							</div>
						</div>
					</div>
				</div>
				
				<div class="container mb-3">
					<div class="row">
						<label for="hsSearchType" class="form-label col-sm-2">HS 코드 검색</label>
							<div class="col-sm-10 disflex">
								<select
									name="hsSearchType" id="hsSearchType" class="form-select">
									<option value="code">코드</option>
									<option value="krName">한글이름</option>
								</select>
								<div class="hs-search-input-wrapper">
									<input type="text" name="hsSearchWord" id="hsSearchWord"
										autocomplete="off" class="form-input" placeholder="값을 입력하세요" />
									<div class="dropdown dropdown-off" id="productselect">
										<div class="dropdown-wrap">
											<div class="dropdown-item"> 검색어를 입력하세용 </div>
											<div class="dropdown-item" data-hscode="0202300000" data-hsenname="Boneless Chuck Short Rib" data-hsenddate="2025-12-31" data-hsexportnaturecode="11201" data-hsimportnaturecode="12301" data-hskrname="소고기 갈비살" data-hsncc="11020201" data-hsnccname="소고기" data-hsqty="null" data-hsregdate="2002-01-01" data-hstariffrate="30" data-hstariffratetype="A" data-hsweight="KG">소고기 갈비살</div>
											<div class="dropdown-item" data-hscode="0203291000" data-hsenname="Streaky pork" data-hsenddate="2025-12-31 00:00:00" data-hsexportnaturecode="11101" data-hsimportnaturecode="12302" data-hskrname="삼겹살" data-hsncc="11020202" data-hsnccname="돼지고기" data-hsqty="null" data-hsregdate="2002-01-01 00:00:00" data-hstariffrate="25" data-hstariffratetype="A" data-hsweight="KG">삼겹살 돼지고기</div>
										</div>
									</div>
								</div>
						</div>
						
					</div>
				</div>
				

				<form action="/contract/insert" method="post" id="submitForm">
					<!-- <input type="hidden" name="consignorNo" id="consignorNo" value=""/> -->
					<c:if test="${not empty contractVO }">
						<input type="hidden" name="contractNo" id="contractNo" class="form-input" value="${contractVO.contractNo }" />
						<input type="hidden" name="productNo" id="productNo" class="form-input" value="${contractVO.productNo }" />
					</c:if>
					<div class="container">
						<div class="row">
							<label for="hsCode" class="form-label col-sm-2">HS 코드 <span class="essential"></span></label>
							<div class="form-input-wrapper col-sm-10">
								<input type="text" class="form-input hsCode" placeholder="HS 코드를 입력하세요" 
									value="${contractVO.productVO.hsCode }" disabled="disabled"/>
								<input type="hidden" name="hsCode" id="hsCode" class="form-input hsCode"
									value="${contractVO.productVO.hsCode }"/>
							</div>
						</div>
						<div class="row">
							<label for="ccaNo" class="form-label col-sm-2">관세사<span class="essential"></span></label>
							<div class="form-input-wrapper col-sm-10">
								<c:choose>
									<c:when test="${not empty ccaVO.userNo }">
										<input type="text" class="form-input"
											value="${ccaVO.ccaName }" disabled="disabled" />
										<input type="hidden" name="ccaNo" id="ccaNo"
											class="form-input" value="${ccaVO.userNo }" />
									</c:when>
									<c:when test="${not empty contractVO.ccaName }">
										<input type="text" class="form-input"
											value="${contractVO.ccaName }" disabled="disabled" />
										<input type="hidden" name="ccaNo" id="ccaNo"
											class="form-input" value="${contractVO.ccaNo }" />
									</c:when>
									<c:otherwise>
										<input type="text" name="ccaNo" id="ccaNo" class="form-input"
											placeholder="관세사 정보를 입력하세요" value="" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="row">
							<label for="contractType" class="form-label col-sm-2">수입/수출 구분<span class="essential"></span></label>
							<div class="form-input-wrapper col-sm-10">
								<c:choose>
									<c:when test="${not empty contractVO.contractType}">
										<input type="text" name="contractType" id="contractType" class="form-input"
											value="${contractVO.contractType }" disabled="disabled" />
									</c:when>
									<c:otherwise>
										<select name="contractType" id="contractType"
											class="form-select form-select-12">
											<option value="수입">수입</option>
											<option value="수출">수출</option>
										</select>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="row">
							<label for="productName" class="form-label col-sm-2">물품 명칭<span class="essential"></span></label>
							<div class="form-input-wrapper col-sm-10">
								<input type="text" name="productName" id="productName"
									class="form-input" placeholder="물품의 이름을 입력해주세요" value="${contractVO.productVO.productName }"/>
							</div>
						</div>
						<div class="row">
							<label for="productOrigin" class="form-label col-sm-2">물품 원산지<span class="essential"></span></label>
							<div class="form-input-wrapper col-sm-10">
								<input type="text" name="productOrigin" id="productOrigin"
									class="form-input" placeholder="물품의 원산지를 입력해주세요" value="${contractVO.productVO.productOrigin }"/>
							</div>
						</div>
						<div class="row">
							<label for="productQty" class="form-label col-sm-2">물품 수량 (개)<span class="essential"></span></label>
							<div class="form-input-wrapper col-sm-10">
								<input type="number" name="productQty" id="productQty"
									class="form-input" placeholder="물품의 수량을 입력해주세요" value="${contractVO.productVO.productQty }"/>
							</div>
						</div>
						<div class="row">
							<label for="productWeight" class="form-label col-sm-2">물품 중량 (KG)<span class="essential"></span></label>
							<div class="form-input-wrapper col-sm-10" >
								<input type="number" name="productWeight" id="productWeight"
									class="form-input" placeholder="물품의 중량을 입력해주세요" value="${contractVO.productVO.productWeight }"/>
							</div>
						</div>
						<div class="row">
							<label for="productVolume" class="form-label col-sm-2">물품 부피 (CBM)<span class="essential"></span></label>
							<div class="form-input-wrapper col-sm-10">
								<input type="number" name="productVolume" id="productVolume"
									class="form-input" placeholder="물품의 부피을 입력해주세요" value="${contractVO.productVO.productVolume }"/>
							</div>
						</div>
						<div class="row">
							<label for="productPrice" class="form-label col-sm-2">물품 단가 (원)<span class="essential"></span></label>
							<div class="form-input-wrapper col-sm-10">
								<input type="number" name="productPrice" id="productPrice" 
								class="form-input" placeholder="물품의 단가를 입력해주세요"  
								value="${contractVO.productVO.productPrice }">
							</div>
						</div>
					</div>

					<div class="btn-container">
						<c:set value="등록" var="btnText"/>
						<c:if test="${status eq 'u' }">
							<c:set value="수정" var="btnText"/>
						</c:if>
						<input type="button" id="submitBtn" value="${btnText }" class="btn btn-primary btn-c" />
					</div>

				</form>
			</div>
			<div class="btn-container autovalbtn">
				<input class="btn btn-primary btn-c btn-sm" id="autoval" value="자동" readonly/>
			</div>
		</main>
	</div>
</body>
<script type="text/javascript">
$(function(){
/* 	// localStorage에서 token 추출
	const token = localStorage.getItem("accessToken");
	// payload 추출
	const payload = token.split('.')[1];
	// Base64 디코딩
	const decoded = JSON.parse(atob(payload)); */
	/*   예시 JSON 데이터
	{
	   "typ": "JWT",
	   "iss": "발급자_정보", ==> application.properties에 작성 되어 있는 DDIT
	   "iat": 현재_타임스탬프, ==> 발급 당시 시간
	   "exp": 만료_타임스탬프, ==> 만료 기간 현재 1시간으로 잡아뒀습니다.
	   "sub": "사용자_ID",
	   "no": 사용자_No,
	   "id": "사용자_ID",
	   "auth": ["권한1"] ==> 리스트 형태
	} */
/* 	const userno = decoded.no;
	const userId = decoded.id;
	
	console.log(userno);
	$("#consignorNo").val(userno);
 */
	
	//인풋에 포커스 잡으면 드롭다운 보이기
	$("#hsSearchWord").on("focus",function(){
		$(this).parent().find(".dropdown").removeClass("dropdown-off")
	});
	//인풋에서 엔터눌러서 서밋되는거 막기
	$("#hsSearchWord").on("keydown", function(e) {
		if (e.key === "Enter") {
			e.preventDefault();
		}
	});
	//인풋에 포커스아웃되면 잡으면 드롭다운 숨기기
	$("#hsSearchWord").on("focusout",function(){
		setTimeout(() => {
			$(this).parent().find(".dropdown").addClass("dropdown-off");
			//$(".dropdown .dropdown-item").html("");
		}, 100);
	});
	
	//누를때마다 검색해서 가져오기
	$("#hsSearchWord").on("keyup",function(){
		let hsSearchType = $("#hsSearchType").val();
		let hsSearchWord = $("#hsSearchWord").val();
		let data = {
				hsSearchType : hsSearchType,
				hsSearchWord : hsSearchWord
		}
		
		$.ajax({
			url : "/api/hsCodeSearch.do",
			type : "post",
			contentType:"application/json; charset=utf-8",
			data : JSON.stringify(data),
			success : function(res){
				let htmlCode = '';
				//console.log(res)
				if(res == '' || res == null){
					htmlCode += '<div class="dropdown-item">조회된 내용이없습니다.</div>';
				}else{
					res.forEach(function(v,i) {
						htmlCode += '<div class="dropdown-item" data-hsCode="'+v.hsCode+'" data-hsEnName="'+v.hsEnName+'"';
						htmlCode += 'data-hsEndDate="'+v.hsEndDate+'" data-hsExportNatureCode="'+v.hsExportNatureCode+'"';
						htmlCode += 'data-hsImportNatureCode="'+v.hsImportNatureCode+'" data-hsKrName="'+v.hsKrName+'"';
						htmlCode += 'data-hsNcc="'+v.hsNcc+'" data-hsNccName="'+v.hsNccName+'"';
						htmlCode += 'data-hsQty="'+v.hsQty+'" data-hsRegDate="'+v.hsRegDate+'"';
						htmlCode += 'data-hsTariffRate="'+v.hsTariffRate+'" data-hsTariffRateType="'+v.hsTariffRateType+'"';
						htmlCode += 'data-hsWeight="'+v.hsWeight+'"';
						htmlCode += '>';
						
						//hscode로 검색시표시해줄것들
						if(data.hsSearchType == 'code'){
							htmlCode += v.hsCode;
						}
						//한글로 검색시표시해줄것들
						if(data.hsSearchType == 'krName'){
							htmlCode += v.hsKrName+" / "+v.hsNccName;
						}
						//영어로 검색시표시해줄것들
						
						htmlCode += '</div>';
					});
				}
				
				$("#productselect .dropdown-wrap").html(htmlCode);
			}
		})//ajax
		
	});

	//row 선택시
	$(".hs-search-input-wrapper").on("click", ".dropdown-item", function(){
		$("#hsSearchWord").parent().find(".dropdown").addClass("dropdown-off"); // 드롭다운 닫기
		
		//엘리먼트에서 데이터 추출
		let hsCode = $(this).data("hscode"); // HS 코드 가져오기
		let hskrname = $(this).data("hskrname"); // HS 코드 가져오기
		if($("#hsSearchType").val() == "code"){
			$("#hsSearchWord").val(hsCode);	
		}else{
			$("#hsSearchWord").val(hskrname);
		}
		
		
		//추출한 데이터 넣기
		$(".hsCode").val(hsCode); // HS 코드 설정
		$("#productName").val(hskrname); // HS 코드 설정
		//추가로 넣을 부분
	});
	
	const ccaNo = $("#ccaNo");
	const hsCode = $("#hsCode");
	const productName = $("#productName");
	const productOrigin = $("#productOrigin");
	const productQty = $("#productQty");
	const productWeight = $("#productWeight");
	const productVolume = $("#productVolume");
	const productPrice = $("#productPrice");
	
	const submitForm = $("#submitForm");
	const submitBtn = $("#submitBtn");
	
	submitBtn.on("click",function(){
		if(ccaNo.val() == null || ccaNo.val() == ""){
			alertify.alert("관세사를 선택해주세요");
			ccaNo.focus();
			return false;
		}
		
		if(hsCode.val() == null || hsCode.val() == ""){
			alertify.alert("HS CODE를 입력해주세요");
			hsCode.focus();
			return false;
		}
		if(productName.val() == null || productName.val() == ""){
			alertify.alert("물품의 명칭을 입력해주세요");
			productName.focus();
			return false;
		}
		if(productOrigin.val() == null || productOrigin.val() == ""){
			alertify.alert("물품의 원산지를 입력해주세요");
			productOrigin.focus();
			return false;
		}
		if(productQty.val() == null || productQty.val() == ""){
			alertify.alert("물품의 수량을 입력해주세요");
			productQty.focus();
			return false;
		}
		if(productWeight.val() == null || productWeight.val() == ""){
			alertify.alert("물품의 중량를 입력해주세요");
			productWeight.focus();
			return false;
		}
		if(productVolume.val() == null || productVolume.val() == ""){
			alertify.alert("물품의 부피를 입력해주세요");
			productVolume.focus();
			return false;
		}
		if(productPrice.val() == null || productPrice.val() == ""){
			alertify.alert("물품의 단가를 입력해주세요");
			productPrice.focus();
			return false;
		}
		
		const sbtn = document.querySelector("#submitBtn");
		if(sbtn.value === '수정'){
			const sForm = document.querySelector("#submitForm");
			sForm.action = '/contract/update'
		}
		
		let titleText=""
		let contentText=""
		
		if($("#contractType").val() =='수입'){
			titleText="기본 정보 입력 완료"
			contentText="세급 대납을 동의 하시겠습니까? <br/> 대납동의는 필수 사항입니다."
		}else{
			titleText="기본 정보 입력 완료"
			contentText="기본 정보 입력을 완료 하시겠습니까?"
		}
		$.confirm({
        	title: titleText,
   	       content: contentText,
   	       buttons: {
 				확인: {
 					btnClass: 'btn-primary',
 					action : function() {
 						submitForm.submit();
 					}
 				},
 				취소 : {
 					btnClass: 'btn-danger',
 					action : function() {
 						alertify.alert('작성을 취소 했습니다.');
 					}
   	          }
   	       }
   	    });
		
		
	});
	
	const countries = [
        "미국",
        "일본",
        "중국",
        "대만",
        "싱가포르",
        "베트남",
        "필리핀",
        "태국",
        "인도네시아",
        "멕시코",
        "브라질"
    ];
	const autoval = $("#autoval");
	
	function generateRandomString(length) {
        const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        let result = '';
        for (let i = 0; i < length; i++) {
            result += chars.charAt(Math.floor(Math.random() * chars.length));
        }
        return result;
    }

    function generateRandomNumber(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    function generateRandomFloat(min, max, fixed = 2) {
        return (Math.random() * (max - min) + min).toFixed(fixed);
    }
    autoval.on("click",function(){
    	
    	const randomIndex = Math.floor(Math.random() * countries.length);
	    const selectedCountry = countries[randomIndex];
	    
    	const randomQty = generateRandomNumber(10, 30);
        const randomWeight = generateRandomFloat(1, 50, 2);
        const randomVolume = generateRandomFloat(0.1, 5, 1);
        const randomPrice = generateRandomNumber(1000, 30000); 

        //document.getElementById('productName').value = "Product_" + generateRandomString(5);
        //document.getElementById('productOrigin').value = "Country_" + generateRandomString(3).toUpperCase();
        document.getElementById('productOrigin').value = selectedCountry;
        document.getElementById('productQty').value = randomQty;
        document.getElementById('productWeight').value = randomWeight;
        document.getElementById('productVolume').value = randomVolume;
        document.getElementById('productPrice').value = randomPrice; 
	});
});


</script>
</html>