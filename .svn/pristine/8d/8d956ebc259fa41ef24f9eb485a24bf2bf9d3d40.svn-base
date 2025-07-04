<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통관의뢰 등록하고 ci/pl 작성전 오는 페이지</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<%@ include file="../modules/modal.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/contract.css">
<style type="text/css">
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
							<li class="breadcrumb-item"><a href="/consignor/ccaList.do">관세사 정보 보기</a></li>
						</ol>
					</div>
				</div>

				<div class="content-title">통관 의뢰 신청 확인</div>
				<p class="desc">통관 의뢰 신청서의 작성내용을 확인 합니다.</p>

			</div>
            
			<div class="section">
                <div class="container">
	                <div class="row">
	                	<span class="form-label col-sm-4">관세사</span>
	                	<div class="col-sm-8">
	                    	<span class="form-value ">${contractVO.ccaVO.ccaName }</span>
	                	</div>
	                </div>
	                    
                    <div class="row">
	                	<span class="form-label col-sm-4">HS 코드</span>
	                	<div class="col-sm-8">
	                		<span class="form-value ">${contractVO.productVO.hsCode }</span>
	                	</div>
	                    
	                </div>
	                
                    <div class="row">
	                	<span class="form-label col-sm-4">수입/수출 구분</span>
	                	<div class="col-sm-8">
	                		<span class="form-value ">${contractVO.contractType }</span>
	                	</div>
	                    
	                </div>
                    <div class="row">
	                	<span class="form-label col-sm-4">물품 명칭</span>
	                	<div class="col-sm-8">
	                		<span class="form-value ">${contractVO.productVO.productName }</span>
	                	</div>
	                    
	                </div>
                    <div class="row">
	                	<span class="form-label col-sm-4">물품 원산지</span>
	                	<div class="col-sm-8">	
	                		<span class="form-value ">${contractVO.productVO.productOrigin }</span>
	                	</div>
	                </div>
                    <div class="row">
	                	<span class="form-label col-sm-4">물품 수량</span>
	                	<div class="col-sm-8">
	                    	<span class="form-value ">${contractVO.productVO.productQty } 개</span>
	                	</div>
	                </div>
                    <div class="row">
	                	<span class="form-label col-sm-4">물품 중량</span>
	                	<div class="col-sm-8">
		                    <span class="form-value ">${contractVO.productVO.productWeight } KG</span>
	                	</div>
	                </div>
                    <div class="row">
	                	<span class="form-label col-sm-4">물품 부피</span>
	                	<div class="col-sm-8">
	                    	<span class="form-value ">${contractVO.productVO.productVolume } CBM</span>
	                	
	                	</div>
	                </div>
	                
                    <div class="row">
	                	<span class="form-label col-sm-4">물품 단가</span>
	                	<div class="col-sm-8">
	                    	<span class="form-value ">${contractVO.productVO.productPrice } 원</span>
	                	
	                	</div>
	                </div>
                </div>
                <input type="hidden" name="consignorNo" id="consignorNo" value=""/>
				<div class="btn-container">
					<input type="button" id="docWrite" value="문서작성하기" class="btn btn-primary btn-c submit-button"/>
					<c:if test="${contractVO.lastStatusCode == 1 || contractVO.lastStatusCode == 22}">
						<input type="button" id="edit" value="수정하기" class="btn btn-primary btn-c"/>
					</c:if>
				</div>
                
			</div>
			<a class="autolink" href="/contract/contractdocform.do?contractNo=IMP-2025-00110">문서작성 페이지(테스트 링크용)</a>
		</main>
	</div>
</body>
<script type="text/javascript">
$(function(){
	
	$("#docWrite").on("click",function(){
		location.href="/contract/contractdocform.do?contractNo=${contractNo}"
	});
	$("#edit").on("click",function(){
		location.href="/contract/contractEdit.do?contractNo=${contractVO.contractNo}"
	});
	
});
</script>
</html>