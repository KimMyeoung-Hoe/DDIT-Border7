<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<sec:authentication property="principal" var="princ"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수출신고서</title>
    
	<%@ include file="../modules/header.jsp" %>
	<%@ include file="../modules/sidebar.jsp" %>
	<%@ include file="../modules/modal.jsp" %>
	<link rel="stylesheet" href="/css/main.css">
	<link rel="stylesheet" href="/css/decl.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.4/jquery-confirm.min.js"></script>
	
    <style>
        
    </style>
</head>
<body>
	
	<div class="app-container">
		<main class="main-content-area">
			
			<div class="breadcrumb-warp">
		      <div class="col-sm-12">
		         <ol class="breadcrumb">
		         	<li class="breadcrumb-item"><a href="/">Home</a></li>
		            <li class="breadcrumb-item"><a href="/servant/customsDeclaration.do">수출 통관 신고</a></li>
		            <li class="breadcrumb-item"><a href="/servant/adminWork.do">수출 신고 상세</a></li>
		            <li class="breadcrumb-item"><a href="/servant/adminWork.do">수출 필증 발급</a></li>
		         </ol>
		      </div>
		    </div>
		    
			<div class="content-header">
				<div class="content-title">수출신고필증 발급</div>
				<p class="desc">수출신고필증 발급 페이지 입니다.</p>

			</div>
			
			<form action="/servant/cdWrite.do" id="cdWriteForm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="status" value="${status }"/>
		    <div style="background: #ffffff !important; border-radius: 12px; padding: 30px; backdrop-filter: blur(5px); border: 1px solid rgba(255, 255, 255, 0.1); box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37); width: 100%; box-sizing: border-box; margin-bottom: 30px;">
		
		        <div style="text-align: center; margin-bottom: 20px; position: relative; padding: 10px 0;">
		            <div style="position: absolute; left: 20px; top: 50%; transform: translateY(-50%); display: flex; align-items: center; gap: 5px;">
		                <i style="display: inline-block; width: 30px; height: 30px; background-color: transparent;"></i>
		                <span style="font-size: 28px; font-weight: bold; color: #2a73d8;">Border7</span>
		            </div>
		            <h2 style="font-size: 26px; font-weight: bold; margin: 0; color: #333;">수출신고서</h2>
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
		        
	            <div style="position:relative; width: 200px; height: 200px; border: 1px solid #ccc; margin-left: auto; margin-right: 0; margin-top: 30px; display: flex; align-items: center; justify-content: center; font-size: 14px; color: #888; text-align: center;">
                    <input id="sealUpLoad" name="sealUpLoad" type="file" style="position: absolute;width: 100%; height: 100%; opacity: 0;"/>
                    <div id="sealtext" style="width: 100%; height: 100%; justify-content: center; display: flex; align-items: center;">직인</div>
                </div>
                <div class="seal-wrap">
		        	<img alt="" src="/img/AdministrativeSupportDepartment.png">
		        </div>
                <div class="btn-container" style="margin:30px 0 0 0;">
                	
			    	<input type="hidden" name="declDNo" value="${contractVO.declDVO.declDNo }"/>
			    	<input type="hidden" name="contractNo" value="${contractVO.contractNo }"/>
			    	<input type="hidden" name="declNo" value="${declNo }"/>
			    	<input type="hidden" name="targetUrl" value="contract/decl/detail.do?declDNo=${contractVO.declDVO.declDNo }"/>
			    	<input class="btn btn-primary btn-c" type="button" id="cdWriteBtn" value="완료" style="border: none; border-radius: 8px; font-size: 16px !important; font-weight: bold; transition: background-color 0.2s, transform 0.1s; width: 160px; height: 48px; background-color: #007bff; color: white;">
			    </div>
		    </div>
		    </form>
	    </main>
    </div>
</body>


<script type="text/javascript">

const cdWriteBtn = document.getElementById("cdWriteBtn");
const cdWriteForm = document.getElementById("cdWriteForm");
const sealWrap = document.querySelector(".seal-wrap");
cdWriteBtn.addEventListener('click', function() {
$.confirm({
	title: '신고서 작성',
	content: '신고서 작성 완료시 수정할 수 없습니다',
	buttons: {
			승인: {
				btnClass: 'btn-primary',
				action : function() {
					sealWrap.classList.add("stamp")
					setTimeout(() => {
						$("#cdWriteBtn").prop('disabled', true);
						cdWriteForm.submit();
					}, "2000");
				}
			},
			취소 : {
				btnClass: 'btn-danger',
				action : function() {
					alertify.error('승인을 취소 했습니다.');
				}
        	}
		}
});
	
	
});
</script>
</html>