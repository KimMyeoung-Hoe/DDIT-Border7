<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<sec:authentication property="principal" var="princ"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수입신고서</title>
	<link rel="stylesheet" href="/css/main.css">
	<link rel="stylesheet" href="/css/decl.css">
</head>
<body>
	
	<div class="app-container">
		<main class="main-content-area">
		
			<div class="content-header">
				<div class="content-title">수입신고필증</div>
				<p class="desc">수입신고필증은 수입신고서에 전자직인을 날인하여 수입통관 신고가 완료되었음을 증명하는 문서입니다.</p>
			</div>
			<form action="/pdf/download2.do" id="pdfDownFrom" method="get">
				<input type="hidden" name="url" value="contract/decl/detail.do?declDNo=${contractVO.declDVO.declDNo }"/>
				<button type="submit" class="btn btn-primary btn-c btn-sm" onclick="fn_pdf">pdf 다운로드</button>
			</form>

		    <div id="pdfTarget" style="background: #ffffff !important; border-radius: 12px; padding: 30px; backdrop-filter: blur(5px); border: 1px solid rgba(255, 255, 255, 0.1); box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37); width: 100%; box-sizing: border-box; margin-bottom: 30px;">
		
		        <div style="text-align: center; margin-bottom: 20px; position: relative; padding: 10px 0;">
		            <div style="position: absolute; left: 20px; top: 50%; transform: translateY(-50%); display: flex; align-items: center; gap: 5px;">
		                <i style="display: inline-block; width: 30px; height: 30px; background-color: transparent;"></i>
		                <span style="font-size: 28px; font-weight: bold; color: #2a73d8;">Border7</span>
		            </div>
		            <h2 style="font-size: 26px; font-weight: bold; margin: 0; color: #333;">수입신고서</h2>
		        </div>
		
		        <table style="width: 100%; border-collapse: collapse; margin-bottom: 20px;">
		            <tr>
		                <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">신고번호</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.declDVO.declDNo }</td>
		                <th style="1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">신고일</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.declDVO.declDDate }</td>
		            </tr>
		            <tr>
		                <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">통관지세관</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.declDVO.customsAuthority } </td>
		                <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">수리일자</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.declDVO.acceptDate }</td>
		            </tr>
		            <tr>
		                <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">화주</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.consignorVO.consignorName }</td>
		                <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">신고인부호</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.ccaVO.ccaName }</td>
		            </tr>
		            <tr>
		                <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">통관고유부호</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.consignorVO.consignorCustomsCode }</td>
		                <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">Master B/L 번호</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.declDVO.blNo }</td>
		            </tr>
		            <tr>
		                <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">출발항</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.declDVO.portFrom }</td>
		                <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">도착항</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.declDVO.portTo }</td>
		            </tr>
		        </table>
		
		        <div style="margin-bottom: 0;">
		            <h3 style="background-color: #eef2f8; padding: 8px 10px; margin-top: 20px; margin-bottom: 0; font-size: 15px; font-weight: bold; border: 1px solid #ccc; border-bottom: none; color: #333;">품목번호 1 (한국 통계 품목번호: ${contractVO.productVO.hsCode })</h3>
		            <table style="width: 100%; border-collapse: collapse; margin-bottom: 20px;">
		                <tr>
		                    <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">품명</th>
		                    <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.productVO.productName }</th>
		                    <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">원산지</th>
		                    <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.productVO.productOrigin }</td>
		                </tr>
		                <tr>
		                	<th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">수량</th>
		                    <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.productVO.productQty } 개</td>
		                    <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">중량</th>
		                    <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.productVO.productWeight } KG</td>
		                </tr>
		                <tr>
		                	<th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">부피</th>
		                    <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.productVO.productVolume } CBM</td>
		                    <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">단가</th>
		                    <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.productVO.productPrice } 원</td>
		                </tr>
		            </table>
		        </div>
							
				<table style="width: 100%; border-collapse: collapse; margin-bottom: 20px;">
		            <tr>
		                <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">과세가격</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.declDVO.customsValue } 원</th>
		                <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 100px;">관세율</th>
		                <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333; width: 250px;">${contractVO.hsTariffRate } %</td>
		            </tr>
		        </table>
					
		        <div style="display: flex; border: 1px solid #ccc; margin-bottom: 20px;">
		            <div style="flex: 0 0 120px; padding: 8px 10px; background-color: #f7f7f7; font-size: 13px; color: #555; border-right: 1px solid #ccc; display: flex; align-items: center;">총송장금액</div>
		            <div style="flex: 0 0 250px; padding: 8px 10px; text-align: right; font-weight: bold; font-size: 14px; background-color: #fcfcfc; border-right: 1px solid #ccc; display: flex; align-items: center; justify-content: flex-end; color: #333;">${contractVO.declDVO.totalCost } 원</div>
		        </div>
		        
		        <div style="display: flex; border: 1px solid #ccc; margin-bottom: 20px;">
		            <div style="flex: 0 0 80px; padding: 8px 10px; background-color: #f7f7f7; font-size: 13px; color: #555; border-right: 1px solid #ccc; display: flex; align-items: center;">비고</div>
		            <div style="flex-grow: 1; padding: 8px 10px; background-color: #fff; display: flex; align-items: center;">${contractVO.declDVO.remarks }</div>
		        </div>
	            <div style="position: absolute; right: 50px; bottom: 140px;">
                    <img alt="Seal" src="data:image/png;base64,${base64EncodedImage}">
                </div>
                <div style="background: #f8fafc; padding: 14px; text-align: center; border-top: 1px solid #e2e8f0; font-size: 12px; color: #64748b;">
					<p style="color: black; margin: 2px 0;"><strong>대한민국 관세청</strong> | 전화: 125 (관세청 콜센터)</p>
					<p style="color: black; margin: 2px 0;">홈페이지: www.customs.go.kr</p>
					<p style="color: black; margin: 2px 0;">발행일시:
						<jsp:useBean id="now" class="java.util.Date" />
						<fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일 HH:mm" />
					</p>
			    </div>
		    </div>
	    </main>
    </div>
</body>


<script type="text/javascript">
</script>
</html>