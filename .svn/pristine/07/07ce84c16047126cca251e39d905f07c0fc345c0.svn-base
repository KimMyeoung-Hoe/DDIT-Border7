 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Border7</title>

	<%@ include file="../modules/header.jsp" %>
	<%@ include file="../modules/sidebar.jsp" %>
	<%@ include file="../modules/modal.jsp" %>
	<link rel="stylesheet" href="/css/sidebar.css">
	<link rel="stylesheet" href="/css/header.css">
	<link rel="stylesheet" href="/css/dashboard.css">
	<link rel="stylesheet" href="/css/main.css">
	
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
	<script src ="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js" ></script>
	<script src="https://cdn.jsdelivr.net/npm/echarts@5.6.0/dist/echarts.min.js"></script>
	<script src ="https://api.windy.com/assets/map-forecast/libBoot.js" ></script>
	
	<style type="text/css">
	.h2Div{
		padding-top: 60px;
	}
	.section-title{
		padding-bottom: 5px;
	}
	.data-table td {
	    padding: 10px;
	    line-height: 1.5;
	    vertical-align: middle;
	}
	/* .titleTop{
		padding-top: 53.8px;
	}  */
	
	.app-container{
		display: block;
	}
	</style>
</head>
<body>
<sec:authentication property="principal" var="princ"/>
<c:if test="${princ ne 'anonymousUser'}">
	<sec:authentication property="authorities" var="auth"/>
	<c:set var="userVO" value="${princ.user }"/>
	<%-- <%@ include file="./roleMain/${auth}.jsp" %> --%>
</c:if>
<!------------------------------------>
<div class="app-container">
    <main class="main-content-area" >
		<!-- 메인 컨텐츠 영역 -->
		<div style="display: flex; gap: 20px; min-height: 60vh; width: 100%">
		    <!-- 왼쪽 메인 컨텐츠 -->
		    <div style="width:70%; flex: 2; display: flex; flex-direction: column; gap: 20px;">
		    	<!-- <div class="titleTop"></div> -->
		    	<div class="content-title">업무 대시보드</div>
		        <!-- 새 업무 섹션 -->
		        <div class="section" style="background: white; padding: 20px; border-radius: 8px; box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);">
		        	
		        	<div class="section-header" style="margin-bottom: 10px; display: flex;justify-content: space-between;">
						<h3 class="section-title">            
			            	통관 신고 업무 
			            	<c:if test="${not empty custPagingVO.dataList}">
				            	( ${custPagingVO.totalRecord}건 )
			            	</c:if>
			            </h3>
			             <button onclick="goAdminWork()" style="background: #007bff; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer;">
		                    목록가기
		                </button>
					</div>
		            <table class="data-table">
						<thead>
				            <tr id="sort">
				                <th id="th_index">번호</th>
				                <th id="th_2">접수번호</th>
				                <th id="th_1">수출입 구분</th>
				                <th id="th_3">신청인</th>
				                <th id="th_4">대리인</th>
				                <th id="th_7">진행중인 업무</th>
				                <th id="th_9">업무 절차 번호</th>
				                <th id="th_10">접수일</th>
				            </tr>
				        </thead>
				        <tbody>
							<c:choose>
								<c:when test="${empty custPagingVO.dataList}">
								    <tr>
								        <td colspan="11">조회된 업무가 없습니다.</td>
								    </tr>
								</c:when>
								<c:otherwise>
								    <c:forEach var="customs" items="${custPagingVO.dataList}" varStatus="status" >
								        <tr id="tr_index_${status.index}" >
								            <td class="td_index_${status.index}">
								            	${customs['RN']}
							            	</td>
							            	 <td id="td_declDNO_${status.index}">
								            	<a href="/servant/customsDetail.do?declDNo=${customs['DECLDNO']}&contractType=${customs['CONTRACTTYPE']}">
											        ${customs['DECLDNO']}
											    </a>
								            </td>
								            <td id="td_contractType_${status.index}">
								            	${customs['CONTRACTTYPE']}
								            </td>
								            <td id="td_consignorName_${status.index}">
								            	${customs.CONSIGNORCOMPANYNAME} / ${customs.CONSIGNORNAME}
								            </td>
								            <td id="td_ccaName_${status.index}">
								            	${customs['CCANAME']}
								            </td>
								            <td id="td_mediumCategory_${status.index}">
								            		${customs['MEDIUMCATEGORY']} ${customs['STATUSCODENAME']}
								            </td>
								            <td id="td_status_Code_${status.index}">
								           		${customs['STATUSCODE']}
								            </td>
								             <td id="td_declReceptDate_${status.index}">
												<c:set var="declReceptDate" value="${customs['DECLRECEPTDATE']}" />
												<fmt:formatDate value="${declReceptDate}" pattern="yyyy-MM-dd" />
										    </td>
								        </tr>
								    </c:forEach>
								</c:otherwise>
							</c:choose>
				        </tbody>
				    </table>
		        </div>
				<!-- 새 업무 섹션 -->
		        <!-- 하단 섹션들 -->
		        <div style="display: flex; gap: 20px;">
		            
		            <!-- 보세창고 섹션 -->
		            <div style="width: 45%; flex: 1; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);">
		                <h3 class="section-title">보세창고 반출입</h3>
		                <div class="table-section">
		                    <table class="data-table">
								<thead>
									<tr>
										<th>보세창고 부호</th>
										<th>섹션 번호</th>
										<th>신고필증 일련번호</th>
										<th>물품 입고일자</th>
										<th>총 보관일수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${bwAll}" var="bw">
										<tr >
											<td>${bw.bwhVO.bwhCd}</td>
											<td>${bw.whSectionVO.whSectionNo}</td>
											<td>${bw.cdVO.cdNo}</td>
											<td><fmt:formatDate value="${bw.bwArrivalDate}" pattern="yyyy-MM-dd" /></td>
											<td>${bw.bwSporageDuration}</td>
										</tr>
									</c:forEach>
								</tbody>
							 </table>
						 </div>
		            </div>
		 			<!-- 보세창고 섹션 -->
		            <!-- 검사검역 섹션 -->
		            <div style="width: 45%; flex: 1; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);">
		                <h3 class="section-title">물품 검사검역 심사</h3>
		                <c:choose>
		                	<c:when test="${inspectPagingVO.dataList ne '' && inspectPagingVO.dataList ne null}">
		                		<div class="table-section">
							        <table class="data-table">
							            <thead>
							                <tr>
							                    <th align="center">접수번호</th>
							                    <th align="center">수출입 구분</th>
							                    <th align="center">담당자</th>
							                    <th align="center">접수일</th>
							                    <th align="center">진행 상태</th>
							                    <th align="center">검사 유형</th>
							                </tr>
							            </thead>
							            <tbody>
							            	<c:choose>
							            		<c:when test="${empty inspectPagingVO.dataList}">
												    <tr>
												        <td colspan="8" align="center">조회된 검사검역 신청 내역이 없습니다.</td>
												    </tr>
							            		</c:when>
							            		<c:otherwise>
									            	<c:forEach items="${inspectPagingVO.dataList }" var="qrnt" varStatus="status"> 
										                <tr>
										                    <td align="center">
										                    	<a href="/servant/inspectReviewDetail.do?declNo=${qrnt.DECL_NO}">${qrnt.DECL_D_NO }</a>
									                    	</td>
										                    <td align="center">
											                    <c:choose>
											                    	<c:when test="${fn:startsWith(qrnt.CONTRACT_NO, 'IMP')}">
											                    		수입
											                    	</c:when>
											                    	<c:when test="${qrnt.CONTRACT_NO.startsWith('EXP') }">
											                    		수출
											                    	</c:when>
											                    	<c:otherwise>
											                    		${qrnt.CONTRACT_NO }
											                    	</c:otherwise>
											                    </c:choose>
										                    </td>
										                    <td align="center">${qrnt.EMP_NO }</td>
										                    <td align="center"><fmt:formatDate value="${qrnt.QRNT_RECEPT_DATE }" pattern="yyyy-MM-dd"/></td>
										                    <td align="center">
										                    	<c:choose>
										                    		<c:when test="${qrnt.QRNT_STATUS_CODE eq '검사 진행중'}">
												                    	<span>${qrnt.QRNT_STATUS_CODE }</span>
										                    		</c:when>
										                    		<c:when test="${qrnt.QRNT_STATUS_CODE eq '검사 대기'}">
												                    	<span>${qrnt.QRNT_STATUS_CODE }</span>
										                    		</c:when>
										                    		<c:otherwise>
												                    	<span >${qrnt.QRNT_STATUS_CODE }</span>
										                    		</c:otherwise>
										                    	</c:choose>
										                    </td>
										                    <td align="center">${qrnt.QRNT_TYPE }</td>
									                	</tr>
									            	</c:forEach>
							            		</c:otherwise>
							            	</c:choose>
							            </tbody>
							        </table>
								</div>
		                	</c:when>
		                	<c:otherwise>
				                <div style="text-align: center; padding: 40px 20px; color: #666;">
				                    <div style="font-size: 48px; margin-bottom: 10px;">📄</div>
				                    <div>심사 신청 정보가 없습니다.</div>
				                </div>
		                	</c:otherwise>
		                </c:choose>
		            </div>
		            <!-- 검사검역 섹션 -->
		        </div>
		        <!-- 하단 섹션들 -->
		    </div>
			<!-- 왼쪽 메인 컨텐츠 -->
			
		    <!-- 우측 사이드 위젯 -->
		    <div style="width:30%; max-width:25vw; flex: 1; display: flex; flex-direction: column; gap: 20px;">
		        <div class="h2Div"></div>
		        <!-- 민원사항 섹션 -->
		        <div style="min-width:400px;background: white; padding: 20px; border-radius: 8px; box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);">
			        <div class="section-header" style="margin-bottom: 10px; display: flex;justify-content: space-between;">
			            <h3 class="section-title">민원사항</h3>
			            <button onclick="goAppeal()" style="background: #007bff; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer;">
		                    목록가기
		                </button>
	                </div>
		            <table class="data-table">
		                <thead>
		                    <tr>
		                        <th>민원 제목</th>
		                        <th>민원 분류</th>
		                        <th>민원 작성일시</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <c:if test="${empty apealPagingVO.dataList}">
		                    <tr>
		                        <td colspan="3" style="text-align: center;">민원 신청 내역이 없습니다.</td>
		                    </tr>
		                    </c:if>
		                    <c:if test="${not empty apealPagingVO.dataList }">
		                        <c:forEach items="${apealPagingVO.dataList }" var="appeal" varStatus="vs">
		                            <tr class="appeal-row" data-appeal-no="${appeal.appealNo}">
										<td>
											<c:set var="maxLength" value="10" />
		                                    <c:set var="contentLength" value="${fn:length(appeal.appealTitle)}" />
		                                    
		                                    <c:if test="${contentLength > maxLength}">
		                                        <span class="truncated-content" >
		                                        	${fn:substring(appeal.appealTitle, 0, maxLength)}...
	                                        	</span>
		                                        <span class="full-content" style="display:none;">
		                                        	${appeal.appealTitle}
		                                        </span>
		                                    </c:if>
		                                    
		                                    <c:if test="${contentLength <= maxLength}">
		                                        <span>${appeal.appealTitle}</span>
		                                    </c:if>
										</td>
		                                <td>
		                                	${appeal.appealType }
		                                </td>
		                                <td>
		                                	${appeal.appealRegDate }
		                                </td>
		                            </tr>
		                        </c:forEach>
		                    </c:if>
		                </tbody>
		            </table>
		        </div>
		        <!-- 민원사항 섹션 -->
		        <!-- 제재이력 섹션 -->
		        <div style="background: white; padding: 20px; border-radius: 8px; box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);">
		            <h3 class="section-title">관세사 제재이력</h3>
		              <div style="text-align: center; padding: 40px 20px; color: #666;">
		                    <div style="font-size: 48px; margin-bottom: 10px;">📄</div>
		                    <div> 7일이내 제재 이력 정보가 없습니다.</div>
		                </div>
		        </div>
		        <!-- 제재이력 섹션 -->
	          	<!-- HS코드 분석 섹션 -->
		        <div style="background: white; padding: 20px; border-radius: 8px; box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);">
                    <div class="section-header">
                        <h3 class="section-title">HS코드 분석</h3>
                        <p class="stats-subtitle">HS코드 분석 및 통계 정보</p>
                    </div>
					<div style="display: flex; justify-content: space-between; text-align: center;">
	                    <div class="stat-item">
	                        <div class="stat-number">${exportCount}</div>
	                        <div class="stat-label">수출 품목수</div>
	                    </div>
	                    <div class="stat-item">
	                        <div class="stat-number">${importCount }</div>
	                        <div class="stat-label">수입 품목수</div>
	                    </div>
	                    <div class="stat-item">
	                        <div class="stat-number">${hsCodeCount }</div>
	                        <div class="stat-label">주요 HS코드</div>
	                    </div>
	                    <div class="stat-item">
	                        <div class="stat-number">${contractCount }</div>
	                        <div class="stat-label">최근 7일 신규 등록 건수</div>
	                    </div>
					</div>
                </div>
		        <!-- HS코드 분석 섹션 -->
		    </div>
		    <!-- 우측 사이드 위젯 -->
		</div>
	</main>
</div>
</body>
<script type="text/javascript">
function goAdminWork(){
	window.location.href="<%=request.getContextPath()%>/servant/adminWork.do";
}
function goAppeal() {
    window.location.href = "<%=request.getContextPath()%>/board/appealList.do";
}
</script>
</html>