<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관세사 한글표시사항 작성 페이지</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
			
			<%-- PDF 다운로드 버튼을 위한 폼 --%>
			<form action="/pdf/download2.do" id="pdfDownFrom" method="get">
				<input type="hidden" name="url" value="cca/koreanLabelDetail.do?contractNo=${krNotationVO.contractNo}"/>
				<button type="submit" class="btn btn-primary btn-c btn-sm" onclick="fn_pdf">pdf 다운로드</button>
			</form>

			<div id="pdfTarget" style="background: #ffffff !important; border: 2px solid #333; padding: 25px; width: 100%; max-width: 600px; box-sizing: border-box; font-family: 'Gulim', sans-serif; color: #000;">
				
				<h2 style="text-align: center; font-size: 20px; font-weight: bold; margin: 0 0 20px 0; color: #000;">식품위생법에 의한 한글표시사항</h2>
				
				<div style="position: relative;">
					<p style="font-size: 14px; margin: 5px 0; line-height: 1.6; color: #000;"><strong>제품명 :</strong> ${krNotationVO.productNameKr}</p>
					
					<p style="font-size: 14px; margin: 5px 0; line-height: 1.6; color: #000;"><strong>내용량 :</strong> ${krNotationVO.contentKr}</p>
					<p style="font-size: 14px; margin: 5px 0; line-height: 1.6; color: #000;"><strong>원산지 :</strong> ${krNotationVO.originKr}</p>
					
					<p style="font-size: 14px; margin: 5px 0; line-height: 1.6; color: #000;"><strong>제조사 :</strong> 제조사명(예: PT. Calimantan)</p> 
					<p style="font-size: 14px; margin: 5px 0; line-height: 1.6; color: #000;"><strong>수입업소명 및 주소 :</strong> ${krNotationVO.consignorName} / ${krNotationVO.consignorAddr} ${krNotationVO.consignorDetAddr}</p>
					<p style="font-size: 14px; margin: 5px 0; line-height: 1.6; color: #000;"><strong>연락처 :</strong> ${krNotationVO.consignorTel}</p>
					
					<p style="font-size: 14px; margin: 5px 0; line-height: 1.6; color: #000;"><strong>소비기한 :</strong> <fmt:formatDate value='${krNotationVO.consumptionDeadlineKr}' pattern='yyyy. MM. dd 까지'/></p>

					<p style="font-size: 14px; margin: 5px 0; line-height: 1.6; color: #000;"><strong>원재료명 :</strong> ${krNotationVO.ingredientsKr}</p>
					

					<p style="font-size: 14px; margin: 15px 0 5px 0; line-height: 1.6; color: #000;"><strong>반품 및 교환 :</strong> 구입처 및 수입업소</p>
					<p style="font-size: 14px; margin: 5px 0; line-height: 1.6; color: #000;"><strong>보관 및 주의사항 :</strong> ${krNotationVO.storageMethodKr} ${krNotationVO.etcKr}</p>
					<p style="font-size: 14px; margin: 5px 0; line-height: 1.6; color: #000;"><strong>포장재질 :</strong> ${krNotationVO.packagingMaterialKr}</p>
					
					<p style="font-size: 14px; margin: 20px 0 5px 0; text-align: center; font-weight: bold; color: #000;">부정·불량식품 신고는 국번없이 1399</p>

				</div>

			</div>
		</main>
	</div>

</body>
<script type="text/javascript">
<%-- 
	const contextPath = '<%= request.getContextPath() %>';
	
	$(function(){
		
	    <c:if test="${not empty message}">
	    alertify.alert("${message}");
		</c:if>
		
	    $("#kLableBtn").on("click", function() {
	    	location.href = contextPath + '/cca/ccaDetailContract/' + '${contractNo}';
	    });
	
	}); 
--%>
</script>
</html>
