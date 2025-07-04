<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포장명세서 작성</title>
<style type="text/css">

tr{height:100px;}
td{position: relative;}
textarea{resize: none; width: 100%; height: calc(100% - 20px);max-width: 100%;}
.flex-col{display: flex;flex-direction: column;}
</style>
</head>
<body>
<form action="/pl/insert.do" method="post" id="plform">

	<c:if test="${status eq 'u' }">
		<input type="hidden" name="plNo" value="${pl.plNo }" />
	</c:if>
	<table style="width:100%; border-collapse: collapse; font-family: Arial, sans-serif;" border="1">
    <thead>
        <tr>
            <th colspan="8" style="text-align: center; font-size: 24px; padding: 10px; background-color: #f2f2f2; border-bottom: 2px solid #000;">COMMERCIAL INVOICE</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="4" style="width: 50%; padding: 8px; vertical-align: top;">
            	<span style="font-weight: bold;">Seller/Seller</span><br>
            	<textarea name="shipper" id="shipper">Gil Dong Trading Co., Ltd.</textarea>	
            </td>
            <td colspan="4" style="width: 50%; padding: 8px; vertical-align: top;">
            	<span style="font-weight: bold;">Invoice No. and date</span><br>
            	<textarea name="invoice" id="invoice">8905 HC 3108 Aug. 15, 2012</textarea>
            </td>
        </tr>
        
        <tr>
            <td colspan="4" rowspan="2" style="width: 50%; padding: 8px; vertical-align: top;">
            	<div class="flex-col">
            		<div>
		            	<span style="font-weight: bold;">Consignee(or For account & risk of Messrs.)</span><br>
		            	<textarea name="shipper" id="shipper">Gil Dong Trading Co., Ltd.</textarea>
	            	</div>
	            	<div>
		            	<span style="font-weight: bold;">Notify Party</span><br>
		            	<textarea name="shipper" id="shipper">Gil Dong Trading Co., Ltd.</textarea>
	            	</div>

		    	</div>
            </td>
            <td colspan="4" style="width: 50%; padding: 8px; vertical-align: top;">
            	<span style="font-weight: bold;">bbbbbbbb</span><br>
            	<textarea name="invoice" id="invoice">8905 HC 3108 Aug. 15, 2012</textarea>
            </td>
        </tr>
        
		
		<tr>
            <td colspan="4" rowspan="4" style="width: 50%; padding: 8px; vertical-align: top;">
            	<span style="font-weight: bold;">Other references</span><br>
            	<textarea name="invoice" id="invoice">8905 HC 3108 Aug. 15, 2012</textarea>
            </td>
        </tr>
        
        <tr>
            <td colspan="4" style="width: 50%; padding: 8px; vertical-align: top;">
            	<span style="font-weight: bold;">Departure date</span><br>
            	<textarea name="shipper" id="shipper">Gil Dong Trading Co., Ltd.</textarea>	
            </td>
        </tr>
        <tr>
            <td colspan="4" style="width: 50%; padding: 8px; vertical-align: top;">
            	<span style="font-weight: bold;">Vessel/flight</span><br>
            	<textarea name="shipper" id="shipper"></textarea>	
            	<span style="font-weight: bold;">From</span><br>
            	<textarea name="shipper" id="shipper"></textarea>	
            </td>
        </tr>
        <tr>
            <td colspan="4" style="width: 50%; padding: 8px; vertical-align: top;">
            	<span style="font-weight: bold;">To</span><br>
            	<textarea name="shipper" id="shipper">Gil Dong Trading Co., Ltd.</textarea>	
            </td>
        </tr>

        <tr>
            <td colspan="2" style="width: 25%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">Shipping Marks</td>
            <td style="width: 15%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">No.&kind of packages</td>
            <td style="width: 15%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">Goods description</td>
            <td style="width: 15%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">Quantity</td>
            <td style="width: 15%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">Unit price</td>
            <td style="width: 15%; padding: 8px; font-weight: bold; text-align: center; background-color: #f2f2f2; border-top: 1px solid #000; border-bottom: 1px solid #000;">Amount</td>
        </tr>

        <tr>
            <td style="padding: 8px; vertical-align: top;">
	                <textarea name="shippingMarks" id="shippingMarks">MON/T
4200DX420D
Bulawayo
LOT NO
C/NO.1-53
MADEIN KOREA</textarea>
	            </td>
	            <td style="padding: 8px; vertical-align: top;">
	                <textarea name="kindOfPackages" id="kindOfPackages">Material, Asper Monarch Products
IndentNo T.858</textarea>
	            </td>
	            <td style="padding: 8px; vertical-align: top;">
            	<textarea name="goodsDescription" id="goodsDescription">Nylon Oxford</textarea>
            </td>
            <td style="padding: 8px; vertical-align: top;">
				<textarea name="quantity" id="quantity">60,000M</textarea>
			</td>
            <td style="padding: 8px; vertical-align: top;">
				<textarea name="unitprice" id="unitprice"></textarea>
			</td>
            <td style="padding: 8px; vertical-align: top;">
				<textarea name="amount" id="amount"></textarea>
			</td>
        </tr>

        <tr>
            <td colspan="7" style="text-align: right; padding: 30px 8px 8px 8px; border-top: 1px solid #000;">
                <span style="font-weight: bold;">Signed by</span><br><br>
                <textarea name="signedBy" id="signedBy"></textarea>
                </td>
        </tr>
    </tbody>
</table>
	<c:set value="등록" var="btnText"/>
	<c:if test="${status eq 'u' }">
		<c:set value="수정" var="btnText"/>
	</c:if>
	<button type="button" id="submitbtn">CI ${btnText }</button>
</form>
<div>
	<form action="/excel/download" method="post" enctype="multipart/form-data">
	
		<button type="submit">읽어오기</button>
	</form>
</div>

	ajax : <input id="uploadDoc" name="file" type="file">
</body>
<script src="<%=request.getContextPath() %>/lib/jQuery/jquery-3.7.1.min.js" ></script>
<script type="text/javascript">
	const ciform = document.querySelector("#ciform");
	const submitbtn = document.querySelector("#submitbtn");
	submitbtn.addEventListener("click", (event) => {
		console.log(submitbtn.innerHTML)
		if(submitbtn.innerHTML === "CI 수정"){
			ciform.action = "/ci/update.do"
		}
		
		ciform.submit();
		//ciform
	});
	
	const uploadDoc = document.querySelector("#uploadDoc");
	
	uploadDoc.addEventListener("change", (event) => {
		// 1. input type="file" 엘리먼트 가져오기
	    var fileInput = $('#uploadDoc')[0]; // [0]을 사용하여 DOM 엘리먼트 자체를 가져옵니다.

	    // 2. 선택된 파일이 있는지 확인
	    if (!fileInput.files || fileInput.files.length === 0) {
	        console.log("파일을 선택해주세요.");
	        return; // 파일이 없으면 함수 종료
	    }

	    // 3. FormData 객체 생성
	    var formData = new FormData();

	    // 4. FormData에 파일 추가
	    // 'file'은 서버 컨트롤러의 @RequestParam("file")과 이름이 일치해야 합니다.
	    formData.append("file", fileInput.files[0]);
	    
	    $.ajax({
	        url : "/restexcel/excelReadList",
	        type : "post",
	        data : formData, // FormData 객체를 data 속성에 할당
	        processData : false, // FormData를 사용할 때는 false로 설정
	        contentType : false, // FormData를 사용할 때는 false로 설정
	        success : function(result){
	            console.log(result);
	            console.log(result[0][0]);
				document.querySelector("#shipper").value = result[0][0];
				document.querySelector("#invoice").value = result[0][1];
				document.querySelector("#consignee").value = result[0][2];
				document.querySelector("#lcNoAndDate").value = result[0][3];
				document.querySelector("#departureDate").value = result[0][4];
				document.querySelector("#buyer").value = result[0][5];
				document.querySelector("#vessel").value = result[0][6];
				document.querySelector("#otherReferences").value = result[0][7];
				document.querySelector("#portFrom").value = result[0][8];
				document.querySelector("#tdap").value = result[0][9];
				document.querySelector("#portTo").value = result[0][10];
				document.querySelector("#shippingMarks").value = result[0][11];
				document.querySelector("#kindOfPackages").value = result[0][12];
				document.querySelector("#goodsDescription").value = result[0][13];
				document.querySelector("#quantity").value = result[0][14];
				document.querySelector("#unitprice").value = result[0][15];
				document.querySelector("#amount").value = result[0][16];
				document.querySelector("#signedBy").value = result[0][17];
	        },
	        error : function(error, status, thrown){
	            console.log("error", error)
	            console.log("status", status)
	            console.log("thrown", thrown)
	        }
	    });
	});
</script>
</html>