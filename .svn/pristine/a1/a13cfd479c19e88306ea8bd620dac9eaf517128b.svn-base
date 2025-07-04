<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상업송장 상세</title>
<link rel="stylesheet" href="/css/main.css">
</head>
<body>

	<div class="app-container">
		<main class="main-content-area">
			<div class="dlBtn-wrap">
				<form action="/pdf/download/ci/${ci.ciNo}" id="pdfDownFrom" method="get">
					<button type="submit" class="btn btn-primary btn-c btn-sm" onclick="fn_pdf">pdf 다운로드</button>
				</form>
			</div>
			
			<div class="section doc-section">
				<table id="pdfTarget" style="width:100%; border-collapse: collapse; font-family: Arial, sans-serif;" border="1">
				    <thead>
				        <tr>
				            <th colspan="7" style="text-align: center; font-size: 24px; padding: 10px; background-color: #f2f2f2; border-bottom: 2px solid #000;">COMMERCIAL INVOICE</th>
				        </tr>
				    </thead>
				    <tbody>
				        <tr style="height:100px;">
				            <td style="width: 25%; padding: 8px; vertical-align: top;"><span style="font-weight: bold;">Seller/Seller</span></td>
				            <td style="width: 25%; padding: 8px; vertical-align: top;">${ci.shipper }</td>
				            <td style="width: 15%; padding: 8px; vertical-align: top;"><span style="font-weight: bold;">Invoice No. and date</span></td>
				            <td colspan="4" style="width: 35%; padding: 8px; vertical-align: top;">${ci.invoice }</td>
				        </tr>
				
				        <tr style="height:100px;">
				            <td style="padding: 8px; vertical-align: top;"><span style="font-weight: bold;">Consignee</span></td>
				            <td style="padding: 8px; vertical-align: top;">${ci.consignee }</td>
				            <td style="padding: 8px; vertical-align: top;"><span style="font-weight: bold;">L/C No. and date</span></td>
				            <td colspan="4" style="padding: 8px; vertical-align: top;">${ci.lcNoAndDate }</td>
				        </tr>
				
				        <tr style="height:100px;">
				            <td style="padding: 8px; vertical-align: top;"><span style="font-weight: bold;">Departure date</span></td>
				            <td style="padding: 8px; vertical-align: top;">${ci.departureDate }</td>
				            <td style="padding: 8px; vertical-align: top;"><span style="font-weight: bold;">Buyer(if other than consignee)</span></td>
				            <td colspan="4" style="padding: 8px; vertical-align: top;">
								${ci.buyer }
							</td>
				        </tr>
				
				        <tr style="height:100px;">
				            <td style="padding: 8px; vertical-align: top;"><span style="font-weight: bold;">Vessel/flight</span></td>
				            <td style="padding: 8px; vertical-align: top;">${ci.vessel }</td>
				            <td style="padding: 8px; vertical-align: top;"><span style="font-weight: bold;">Other references</span></td>
				            <td colspan="4" style="padding: 8px; vertical-align: top;">${ci.otherReferences }</td>
				        </tr>
				
				        <tr style="height:100px;">
				            <td style="padding: 8px; vertical-align: top;"><span style="font-weight: bold;">From</span></td>
				            <td style="padding: 8px; vertical-align: top;">${ci.portFrom }</td>
				            <td style="padding: 8px; vertical-align: top;"><span style="font-weight: bold;">Terms of delivery and payment</span></td>
				            <td colspan="4" style="padding: 8px; vertical-align: top;">${ci.tdap }</td>
				        </tr>
				        <tr style="height:100px;">
				            <td style="padding: 8px; vertical-align: top;"><span style="font-weight: bold;">To</span></td>
				            <td colspan="6" style="padding: 8px; vertical-align: top;">${ci.portTo }</td>
				        </tr>
				
				        <tr>
				            <td style="width: 15%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">Shipping Marks</td>
				            <td style="width: 20%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">No.&kind of packages</td>
				            <td style="width: 25%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">Goods description</td>
				            <td style="width: 10%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">Quantity</td>
				            <td style="width: 10%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">Unit price</td>
				            <td style="width: 20%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">Amount</td>
				        </tr>
				
				        <tr style="height:100px;">
				            <td style="padding: 8px; vertical-align: top;">${ci.shippingMarks }</td>
				            <td style="padding: 8px; vertical-align: top;">${ci.kindOfPackages }</td>
				            <td style="padding: 8px; vertical-align: top;">${ci.goodsDescription }</td>
				            <td style="padding: 8px; vertical-align: top;">${ci.quantity }</td>
				            <td style="padding: 8px; vertical-align: top;">${ci.unitprice }</td>
				            <td style="padding: 8px; vertical-align: top;">${ci.amount }</td>
				        </tr>
				
				        <tr>
				            <td colspan="7" style="text-align: right; padding: 30px 8px 8px 8px; border-top: 1px solid #000;">
				                <span style="font-weight: bold;">Signed by</span><br><br>
				                ${ci.signedBy }
				                </td>
				        </tr>
				    </tbody>
				</table>
				
				<c:set var="edit" value="off" />
				<c:if test="${edit == 'on' }">
					<form action="/ci/update.do" method="get">
						<div class="btn-container">
							<input type="hidden" name="ciNo" value="${ci.ciNo }" />
							<input type="submit" class="btn btn-primary btn-c" value="수정하기"/>
						</div>
					</form>
				</c:if>
			</div>
		</main>
	</div>
<script type="text/javascript">
function fn_pdf(){
	//pdfDownFrom
	
}
</script>
</body>
</html>