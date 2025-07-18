<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관세사 한글표시사항 작성 페이지</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<%@ include file="../modules/modal.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.js"></script>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
			<div class="content-header">
				<div class="breadcrumb-warp">
					<div class="col-sm-12">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="/">Home</a></li>
							<li class="breadcrumb-item"><a href="#">한글표시사항 작성</a></li>
						</ol>
					</div>
				</div>
				<div class="content-title">한글표시사항 작성</div>
				<p class="desc">제품의 한글표시사항 작성 페이지입니다.</p>
			</div>
			<div class="section">
			
				<form action="<%= request.getContextPath() %>/cca/koreanLabelInsert.do" method="post" id="koreanLabelForm">
					<p style="font-size:17pt;"><label><strong>대리업무 일련번호 : </strong></label>
						<input type="hidden" name="contractNo" id="contractNo" value="${contractNo}"/>
						<span style="color:black; font-weight: bold; ">${contractNo}</span>
					</p>
					
					<div class="row">
						<label for="productNameKr" class="form-label col-sm-2">제품명 <span class="essential"></span></label>
						
						<div class="form-input-wrapper col-sm-10">
							<input type="text" name="productNameKr" id="productNameKr" class="form-input"
								placeholder="제품명을 입력해주세요." value="${krNotationVO.productNameKr}" />
						</div>
					</div>
					
					<div class="row">
						<label for="contentKr" class="form-label col-sm-2">중량 (KG/개) <span class="essential"></span></label>
						<div class="form-input-wrapper col-sm-10">
							<input type="text" name="contentKr" id="contentKr" class="form-input"
								placeholder="중량을 입력해주세요." value="${krNotationVO.contentKr}" readonly />
						</div>
					</div>
					
					<div class="row">
						<label for="ingredientsKr" class="form-label col-sm-2">원재료 명 <span class="essential"></span></label>
						<div class="form-input-wrapper col-sm-10">
							<input type="text" name="ingredientsKr" id="ingredientsKr" class="form-input"
								placeholder="원재료명을 입력해주세요." value="${krNotationVO.ingredientsKr}" readonly />
						</div>
					</div>
					
					<div class="row">
						<label for="meatTypePartKr" class="form-label col-sm-2">부위명 <span class="essential"></span></label>
						<div class="form-input-wrapper col-sm-10">
							<input type="text" name="meatTypePartKr" id="meatTypePartKr" class="form-input"
								placeholder="부위명을 입력해주세요." value="${krNotationVO.meatTypePartKr}" readonly />
						</div>
					</div>
					
					<div class="row">
						<label for="originKr" class="form-label col-sm-2">원산지 <span class="essential"></span></label>
						<div class="form-input-wrapper col-sm-10">
							<input type="text" name="originKr" id="originKr" class="form-input"
								placeholder="원산지를 입력해주세요." value="${krNotationVO.originKr}" readonly />
						</div>
					</div>
					
					<div class="row">
						<label for="manufactureDateKr" class="form-label col-sm-2">제조일자 <span class="essential"></span></label>
						<div class="form-input-wrapper col-sm-10">
							<input type="date" name="manufactureDateKr" id="manufactureDateKr" class="form-input"
								placeholder="제조연월일을 입력해주세요." value="<fmt:formatDate value='${krNotationVO.manufactureDateKr}' pattern='yyyy-MM-dd'/>" />
						</div>
					</div>
					
					<div class="row">
						<label for="consumptionDeadlineKr" class="form-label col-sm-2">소비기한 <span class="essential"></span></label>
						<div class="form-input-wrapper col-sm-10">
							<input type="date" name="consumptionDeadlineKr" id="consumptionDeadlineKr" class="form-input"
								placeholder="소비기한을 입력해주세요." value="<fmt:formatDate value='${krNotationVO.consumptionDeadlineKr}' pattern='yyyy-MM-dd'/>" />
						</div>
					</div>
									
					<div class="row">
						<label for="packagingMaterialKr" class="form-label col-sm-2">용기·포장 재질 <span class="essential"></span></label>
						<div class="form-input-wrapper col-sm-10">
							<input type="text" name="packagingMaterialKr" id="packagingMaterialKr" class="form-input"
								placeholder="용기·포장 재질을 입력해주세요." value="${krNotationVO.packagingMaterialKr}" />
						</div>
					</div>
					
					<div class="row">
						<label for="storageMethodKr" class="form-label col-sm-2">보관방법 <span class="essential"></span></label>
						<div class="form-input-wrapper col-sm-10">
							<textarea name="storageMethodKr" id="storageMethodKr" class="form-input"
								placeholder="보관방법을 입력해주세요." >${krNotationVO.storageMethodKr}</textarea>
						</div>
					</div>
					
					<div class="row">
						<label for="consignorName" class="form-label col-sm-2">수입업소명 <span class="essential"></span></label>
						<div class="form-input-wrapper col-sm-10">
							<input type="text" name="consignorName" id="consignorName" class="form-input"
								placeholder="수입업소명을 입력해주세요." value="${krNotationVO.consignorName}" readonly />
						</div>
					</div>
					
					<div class="row">
						<label for="fullConsignorAddr" class="form-label col-sm-2">수입업소 주소 <span class="essential"></span></label>
						<div class="form-input-wrapper col-sm-10">
							<input type="text" name="consignorfullAddr" id="consignorfullAddr" class="form-input"
								placeholder="수입업소 주소를 입력해주세요." value="${krNotationVO.consignorAddr} ${krNotationVO.consignorDetAddr}" readonly />
						</div>
					</div>
					
					<div class="row">
						<label for="consignorTel" class="form-label col-sm-2">수입판매업소의 연락처 <span class="essential"></span></label>
						<div class="form-input-wrapper col-sm-10">
							<input type="text" name="consignorTel" id="consignorTel" class="form-input"
								placeholder="수입판매업소의 연락처를 입력해주세요." value="${krNotationVO.consignorTel}" readonly />
						</div>
					</div>
					
					<div class="row">
						<label for="etcKr" class="form-label col-sm-2">주의사항 </span></label>
						<div class="form-input-wrapper col-sm-10">
							<input type="text" name="etcKr" id="etcKr" class="form-input"
								placeholder="주의사항을 입력해주세요." value="${krNotationVO.etcKr}" />
						</div>
					</div>
                    
                    <div class="btn-container">
                        <c:choose>
                        
                            <c:when test="${not empty krNotationVO.packagingMaterialKr }">
                                <input type="button" id="updBtn" value="수정" class="btn btn-primary btn-r"/>
                            </c:when>
                            <c:otherwise>
                                <input type="button" id="saveBtn" value="완료" class="btn btn-primary btn-r"/>
                            </c:otherwise>
                        </c:choose>
                        <input type="button" id="cancelBtn" value="취소" class="btn btn-warning btn-r"/>
                    </div>
				</form>
			</div>
			<div class="btn-container autovalbtn">
				<input class="btn btn-primary btn-c btn-sm" id="autoval" value="자동"/>
				<input class="btn btn-primary btn-c btn-sm" id="Presentation" value="입력(시연 때 쓸 것)"/>
			</div>
		</main>
	</div>

</body>
<script type="text/javascript">
const contextPath = '<%= request.getContextPath() %>';

$(function(){
	
	let cancelBtn = $("#cancelBtn");
	let saveBtn = $("#saveBtn");
	let updBtn = $("#updBtn"); 
	
    <c:if test="${not empty message}">
        alertify.error("${message}");
    </c:if>
    
    cancelBtn.on("click", function() {
        if(confirm("작성한 내용을 취소하시겠습니까?")){
        	location.href = contextPath + '/cca/ccaDetailContract/' + "${contractNo}";
        }
    });

    saveBtn.on("click", function() {
    	let productNameKr = $("#productNameKr").val();
    	let ingredientsKr = $("#ingredientsKr").val();
    	let meatTypePartKr = $("#meatTypePartKr").val();
    	let manufactureDateKr = $("#manufactureDateKr").val();
    	let consumptionDeadlineKr = $("#consumptionDeadlineKr").val();
    	let packagingMaterialKr = $("#packagingMaterialKr").val();
    	let storageMethodKr = $("#storageMethodKr").val();
    	let etcKr = $("#etcKr").val();
    	
    	if(productNameKr == null || productNameKr == ""){
    		alertify.error("제품명을 입력해주세요.")
    		$("#productNameKr").focus();
    		return false;
    	}
    	
    	if(ingredientsKr == null || ingredientsKr == ""){
    		alertify.error("원재료를 입력해주세요.")
    		$("#ingredientsKr").focus();
    		return false;
    	}
    	
    	if(meatTypePartKr == null || meatTypePartKr == ""){
    		alertify.error("부위명을 입력해주세요.")
    		$("#meatTypePartKr").focus();
    		return false;
    	}
    	
    	if(manufactureDateKr == null || manufactureDateKr == ""){
    		alertify.error("제조년월일을 선택해주세요.")
    		$("#manufactureDateKr").focus();
    		return false;
    	}
    	
    	if(consumptionDeadlineKr == null || consumptionDeadlineKr == ""){
    		alertify.error("소비기한을 선택해주세요.")
    		$("#consumptionDeadlineKr").focus();
    		return false;
    	}
    	
    	if(packagingMaterialKr == null || packagingMaterialKr == ""){
    		alertify.error("용기·포장 재질을 입력해주세요.")
    		$("#packagingMaterialKr").focus();
    		return false;
    	}
    	
    	if(storageMethodKr == null || storageMethodKr == ""){
    		alertify.error("보관방법을 입력해주세요.")
    		$("#storageMethodKr").focus();
    		return false;
    	}
    	
    	if(etcKr == null || etcKr == ""){
    		alertify.error("주의사항을 입력해주세요.")
    		$("#etcKr").focus();
    		return false;
    	}
    	
    	$.confirm({
            title: '한글표시사항 작성',
            content: '입력한 내용으로 한글표시사항을 저장하시겠습니까?',
            buttons: {
            확인: {
               btnClass: 'btn-primary',
               action : function() {
            	   $("#koreanLabelForm").submit(); 
               }
            },
            취소 : {
               btnClass: 'btn-danger',
               action : function() {
                  alertify.error('작성을 취소 했습니다.');
               }
               }
            }
       });
    });
    /*
    updBtn.on("click", function(){ 
        if (confirm("입력한 내용으로 한글표시사항을 수정하시겠습니까?")) {
            let productNameKr = $("#productNameKr").val();
        	let ingredientsKr = $("#ingredientsKr").val();
        	let meatTypePartKr = $("#meatTypePartKr").val();
        	let manufactureDateKr = $("#manufactureDateKr").val();
        	let consumptionDeadlineKr = $("#consumptionDeadlineKr").val();
        	let packagingMaterialKr = $("#packagingMaterialKr").val();
        	let storageMethodKr = $("#storageMethodKr").val();
        	let etcKr = $("#etcKr").val();
        	
        	if(productNameKr == null || productNameKr == ""){
        		alertify.error("제품명을 입력해주세요.")
        		$("#productNameKr").focus();
        		return false;
        	}
        	
        	if(ingredientsKr == null || ingredientsKr == ""){
        		alertify.error("원재료를 입력해주세요.")
        		$("#ingredientsKr").focus();
        		return false;
        	}
        	
        	if(meatTypePartKr == null || meatTypePartKr == ""){
        		alertify.error("부위명을 입력해주세요.")
        		$("#meatTypePartKr").focus();
        		return false;
        	}
        	
        	if(manufactureDateKr == null || manufactureDateKr == ""){
        		alertify.error("제조년월일을 선택해주세요.")
        		$("#manufactureDateKr").focus();
        		return false;
        	}
        	
        	if(consumptionDeadlineKr == null || consumptionDeadlineKr == ""){
        		alertify.error("소비기한을 선택해주세요.")
        		$("#consumptionDeadlineKr").focus();
        		return false;
        	}
        	
        	if(packagingMaterialKr == null || packagingMaterialKr == ""){
        		alertify.error("용기·포장 재질을 입력해주세요.")
        		$("#packagingMaterialKr").focus();
        		return false;
        	}
        	
        	if(storageMethodKr == null || storageMethodKr == ""){
        		alertify.error("보관방법을 입력해주세요.")
        		$("#storageMethodKr").focus();
        		return false;
        	}
        	
        	if(etcKr == null || etcKr == ""){
        		alertify.error("주의사항을 입력해주세요.")
        		$("#etcKr").focus();
        		return false;
        	}

			$("#koreanLabelForm").attr("action", contextPath + "/cca/koreanLabelUpdate.do");
			$("#koreanLabelForm").submit();
        }
    });
*/
    // 랜덤 데이터 생성 도우미 함수들
    function generateRandomString(length) {
    	const chars = '가나다라마바사아자차카타파하';
        let result = '';
        for (let i = 0; i < length; i++) {
            result += chars.charAt(Math.floor(Math.random() * chars.length));
        }
        return result;
    }

    // YYYY-MM-DD 형식으로 날짜를 변환하는 헬퍼 함수
    function formatDate(date) {
        return date.toISOString().split('T')[0];
    }
    
    $("#Presentation").on("click",function(e){
    	const manufactureDate = new Date('2025-06-04');	// "제조일자" 설정
    	const consumptionDeadline = new Date('2026-02-15');	// "소비기한" 설정
    	const materials = "진공 포장재 (PE, PA 복합필름)"	// "포장재질" 설정
    	const storageMethods = "신선도 유지를 위해 개봉 후에는 밀봉하여 보관하시고, 가급적 빠른 시일 내에 드십시오."	// "보관방법" 설정
    	const warnings = "본 제품은 반드시 가열하여 섭취하세요."	// "주의사항" 설정
    	
    	document.getElementById('manufactureDateKr').value = formatDate(manufactureDate)
    	document.getElementById('consumptionDeadlineKr').value = formatDate(consumptionDeadline)
    	document.getElementById('packagingMaterialKr').value = materials
    	document.getElementById('storageMethodKr').value = storageMethods
    	document.getElementById('etcKr').value = warnings
    });

    $("#autoval").on("click",function(e){
        e.preventDefault(); 

        // 1. "제조연월일" 설정 (2024-01-01 ~ 현재 날짜)
        const manuStartDate = new Date('2024-01-01');
        const manuEndDate = new Date(); // 현재 날짜
        const randomManuTime = manuStartDate.getTime() + Math.random() * (manuEndDate.getTime() - manuStartDate.getTime());
        const manufactureDate = new Date(randomManuTime);
        document.getElementById('manufactureDateKr').value = formatDate(manufactureDate);
        

        // 2. "소비기한" 설정 (제조연월일 + 1개월 ~ 제조연월일 + 1년 6개월)
        const deadlineStartDate = new Date(manufactureDate);
        deadlineStartDate.setMonth(deadlineStartDate.getMonth() + 1);
        const deadlineEndDate = new Date(manufactureDate);
        deadlineEndDate.setMonth(deadlineEndDate.getMonth() + 18);
        const randomDeadlineTime = deadlineStartDate.getTime() + Math.random() * (deadlineEndDate.getTime() - deadlineStartDate.getTime());
        const consumptionDeadline = new Date(randomDeadlineTime);
        document.getElementById('consumptionDeadlineKr').value = formatDate(consumptionDeadline);

        // 3-1. 랜덤 지정 (용기.포장.재질)
        const materials = [
            "폴리스티렌 (PS)", 
            "폴리프로필렌 (PP)", 
            "폴리에틸렌 테레프탈레이트 (PET)", 
            "폴리에틸렌 (PE)", 
            "폴리염화비닐 (PVC)", 
            "폴리아미드/폴리에틸렌 (PA/PE)"
        ];
        const randomIndex1 = Math.floor(Math.random() * materials.length);
        document.getElementById('packagingMaterialKr').value = materials[randomIndex1];

     	// 3-2. 랜덤 지정 (보관방법)
        const storageMethods = [
            "직사광선을 피해 서늘하고 건조한 곳에 보관하세요",
            "냉장 보관 (0~10°C)",
//            "냉동 보관 (-18°C 이하)",
            "실온 보관 (1~30°C), 개봉 후 냉장 보관하세요",
//            "어린이 손이 닿지 않는 곳에 보관하세요",
            "고온다습한 곳을 피하여 보관하세요"
        ];
        const randomIndex2 = Math.floor(Math.random() * storageMethods.length);
        document.getElementById('storageMethodKr').value = storageMethods[randomIndex2];
        
     	// 3-3. 랜덤 지정 (주의사항)
        const warnings = [
//        	"사용 전 반드시 설명서를 읽으십시오.",
//        	"눈에 들어갔을 경우 즉시 물로 충분히 씻어내십시오.",
        	"피부 이상 발생 시 섭취를 중단하고 의사와 상담하십시오.",
//        	"섭취하지 마십시오.",
//        	"화기에 가까이 두지 마십시오.",
        	"용도 외 사용을 금합니다."
        ];
        const randomIndex3 = Math.floor(Math.random() * warnings.length);
        document.getElementById('etcKr').value = warnings[randomIndex3];
	});
});
</script>
</html>