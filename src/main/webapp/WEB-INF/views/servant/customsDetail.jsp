<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수출입 통관 상세</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<%@ include file="../modules/modal.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/main.css">
<style type="text/css">
.section  {
    margin-bottom: 15px;
}

.section.off  {
	background: #7A7A7A;
}
.section.now  {
	 border: 1px solid #007bff;
}
.card-header {
    margin-bottom: 15px;
}

.card-main {
    display: flex;
    justify-content: space-between;
}

.card-left, .card-right {
    width: 48%; 				/* 각각 절반의 크기, 약간의 여유 공간 추가 */
}
.h4-margin{
    padding-bottom: 36.8px; 	/* h4의 폰트크기 : 28.8px + bottom magin : 8px*/
}
.label-magin{
    padding-bottom: 32px; 		/* label의 폰트크기 : 24px + bottom magin : 8px*/
}
.btn-magin{
    padding-bottom: 48px; 		/* 버튼컨테이너의 폰트크기 : 48px*/
}
.elem-show{
	display: inline;
}
.elem-hidden{
	display: none;
}
.progress-section{
	margin: 0px;
	padding: 0px;
}
.progress-bar-container{
	margin: 0px;
	padding: 0px;
}
.dis-flex-jce{
    display: flex;
    justify-content: flex-end;
    flex-wrap: wrap;
    gap:10px;
}
.scroll-margin{
	padding-bottom: 132.46px;
}
.fixed {
  position: fixed;
  top: 60px;
  left: 265px;
  right: 0;
  z-index: 1000;
  width: calc(100% - 370px);
  height: 117.46px;
}
</style>
</head>
<body>
<div class="app-container">
	<main class="main-content-area">
	   <div class="content-header-backgraund">
		   <div class="content-header">
			   <!-- 브레드크럼 엘리먼트 -->
			   <div class="breadcrumb-warp">
			      <div class="col-sm-12">
			         <ol class="breadcrumb">
			         	<li class="breadcrumb-item"><a href="/">Home</a></li>
			            <li class="breadcrumb-item"><a href="/servant/customsDeclaration.do">수출입 통관 신고</a></li>
			            <li class="breadcrumb-item"><a href="/servant/adminWork.do">수출입 신고 상세</a></li>
			         </ol>
			      </div>
			    </div>
			    <!-- 브레드크럼 엘리먼트 끝 -->
			    <div class="content-title">수출입 신고 상세</div>
			    <p class="desc">수출입 통관 업무의 상세정보를 표시하고 승인 / 반려하는 페이지 입니다.</p>
			</div>
		    <div class="section progress-border">
		    	<div class="progress-section">
					<div class="progress-bar-container">
						<input type="hidden" id="status" value="${customsDetailInfo.LAST_STATUS_CODE}" />
						<input type="hidden" id="declDNo" value="${customsDetailInfo.EXA_DECL_D_NO}" />
						<input type="hidden" id="declNo" value="${customsDetailInfo.DECL_NO}" />
						<input type="hidden" id="contract" value="${customsDetailInfo.EXA_CONTRACT_NO}" />
						<input type="hidden" id="prod" value="${customsDetailInfo.EXA_PRODUCT_NO}" />
						<div class="progress-bar">
							<div class="progress-step">
								<button class="step-circle active" id="stepOne" onclick="scrollToSection('EXAMINE')">
									1
								</button>
							    <span class="step-label">신청검토</span>
							    <div class="progress-details" id="details-step-1" style="display: none;">
									<div style="color: black; font-size: 12px; margin-left: 60px; width: 300px" class="divArea"></div>
								</div>
							</div>
							<div class="progress-step">
								<button class="step-circle inactive" id="stepTwo" onclick="scrollToSection('INSPECTION')" >
									2
								</button>
							    <span class="step-label">고객검사</span>
							    <div class="progress-details" id="details-step-1" style="display: none;">
									<div style="color: black; font-size: 12px; margin-left: 60px; width: 300px" class="divArea"></div>
								</div>
							</div>
							<div class="progress-step">
								<button class="step-circle inactive" id="stepTri" onclick="scrollToSection('BW')">
									3
								</button>
							    <span class="step-label">물품입고</span>
							    <div class="progress-details" id="details-step-1" style="display: none;">
									<div style="color: black; font-size: 12px; margin-left: 60px; width: 300px" class="divArea"></div>
								</div>
							</div>
							<div class="progress-step">
								<button class="step-circle inactive" id="stepFur" onclick="scrollToSection('QRNT')">
									4
								</button>
							    <span class="step-label">물품 검사 및 검역</span>
							    <div class="progress-details" id="details-step-1" style="display: none;">
									<div style="color: black; font-size: 12px; margin-left: 60px; width: 300px" class="divArea"></div>
								</div>
							</div>
							<c:choose>
								<c:when test="${customsDetailInfo.contractType eq '수출'}">
									<div class="progress-step">
										<button class="step-circle inactive" id="stepFivEx" onclick="scrollToSection('CD')">
											5
										</button>
									    <span class="step-label">필증 발급</span>
									    <div class="progress-details" id="details-step-1" style="display: none;">
											<div style="color: black; font-size: 12px; margin-left: 60px; width: 300px" class="divArea"></div>
										</div>
									</div>
									<div class="progress-step">
										<button class="step-circle inactive" id="stepSixEx" onclick="scrollToSection('DOC')">
											6
										</button>
									    <span class="step-label">연관 서류</span>
									    <div class="progress-details" id="details-step-1" style="display: none;">
											<div style="color: black; font-size: 12px; margin-left: 60px; width: 300px" class="divArea"></div>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="progress-step">
										<button class="step-circle inactive" id="stepFiv" onclick="scrollToSection('TAXNOTICE')">
											5
										</button>
									    <span class="step-label">세금 고지</span>
									    <div class="progress-details" id="details-step-1" style="display: none;">
											<div style="color: black; font-size: 12px; margin-left: 60px; width: 300px" class="divArea"></div>
										</div>
									</div>
									<div class="progress-step">
										<button class="step-circle inactive" id="stepSix" onclick="scrollToSection('CD')">
											6
										</button>
									    <span class="step-label">필증 발급</span>
									    <div class="progress-details" id="details-step-1" style="display: none;">
											<div style="color: black; font-size: 12px; margin-left: 60px; width: 300px" class="divArea"></div>
										</div>
									</div>
									<div class="progress-step">
										<button class="step-circle inactive" id="stepSev" onclick="scrollToSection('DOC')">
											7
										</button>
									    <span class="step-label">연관 서류</span>
									    <div class="progress-details" id="details-step-1" style="display: none;">
											<div style="color: black; font-size: 12px; margin-left: 60px; width: 300px" class="divArea"></div>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
		    </div>
		</div>
		<div id="scroll-margin">
		</div>
		<div class="section" id="EXAMINE">
			<div class="card-header">
				<h2>신고검토</h2>  <p class="desc">기본 신고정보를 확인하고 신고를 수리/반려 합니다.</p>
			</div>
			<div class="card-main">
			    <div class="card-left">
			        <h4>물품 정보</h4>
			        <label>품명 : </label> 
			        <span id="EXA_PRODUCT_NAME">
			       		${customsDetailInfo.EXA_PRODUCT_NAME}
			        </span><br />
			        
			        <label>중량 : </label> 
			        <span id="EXA_PRODUCT_WEIGHT">
			        	${customsDetailInfo.EXA_PRODUCT_WEIGHT} kg
			        </span><br />
			        
			        <label>수량 : </label> 
			        <span id="EXA_PRODUCT_QTY">
			       		${customsDetailInfo.EXA_PRODUCT_QTY} 개
			        </span><br />
			        
			        <label>단가(총) : </label> 
			        <span id="EXA_CUSTOMS_VALUE">
			        	<fmt:formatNumber value="${customsDetailInfo.EXA_CUSTOMS_VALUE}" type="number" groupingUsed="true" /> 원
			        </span><br />
			        
			        <label>총금액 : </label> 
			        <span id="EXA_TOTAL_COST">
			        	<input type="hidden" id="totalCost" value="${customsDetailInfo.EXA_TOTAL_COST}" />
			        	<fmt:formatNumber value="${customsDetailInfo.EXA_TOTAL_COST}" type="number" groupingUsed="true" /> 원
			        </span><br />
			        
			        <label>출발항 : </label> 
			        <span id="EXA_PORT_FROM">
			        	${customsDetailInfo.EXA_PORT_FROM}
			        </span><br />
			        
			        <label>도착항 : </label>
			        <span id="EXA_PORT_TO">
			        	${customsDetailInfo.EXA_PORT_TO}
			        </span><br />
			        
			    </div>
			    <div class="card-right">
			        <h4>통관 정보</h4>
			        <label>통관 신고업체명 : </label> <span id="EXA_CONSIGNOR_NAME">${customsDetailInfo.EXA_CONSIGNOR_NAME}</span><br />
			        <label>통관고유부호 : </label> <span id="EXA_CONSIGNOR_CUSTOMS_CODE">${customsDetailInfo.EXA_CONSIGNOR_CUSTOMS_CODE}</span><br />
			        <label>통관신고서 번호 : </label> <span id="EXA_DECL_D_NO">${customsDetailInfo.EXA_DECL_D_NO}</span><br />
			        <label>신고 대리업체 : </label> <span id="EXA_CCA_NAME">${customsDetailInfo.EXA_CCA_NAME}</span><br />
			        <label>대리업체 관세사 번호 : </label> <span id="EXA_CCA_REGISTRATION_NUMBER">${customsDetailInfo.EXA_CCA_REGISTRATION_NUMBER}</span><br />
			        <label>대리계약 번호 : </label> <span id="EXA_DECL_D_NO">${customsDetailInfo.EXA_CONTRACT_NO}</span><br />
			        <div class="btn-container btncr">
			        	<button class="btn btn-success btn-r" id="declDBtn">신고서 확인</button>
		        	</div>
		        	<hr />
		        	<div class="btn-container btncr dis-flex-jce" id="exaBtn">
		        		<button class="btn btn-primary btn-r " style="display: none;"id="exaAppro"  >통관신고 수리</button>
		        		<button class="btn btn-danger btn-r " style="display: none;"id="exaReject" >통관신고 반려</button>
		        		<button class="btn btn-secondary btn-r " style="display: none;"id="exaApproEnd" >통관신고 수리완료</button>
		        		<button class="btn btn-warning btn-r " style="display: none;"id="exaRejectEnd" >통관신고 반려완료</button>
	        		</div>
			    </div>
			</div>
		</div>
		
		<div class="section" id="INSPECTION">
		    <div class="card-header">
		        <h2>고객 검사</h2> <p class="desc">통관신고인의 범법여부를 검사합니다.</p>
		    </div>
		    <div class="card-main">
		        <div class="card-left">
		        
		            <h4>검사 정보</h4>
		            <label>검사 대상 : </label>
		            <span id="INP_CONSIGNOR_NAME">
		            	${customsDetailInfo.INP_CONSIGNOR_NAME}
		            </span><br />
		            
		            <label>사업자 등록 번호 : </label> 
		            <span id="INP_BUSINESS_NUMBER">
			            <c:set var="number" value="${customsDetailInfo.INP_BUSINESS_NUMBER}"/>
			            <c:set var="formattedNumber" value="${fn:substring(number, 0, 3)}-${fn:substring(number, 3, 5)}-${fn:substring(number, 5, 10)}"/>
		            	${formattedNumber}
		            </span><br />
		            
		            <label>검사 접수일시 : </label> 
		            <span id="INP_INSPECTION_RECEPT_DATE">
		           	 	<c:set var="inpReceptDate" value="${customsDetailInfo.INP_INSPECTION_RECEPT_DATE}" />
		            	<fmt:formatDate value="${inpReceptDate}" pattern="yyyy-MM-dd HH:mm" />
		            </span>
		            <br />
		            
		            <label>검사 완료일시 : </label> 
		            <span id="INP_INSPECTION_REAL_DATE">
		            	<c:set var="inpRealDate" value="${customsDetailInfo.INP_INSPECTION_REAL_DATE}" />
		            	<fmt:formatDate value="${inpRealDate}" pattern="yyyy-MM-dd HH:mm" />
		            </span><br />
		            
		            <label>검사 담당자 : </label> <span id="INP_INSPECTOR_NAME">${customsDetailInfo.INP_INSPECTOR_NAME}</span><br />
		            <label>담당자 연락처 : </label> <span id="INP_INSPECTOR_TEL">${customsDetailInfo.INP_INSPECTOR_TEL}</span><br />
		        </div>
		        <div class="card-right">
		            <h4>검사 결과</h4>
		            
		            <label>사업장 확인 : </label>
		            <span id="INP_INSPECTION_CLOSURE_YN">
		            	<c:if test="${customsDetailInfo.INP_INSPECTION_CLOSURE_YN eq 0}">
		            		영업중
		            	</c:if>
		            	<c:if test="${customsDetailInfo.INP_INSPECTION_CLOSURE_YN eq 1}">
		            		미운영
		            	</c:if>
		            </span><br />
		            
		            <label>세급 채납확인 : </label>
		            <span id="INP_INSPECTION_CRIME">
		            	<c:if test="${customsDetailInfo.INP_INSPECTION_CRIME eq 0}">
		            		없음
		            	</c:if>
		            	<c:if test="${customsDetailInfo.INP_INSPECTION_CRIME eq 1}">
		            		있음
		            	</c:if>
		            </span><br />
		            
		            <label>범죄 이력확인 : </label>
		            <span id="INP_INSPECTION_DOT">
		            	<c:if test="${customsDetailInfo.INP_INSPECTION_DOT eq 0}">
		            		없음
		            	</c:if>
		            	<c:if test="${customsDetailInfo.INP_INSPECTION_DOT eq 1}">
		            		있음
		            	</c:if>
		            </span><br />
		            
		            <label>합격 여부 : </label>
		            <span id="INP_INSPECTION_YN">
		            	<c:if test="${customsDetailInfo.INP_INSPECTION_YN eq 0}">
		            		불합격
		            	</c:if>
		            	<c:if test="${customsDetailInfo.INP_INSPECTION_YN eq 1}">
		            		합격
		            	</c:if>
		            </span><br />
		            <div class="btn-container">
		            	<button class="btn btn-primary btn-r" style="display: none;" id="inpAppl" >검사 신청</button>
		            	<button class="btn btn-secondary btn-r" style="display: none;" id="inpApplEnd" >고객 검사완료</button>
	            	</div>
		        </div>
		    </div>
		</div>
		
		<div class="section" id="BW">
		    <div class="card-header">
		        <h2>물품수령</h2> 
		        <p class="desc">통관물품의 보세창고 입고 여부를 확인 합니다.</p>
		    </div>
		    <div class="card-main">
		        <div class="card-left">
		            <h4>물품 정보</h4>
		            <label>품명 : </label> <span id="BWH_PRODUCT_NAME">${customsDetailInfo.BWH_PRODUCT_NAME}</span><br />
		            <label>중량 : </label> 
		            <span id="BWH_PRODUCT_WEIGHT">
		            	<c:if test="${customsDetailInfo.BWH_PRODUCT_WEIGHT ne null}">
		            		${customsDetailInfo.BWH_PRODUCT_WEIGHT} Kg
		            	</c:if>
		            </span><br />
		            <label>수량 : </label> 
					<span id="BWH_PRODUCT_QTY">
		            	<c:if test="${customsDetailInfo.BWH_PRODUCT_QTY ne null}">
		            		${customsDetailInfo.BWH_PRODUCT_QTY} 개
		            	</c:if>
		            </span><br />
		        </div>
		        <div class="card-right">
		            <h4>보세창고 정보</h4>
		            
		            <label>입고 여부 : </label> 
	            	<span id="BWH_ARRIVAL_YN">
	            		<c:if test="${customsDetailInfo.BWH_ARRIVAL_DATE ne null}">
	            			입고 완료
	            		</c:if>
	            	</span><br />
	            	
		            <label>보세창고 번호 : </label> 
		            <span id="BWH_BWH_CD">
		            	${customsDetailInfo.BWH_BWH_CD}
		            	<c:if test="${customsDetailInfo.BWH_ARRIVAL_DATE ne null && customsDetailInfo.BWH_BWH_CD eq null}">
	            			01612033
	            		</c:if>
		            </span><br />
		            
		            <label>수령인 : </label>
		            <span id="BWH_USER_NAME">
		            	${customsDetailInfo.BWH_USER_NAME}
		            	<c:if test="${customsDetailInfo.BWH_ARRIVAL_DATE ne null && customsDetailInfo.BWH_USER_NAME eq null}">
	            			신도현
	            		</c:if>
		            </span><br />
		            
		            <label>입고일 : </label>
		            <span id="BWH_ARRIVAL_DATE">
		            	<c:set var="bwhArrDate" value="${customsDetailInfo.BWH_ARRIVAL_DATE}" />
		            	<fmt:formatDate value="${bwhArrDate}" pattern="yyyy-MM-dd" />
		            </span><br />
		            
		            <div class="btn-container">
		            	<button class="btn btn-primary btn-r" id="bwhApplIst" style="display: none;">입고</button>
		                <button class="btn btn-primary btn-r" id="bwhAppl" style="display: none;">조회</button>
		                <button class="btn btn-secondary btn-r" id="bwhApplEnd" style="display: none;">수령 완료</button>
		            </div>
		        </div>
		    </div>
		</div>
		
		<div class="section" id="QRNT">
		    <div class="card-header">
		        <h2>물품 검사 및 검역</h2> 
		        <p class="desc">통관신고 물품의 검사 및 검역을 진행 합니다.</p>
		    </div>
		    <div class="card-main">
		        <div class="card-left">
		            <h4>물품 정보</h4>
		            
		            <label>품명 : </label>
		            <span id="QRN_PRODUCT_NAME">
		            	${customsDetailInfo.QRN_PRODUCT_NAME}
	            	</span><br />
	            	
		            <label>중량 : </label> 
		            <span id="QRN_PRODUCT_WEIGHT">
		            	<c:if test="${customsDetailInfo.QRN_PRODUCT_WEIGHT ne null}">
		            	${customsDetailInfo.QRN_PRODUCT_WEIGHT} kg
		            	</c:if>
		            </span><br />
		            
		            <label>수량 : </label> 
		            <span id="QRN_PRODUCT_QTY">
		            	<c:if test="${customsDetailInfo.QRN_PRODUCT_QTY ne null}">
		            	${customsDetailInfo.QRN_PRODUCT_QTY} 개
		            	</c:if>
		            </span><br />
		            
		            <label>보세구역 : </label>
		            <span id="QRN_BWH_CD">
		            	${customsDetailInfo.QRN_BWH_CD}
	            	</span><br />
	            	
		            <label>검사 담당자 : </label> 
		            <span id="QRN_SERVANT_NAME">
		            	${customsDetailInfo.QRN_SERVANT_NAME}
		            </span><br />
		            
		            <label>부서 연락처 : </label> 
		            <span id="QRN_DEPT_TEL">
		            	${customsDetailInfo.QRN_DEPT_TEL}
		            </span><br />
		
		            <div class="btn-container-bt btncr">
		                <div class="btn-container btncr">
		                    <button class="btn btn-primary btn-r" id="qrnAppl" style="display: none;">검사 신청</button>
		                    <button class="btn btn-secondary btn-r" id="qrnApplEnd" style="display: none;">신청 완료</button>
		                </div>
		            </div>
		        </div>
		        <div class="card-right">
		            <h4>검사 결과</h4>
		            
		            <label>검사 유형 : </label> 
		            <span id="QRN_QRNT_TYPE">
		            	${customsDetailInfo.QRN_QRNT_TYPE}
		            </span><br />
		            
		            <label>검사 접수일시 : </label>
		            <span id="QRN_QRNT_RECEPT_DATE">
		            	<c:set var="qrnRecDate" value="${customsDetailInfo.QRN_QRNT_RECEPT_DATE}" />
		            	<fmt:formatDate value="${qrnRecDate}" pattern="yyyy-MM-dd HH:mm" />
		            </span><br />
		            
		            <label>검사 완료일시 : </label>
	            	<span id="QRN_QRNT_COMPLETION">
	            		<c:set var="qrnComDate" value="${customsDetailInfo.QRN_QRNT_COMPLETION}" />
		            	<fmt:formatDate value="${qrnComDate}" pattern="yyyy-MM-dd HH:mm" />
	            	</span><br />
		            
		            <label>검사 결과 : </label> 
		            <span id="QRN_QRNT_YN">
		            	<input id="QRN_QRNT_YN_HIDDEN" type="hidden" value="${customsDetailInfo.QRN_QRNT_YN}"/>
		            	<input id="QRN_HC_NO" type="hidden" value="${customsDetailInfo.QRN_HC_NO}"/>
		            	
		            	<c:if test="${customsDetailInfo.QRN_QRNT_COMPLETION ne null }">
		            		<c:if test="${customsDetailInfo.QRN_QRNT_YN eq 1 }">
		            			합격
	            			</c:if>
		            		<c:if test="${customsDetailInfo.QRN_QRNT_YN ne 1 }">
		            			불합격
	            			</c:if>
		            	</c:if>
		            </span><br />
		
		            <div class="btn-container btncr">
		                <button class="btn btn-success btn-r" id="qrnBtn" style="display: none;">보고서 확인</button>
		            </div>
		            <hr />
		            <div class="btn-container btncr dis-flex-jce" >
		            	<span class="btn-magin"></span>
		                <button class="btn btn-info btn-r" id="qrnWait" style="display: none;">검사중</button>
		                <button class="btn btn-secondary btn-r" id="qrnReject" style="display: none;">불합격</button>
		                <button class="btn btn-secondary btn-r" id="qrnEnd" style="display: none;">합격</button>
		            </div>
		        </div>
		    </div>
		</div>
		
		<c:if test="${customsDetailInfo.contractType eq '수입'}">
			<div class="section" id="TAXNOTICE">
			    <div class="card-header">
			        <h2>관부가세</h2> 
			        <p class="desc">수입시 세금납부를 고지합니다.</p>
			    </div>
			    <div class="card-main">
			        <div class="card-left">
			            <h4>세금 고지</h4>
			            <label>세금 납부번호 : </label>
			            <span id="TX_TAX_NO">
			            	${customsDetailInfo.TX_TAX_NO}
			            </span><br />
			            
			            <label>소관 : </label>	<!-- 통관지 세관 -->
			            <span id="TX_CUSTOMS_AUTHORITY">
			            	${customsDetailInfo.TX_CUSTOMS_AUTHORITY}
			            </span><br />
			            
			            <label>납부자 : </label>	<!-- 통관지 세관 -->
			            <span id="TX_CONSIGNOR_NAME">
			            	${customsDetailInfo.TX_CONSIGNOR_NAME}
			            </span><br />
			            
			            <label>대납자 : </label>	<!-- 통관지 세관 -->
			            <span id="TX_CCA_NAME">
			            	${customsDetailInfo.TX_CCA_NAME}
			            </span><br />
			            
			             <label>고지일 : </label> 
			            <span id="TX_TAX_DEST_DATE">
			            	<c:set var="inpDestDate" value="${customsDetailInfo.TX_TAX_DEST_DATE}" />
		            		<fmt:formatDate value="${inpDestDate}" pattern="yyyy-MM-dd" />
			            </span><br />
			            
			            <label>납부기한 : </label> 
			            <span id="TX_TAX_DEADLINE_DATE">
			            	<c:set var="inpDeadLineDate" value="${customsDetailInfo.TX_TAX_DEADLINE_DATE}" />
		            		<fmt:formatDate value="${inpDeadLineDate}" pattern="yyyy-MM-dd" />
			            </span><br />
			            
			            <label>세금 종류 : </label>
			            <span id="TX_TAX_TYPE">
			            	<c:if test="${customsDetailInfo.TX_TAX_NO ne '' && customsDetailInfo.TX_TAX_NO ne null}">
			            		관세
			            	</c:if>
			            </span><br />
			            
			            <label>총 납부금액 : </label>
			            <span id="TX_TAX_AMOUNT">
			            	<c:if test="${customsDetailInfo.TX_TAX_NO ne '' && customsDetailInfo.TX_TAX_NO ne null}">
			            		<fmt:formatNumber value="${customsDetailInfo.TX_TAX_AMOUNT}" type="number" groupingUsed="true" /> 원
			            	</c:if>
			            </span><br />
			            
			        </div>
			
			        <div class="card-right">
			            <h4>세납 확인</h4>
			            <label>납부여부 : </label>
			            <input type="hidden" id="TX_TAX_PAYMENT_YN" value="${customsDetailInfo.TX_TAX_YN}" >
			            <span id="TX_TAX_YN">
			            	<c:if test="${customsDetailInfo.TX_TAX_YN eq 0}">
			            		미납
			            	</c:if>
			            	<c:if test="${customsDetailInfo.TX_TAX_YN eq 1}">
			            		납부 완료
			            	</c:if>
			            </span><br />
			            
			            <label>납부일시 : </label> 
			            <span id="TX_TAX_REAL_DATE">
				            <c:set var="taxRealDate" value="${customsDetailInfo.TX_TAX_REAL_DATE}" />
			            	<fmt:formatDate value="${taxRealDate}" pattern="yyyy-MM-dd HH:mm:ss" />
			            </span><br />
			            
			            <label>실 납부금액 : </label> 
			            <span id="TX_TAX_REAL_AMOUNT">
				            <c:if test="${customsDetailInfo.TX_TAX_REAL_AMOUNT ne '' && customsDetailInfo.TX_TAX_REAL_AMOUNT ne null}">
				            	<fmt:formatNumber value="${customsDetailInfo.TX_TAX_REAL_AMOUNT}" type="number" groupingUsed="true" /> 원
				            </c:if>
			            </span><br />
			
			            <div class="btn-container btncr">
			                <button class="btn btn-success btn-r" id="txBtn" style="display: none;">고지서 확인</button>
			            </div>
			            <hr />
			            <div class="btn-container">
			                <button class="btn btn-primary btn-r" id="txWrite" style="display: none;">관부가세 고지</button>
			                <button class="btn btn-primary btn-r" id="txAppl" style="display: none;">납부 대기</button>
			                <button class="btn btn-secondary btn-r" id="txEnd" style="display: none;">납부 완료</button>
			            </div>
			        </div>
			    </div>
			</div>
			
		</c:if>
		<div class="section" id="CD">
			<div class="card-header">
				<h2>필증 발급</h2> <p class="desc">수출입 신고 행정절차의 마지막단계입니다. 신고필증을 발급합니다.</p>
			</div>
			<div class="card-main">
				<div class="card-left" >
						<label>통관 신고 필증</label><br />
						<span id="cdEnd" style="display: none;">
							통관 신고 필증이 정상적으로 발행되었습니다.
			            </span>
						<span id="cdNoEnd" style="display: none;">
							통관 신고 필증 발행 대기중입니다. 신고필증을 발행해주세요.
			            </span>
				</div>
				<div class="card-right">
					<div class="btn-container btncr">
						<button data-declNo="${customsDetailInfo.DECL_NO}" data-declDNo="${customsDetailInfo.EXA_DECL_D_NO}" 
							 style="display: none;" class="btn btn-primary btn-r" id="cdAppl">
							 필증 발행
						 </button>	
						 		
						<button data-declNo="${customsDetailInfo.DECL_NO}" data-declDNo="${customsDetailInfo.EXA_DECL_D_NO}"  
							style="display: none;" class="btn btn-success btn-r" id="cdRead">
							필증 확인
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="section" id="DOC" style="margin-bottom: 400px">
			<div class="card-header">
				<h2>연관 서류</h2>
				<p class="desc">신고 필증 발급후 서류목록을 조회하는 섹션입니다.</p>
			</div>
			<ul class="file-list">
				<li class="file-item">
					<div class="file-info">
                     	<i class="fas fa-file-alt"></i>
                     	<div class="file-details">
	                         <span class="file-name">통관 신고서</span>
	                     </div>
                 	</div>
                  	<div class="file-actions">
                  		<button class="btn btn-success btn-r" id="docDeclDBtn">신고서 확인</button>
               		</div>
				</li>
				<c:if test="${customsDetailInfo.QRN_QRNT_COMPLETION ne null }">
					<li class="file-item">
						<div class="file-info">
	                     	<i class="fas fa-file-alt"></i>
	                     	<div class="file-details">
		                         <span class="file-name">검사 검역 보고서</span>
		                     </div>
	                 	</div>
	                  	<div class="file-actions">
	                  		<button class="btn btn-success btn-r" id="docQrnBtn">보고서 확인</button>
	               		</div>
					</li>
				</c:if>
				<c:if test="${customsDetailInfo.contractType eq '수입' && customsDetailInfo.TX_TAX_NO ne '' &&customsDetailInfo.TX_TAX_NO ne null}">
					<li class="file-item">
						<div class="file-info">
	                     	<i class="fas fa-file-alt"></i>
	                     	<div class="file-details">
		                         <span class="file-name">관세 납부 고지서[대납자용]</span>
		                     </div>
	                 	</div>
	                  	<div class="file-actions">
	                  		<button class="btn btn-success btn-r" id="docTxBtn">고지서 확인</button>
	               		</div>
					</li>
				</c:if>
				<c:if test="${(18 < customsDetailInfo.LAST_STATUS_CODE && customsDetailInfo.LAST_STATUS_CODE < 22)||(37 < customsDetailInfo.LAST_STATUS_CODE && customsDetailInfo.LAST_STATUS_CODE < 42)}">
					<li class="file-item">
						<div class="file-info">
	                     	<i class="fas fa-file-alt"></i>
	                     	<div class="file-details">
		                         <span class="file-name">통관 신고 필증</span>
		                     </div>
	                 	</div>
	                  	<div class="file-actions">
	                  		<button class="btn btn-success btn-r" id="docCdRead" data-declNo="${customsDetailInfo.DECL_NO}" data-declDNo="${customsDetailInfo.EXA_DECL_D_NO}">필증 확인</button>
	               		</div>
					</li>
				</c:if>
				
			</ul>
		</div>
	</main>
</div>
<!-- 고객검사 모달 시작 -->
<div class="modal fade" id="inpModal" tabindex="-1" aria-labelledby="inpModalLabel">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="inpModalLabel"> 고객검사 </h5>
			</div>
			<div class="modal-body" id="inpModal-road">
			    <label for="id_user_name" style="text-align: center;">고객검사 중</label><br/>
			    
			    <label for="inpModal-road-closure_label">사업장 확인 : </label>
			    <div id="inpModal-road-closure" class="spinner-border text-primary" role="status">
			        <span class="visually-hidden">Loading...</span><br/>
			    </div><br/>
			
			    <label for="inpModal-road-crime_label">세급 채납확인 : </label>
			    <div id="inpModal-road-crime" class="spinner-border text-primary" role="status">
			        <span class="visually-hidden">Loading...</span><br/>
			    </div><br/>
			
			    <label for="inpModal-road-dot">범죄 이력확인 : </label>
			    <div id="inpModal-road-dot" class="spinner-border text-primary" role="status">
			        <span class="visually-hidden">Loading...</span><br/>
			    </div><br/>
			</div>
			
			<div class="modal-body" id="inpModal-Fin" style="display: none;">
				<label for="originalId" style="text-align: center;">고객검사 완료</label><br/>
				<label for="inpModal-Fin-closure_label">사업장 확인 : </label>
				<span id="inpModal-Fin-closure">
					검사 완료
				</span><br/>
				<label for="inpModal-Fin-crime_label">세급 채납확인 : </label>
				<span id="inpModal-Fin-crime">
					검사 완료
				</span><br/>
				<label for="inpModal-Fin-dot_label">범죄 이력확인 : </label>
				<span id="inpModal-Fin-dot">
					검사 완료
				</span><br/>
			</div>
		</div>
	</div>
</div>
<!-- 고객검사 모달 끝 -->
<!-- 보세창고 조회 모달 시작 -->
<div class="modal fade" id="bwhModal" tabindex="-1" aria-labelledby="bwhModalLabel">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="bwhModalLabel"> 보세창고 물품조회</h5>
			</div>
			<div class="modal-body" id="bwhModal-wait">
			    <label for="id_user_name" style="text-align: center;">
			    	대상 물품의 정보를 조회중입니다...
			    </label>
			</div>
			<div class="modal-body" id="bwhModal-success" style="display: none;">
			    <label for="id_user_name" style="text-align: center;">조회가 완료되었습니다.</label>
			</div>
			<div class="modal-body" id="bwhModal-error" style="display: none;">
			    <label for="id_user_name" style="text-align: center;">대상 물품의 정보가 없습니다.</label>
			</div>
		</div>
	</div>
</div>
<!-- 보세창고 조회 모달 끝 -->
<!-- 관부가세 고지 모달 시작 -->
<div class="modal fade" id="txSendModal" tabindex="-1" aria-labelledby="txSendModalLabel">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="txSendModalLabel"> 관부가세 고지</h5>
			</div>
			<div class="modal-body" id="txSendModal-warn">
			    <label for="id_user_name" style="text-align: center;">
			    	자동으로 고지서가 작성되며 고지절차를 이행합니다.
			    </label>
			    <div class="btn-container btncr">
				    <button class="btn btn-primary btn-c" id="txSendBtn" >승인</button>
					<button class="btn btn-danger btn-c" id="txDontSend" >취소</button>
	        	</div>
			</div>
		</div>
	</div>
</div>
<!-- 관부가세 고지 모달 끝 -->
</body>
<script>
$(document).ready(function () {
	/* 테스트를 위한 NO 출력 */
	let statuscontract = $("#contract").val();
	let statusdeclNo = $("#declNo").val();
	let statusdeclDNo = $("#declDNo").val();
	let statusprod = $("#prod").val();
	
	console.log("contractNo : ", statuscontract);
	console.log("declNo : ", statusdeclNo);
	console.log("declDNo : ", statusdeclDNo);
	console.log("prodNo : ", statusprod);
	/* 테스트를 위한 NO 출력 */
	
	/* 프로세스에 따른 요소 설정 */
	let status = parseInt($("#status").val());
	console.log("statusNo : ",status);
	// 신청 검토
	if ((7 <= status && status < 21) || (28 <= status && status < 41)) {
	    $("#exaAppro, #exaReject").show();
	    $("#stepOne").removeClass("inactive").addClass("step-circle active");
	}
	
	// 신청 반려 완료
	if ((status == 8) || (status == 29)) {
	    $("#exaRejectEnd").show();
	    $("#exaAppro, #exaReject").hide();
	    $("#INSPECTION, #BW, #QRNT, #TAXNOTICE, #CD").hide();
	}

	// 신청 수리 완료
	if ((9 <= status && status < 21) || (30 <= status && status < 41)) {
	    $("#exaApproEnd").show();
	    $("#exaAppro, #exaReject").hide();
	}
	
    // 고객검사
    if ((10 <= status && status < 21) || (31 <= status && status < 41)) {
		$("#inpAppl").show();
     	$("#stepTwo").removeClass("inactive").addClass("step-circle active");
     	
     	if(status == 10 ||status == 11 ||status == 12 || status == 31||status == 32||status == 33){
     		setTimeout(function() {
         	    scrollToSection('INSPECTION');
         	}, 100); 
     	}
    }
    
 	// 고객검사 불합격
    if ((11 == status) || (32 == status)) {
    	$("#BW, #QRNT, #TAXNOTICE, #CD").hide();
    }
 	
 	// 고객검사 완료(12, 33)
    if ((11 <= status && status < 21) || (32 <= status && status < 41)) {
    	$("#inpApplEnd").show(); 
	    $("#inpAppl").hide();
	    $("#bwhAppl").show();
	    $("#bwhApplIst").show();
    }
   
    // 물품입고
    if ((13 <= status && status < 21) || (34 <= status && status < 41)) {
    	$("#bwhAppl").hide();
    	$("#bwhApplIst").hide();
	    $("#bwhApplEnd").show(); 
	    if($("#BWH_ARRIVAL_YN").val() == 0){
	    	$("#qrnAppl").show(); 
	    }
	    if(status == 13 || status == 34){
	    	setTimeout(function() {
	     	    scrollToSection('BW');
	     	}, 100); 
	    }
     	$("#stepTri").removeClass("inactive").addClass("step-circle active");
    }

    // 검사검역
    if ((14 <= status && status < 21) || (35 <= status && status < 41)) {
    	$("#qrnAppl").hide(); 
    	$("#qrnApplEnd").show(); 
    	
    	if($("#QRN_SERVANT_NAME").text().trim() != '' && $("#QRN_SERVANT_NAME").text().trim() != null){
    		$("#qrnWait").show();
 	    } 
    	if(status == 14 ||status == 15 || status == 35 || status == 36){
 	    	setTimeout(function() {
 	     	    scrollToSection('QRNT');
 	     	}, 100); 
 	    }
     	$("#stepFur").removeClass("inactive").addClass("step-circle active");
    }
    // 검사검역 완료
    if ((15 <= status && status < 21) || (36 <= status && status < 41)) {
    	$("#qrnWait").hide();
    	$("#qrnBtn").show(); 
    	$("#docQrnBtn").show(); 
    	
    	// 검사 결과에 따라 출력
    	if((15 == status) || (36 == status )){
			$("#qrnReject").show(); 
    	}
    	if((16 <= status && 21) || (37 <= status && 41)){
    		$("#qrnEnd").show(); 
    	}
     	$("#stepFur").removeClass("inactive").addClass("step-circle active");
    }

    // 세납고지
    if (16 <= status && status < 21) {
    	
    	// 검사 결과 합격시 고지 버튼 출력
    	if($("#QRN_QRNT_YN_HIDDEN").val() == 1){
    		$("#txWrite").show(); 
 	    } 
    	
    	if($("#TX_TAX_NO").text().trim() != '' && $("#TX_TAX_NO").text().trim() != null){
    		$("#txWrite").hide(); 
    		$("#txAppl").show();
    		$("#txBtn").show();
 	    } 
    	
     	if($("#TX_TAX_PAYMENT_YN").val() == 1){
    		$("#txWrite").hide();
    		$("#txAppl").hide(); 
	    	$("#txEnd").show();
 	    } 
    	if(status == 16 ){
 	    	setTimeout(function() {
 	     	    scrollToSection('QRNT');
 	     	}, 100); 
 	    }
     	$("#stepFiv").removeClass("inactive").addClass("step-circle active");
    }
    // 세금납부
    if (17 <= status && status < 21) {
    	if(status == 17 ){
 	    	setTimeout(function() {
 	     	    scrollToSection('TAXNOTICE');
 	     	}, 100); 
 	    }
     	$("#stepSix").removeClass("inactive").addClass("step-circle active");
    }
 	// 수출시 필증발행
    if (18 <= status && status < 21) {
    	if(status == 18 ){
    		$("#cdAppl").show();
    		$("#cdNoEnd").show();
 	    	setTimeout(function() {
 	     	    scrollToSection('TAXNOTICE');
 	     	}, 100); 
 	    	$("#stepSix").removeClass("inactive").addClass("step-circle active");
 	    }
    	if(18 < status && status <22){
    		$("#cdAppl").hide();
    		$("#cdEnd").show(); 
    		$("#cdRead").show(); 
 	    	setTimeout(function() {
 	     	    scrollToSection('CD');
 	     	}, 100); 
 	    	$("#stepSev").removeClass("inactive").addClass("step-circle active");
 	    }
     	
    }

    // 수입시 필증발행
    if (37 <= status && status < 41) {
    	$("#cdAppl").show();
    	$("#cdNoEnd").show();
    	if(status == 37 ){
 	    	setTimeout(function() {
 	     	    scrollToSection('QRNT');
 	     	}, 100); 
 	    	
 	    }
     	$("#stepFivEx").removeClass("inactive").addClass("step-circle active");
    }
    if (38 <= status && status < 41) {
    	$("#cdAppl").hide();
    	$("#cdRead").show();
    	$("#cdEnd").show();
    	if(status == 38){
 	    	setTimeout(function() {
 	     	    scrollToSection('CD');
 	     	}, 100); 
 	    }
    	if(38 < status && status < 42){
 	    	setTimeout(function() {
 	     	    scrollToSection('DOC');
 	     	}, 100); 
 	    }
     	$("#stepSixEx").removeClass("inactive").addClass("step-circle active");
    }
	/* 프로세스에 따른 요소 설정 End */
	
	// 예림 
	// 보세창고 입고 버튼?
	$("#bwhApplIst").on("click", function () {
		$("#bwhApplIst").show();
		 const declNo = $("#declNo").val(); 
		 console.log("declNO", declNo)
	     const contract = $("#contract").val();
		 console.log("예림 : ", declNo)
		 console.log("예림 : ", contract)
	     location.href = "/servant/writeBw.do?declNo="+declNo+"&contractNo="+contract;
	     
	});
	
	/* exa Start */
	// 통관신고 수리 버튼 클릭
    $("#exaAppro").on("click", function () {
    	let status = parseInt($("#status").val());
    	const declDNo = $("#declDNo").val();
    	const contractNo = $("#contract").val();
    	
    	$.ajax({
            url: "/servant/exaAppro" ,
            type: "POST",          
            data: {
            	status: status,
            	declDNo : declDNo,
            	contractNo : contractNo
            },
            success: function(res) {
                console.log(res);
                if(res == 'OK'){
                	location.href = location.href;
                }
            },
            error: function(xhr, status, error) {
            	console.log("error : {} ", error)
            }
    	});
    });
  
	// 통관신고 반려 버튼 클릭
    $("#exaReject").on("click", function () {
    	
    	let status = parseInt($("#status").val());
    	const contractNo = $("#contract").val();
    	const declNo = $("#declNo").val();
		if(status == 7 || status == 28){
			$.ajax({
	            url: "/servant/exaReject" ,
	            type: "POST",          
	            data: {
	            	status: status,
	            	declNo : declNo,
	            	contractNo : contractNo
	            },
	            success: function(res) {
	                console.log(res);
	                if(res == 'OK'){
	                	location.reload();
	                } 
	            },
	            error: function(xhr, status, error) {
	            	console.log("error : {} ", error)
	            }
	    	});
    	}else{
    		alertify.alert("이미 처리된 건 모달")
    	}
    });
    /* exa End*/
    
    /* inp Start */
    $("#inpAppl").on("click", function () {
        let status = parseInt($("#status").val());
        const consignorName = $("#INP_CONSIGNOR_NAME").text();
        const declNo = $("#declNo").val();
        const contractNo = $("#contract").val();

        $.ajax({
            url: "/servant/inpAppl",
            type: "POST",
            data: {
                contractNo: contractNo,
                status: status,
                consignorName: consignorName,
                declNo: declNo
            },
            success: function (res) {
                console.log(res);
                if (res == 'OK') {
                    // Bootstrap 방식으로 모달 표시
                    var myModal = new bootstrap.Modal(document.getElementById('inpModal'));
                    myModal.show();

                    setTimeout(function () {
                        $("#inpModal-road").hide();
                        $("#inpModal-Fin").show();
                    }, 3000);
                    $('#inpModal').on('hidden.bs.modal', function () {
                        location.reload();
                    });
                }
            },
            error: function (xhr, status, error) {
                console.error("오류 발생:", error);
            }
        });
    });
    /* inp End */
    
    /* bwh Start */
    $("#bwhAppl").on("click", function () {
    	 let status = parseInt($("#status").val());
         const contractNo = $("#contract").val();
         const declNo = $("#declNo").val();
         let myModal = new bootstrap.Modal(document.getElementById('bwhModal'));
         
    	$.ajax({
            url: "/servant/bwhAppl",
            type: "POST",
            data: {
                contractNo: contractNo,
                status: status,
                declNo: declNo
            },
            beforeSend: function() {
                myModal.show();
            },
            success: function (res) {
                console.log(res);
                if (res == 'OK') {
              		setTimeout(function () {
              			$("#bwhModal-wait").hide();
              			$("#bwhModal-success").show();
                    }, 2000);
              		setTimeout(function () {
	              		myModal.hide();
	              		$("#bwhModal-wait").show();
	                    $("#bwhModal-success").hide();
              		}, 3000);
                    $('#bwhModal').on('hidden.bs.modal', function () {
                        location.reload();
                    });
                }
            },
            error: function (xhr, status, error) {
            	setTimeout(function () {
          			$("#bwhModal-wait").hide();
                    $("#bwhModal-error").show();
                }, 2000);
          		setTimeout(function () {
              		myModal.hide();
              		$("#bwhModal-wait").show();
                    $("#bwhModal-error").hide();
          		}, 2800);
                
                console.error("데이터 없어서 조회안됨->입고진행:", error);
            }
        });
    })
    /* bwh End */
    
    /* qrn Start */
    $("#qrnAppl").on("click", function () {
        const contractNo = $("#contract").val();
        let status = parseInt($("#status").val());
        const declNo = $("#declNo").val();
        

        $.ajax({
            url: "/servant/qrnAppl",
            type: "POST",
            data: {
            	contractNo : contractNo,
                status: status,
                declNo: declNo
            },
            success: function (res) {
                if (res == 'OK') {
                	location.reload();
                }
            },
            error: function (xhr, status, error) {
                console.error("오류 발생:", error);
            }
        });
    });
    
  /*   $("#qrnReject").on("click", function () {
		console.log("불합격시 점수 부과 절차");
		$.ajax({
			url: "/servant/rejectQrnCheck",
	        type: "POST",
	        data: {
	        	declNo : declNo
	        },
	        success: function (res) {
	        	if(res == 1){
	        		$.ajax({
		    			url: "/servant/rejectQrn",
		    	        type: "POST",
		    	        data: {
		    	        	declNo : declNo
		    	        },
		    	        success: function (res) {
		    	        	
		    	        },
		    	        error: function (xhr, status, error) {
		    	            console.error("오류 발생:", error);
		    	        }
		    		})
	        	}
	        	if(res == 0){
	        		
	        	}
	        },
	        error: function (xhr, status, error) {
	            console.error("오류 발생:", error);
	        }
		})
		
    }); */
    /* qrn End */
    
    /* tx Start */
    $("#txWrite").on("click", function () {
    	var myModal = new bootstrap.Modal(document.getElementById('txSendModal'));
    	myModal.show();

        // 요청 송신 버튼 클릭 시 AJAX 실행
        $("#txSendBtn").on("click", function() {
        	myModal.hide(); 
        	const prodNo = $("#prod").val();
    		const declNo = $("#declNo").val();
    		const totalCost = $("#totalCost").val();
    		
    		const contractNo = $("#contract").val();
            let status = parseInt($("#status").val());
            
    	    $.ajax({
    	        url: "/servant/txWrite",
    	        type: "POST",
    	        data: {
    	        	totalCost : totalCost,
    	        	prodNo : prodNo,
    	        	declNo : declNo,
    	        	contractNo : contractNo,
    	            status: status
    	        },
    	        success: function (res) {
    	            if (res == 'OK') {
    	            	/* alert("관세 고지가 완료되었습니다.") */
    	            	location.reload();
    	            }
    	        },
    	        error: function (xhr, status, error) {
    	            console.error("오류 발생:", error);
    	        }
    	    });
        });

        $("#txDontSend").on("click", function() {
            $("#txSendModal").hide();
            location.reload();
        });
    })
    /* tx End */
    
    /*** 필증 발급 start***/
	$("#cdAppl").on("click", function () {
		const contractNo = $("#contract").val();
	    let status = parseInt($("#status").val());
	    const declNo = $(this).data("declno");
	    const declDNo = $(this).data("decldno");
	    console.log("declNo : " + declNo, "contractNo : "+ contractNo);
	    location.href="/servant/cdform.do?contractNo="+contractNo+"&declNo="+declNo+"&status="+status;
	})
	/* 필증 발급** end ***/
    
    /* 스크롤 함수 Start*/
    $(window).on("scroll", function () {
	  const headerHeight = $(".content-header").outerHeight()+15;
	  const scrollTop = $(window).scrollTop();

	  if (scrollTop >= headerHeight) {
	    $(".progress-border").addClass("fixed");
	    $("#scroll-margin").addClass("scroll-margin");
	  } else {
	    $(".progress-border").removeClass("fixed");
	    $("#scroll-margin").removeClass("scroll-margin");
	  }
	  
	});
    
    window.scrollToSection = function (divId) {
      	const offset = $("#" + divId).offset().top - 190; 
     	 $("html, body").animate({ scrollTop: offset }, 400);
	};
	/* 스크롤 함수 End */
	
	/* 문서조회 Start */
	$("#qrnBtn").on("click", openQrnPage);
	$("#docQrnBtn").on("click", openQrnPage);
	
	$("#txBtn").on("click", openTaxPage);
	$("#docTxBtn").on("click", openTaxPage);
	
	$("#declDBtn").on("click", openDeclPage);
	$("#docDeclDBtn").on("click", openDeclPage);
	
	$("#cdRead").on("click", openCdPage);
	$("#docCdRead").on("click", openCdPage);
	/* 문서조회 End */
});

/* 문서용 핸글러 함수 Start */
function openQrnPage() {
	let hcNo = $("#QRN_HC_NO").val();
	console.log("openQrnPage -> hcNo:", hcNo);
	window.open("/servant/inspectReviewResult.do?hcNo=" + hcNo, "_blank", "width=1280,height=900,top=100,left=100");
}
function openTaxPage() {
	let declNo = $("#declNo").val();
	console.log("openTaxPage -> declNo:", declNo);
	window.open("/doc/taxBill.do?declNo=" + declNo, "_blank", "width=1280,height=900,top=100,left=100");
}
function openDeclPage() {
	let declDNo = $("#declDNo").val();
	console.log("openDeclPage -> declDNo:", declDNo);
	window.open("/contract/decl/detail.do?declDNo=" + declDNo, "_blank", "width=1280,height=900,top=100,left=100");
}
function openCdPage() {
    const contractNo = $("#contract").val();
    const status = parseInt($("#status").val());
    const declNo = $("#docCdRead").data("declno");
    const declDNo = $("#docCdRead").data("decldno");
    
    const cdNo = "${customsDetailInfo.cdVO.cdNo}";

    console.log("openDeclPage -> declDNo:", declDNo);
 
    window.open(
        "/servant/cdDetail.do?cdNo="+cdNo,
        "_blank",
        "width=800,height=1000,scrollbars=yes,resizable=yes"
    );
}
/* 문서용 핸글러 함수 End */
</script>
</html>