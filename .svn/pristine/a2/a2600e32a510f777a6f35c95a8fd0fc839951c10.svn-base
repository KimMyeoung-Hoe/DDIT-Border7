<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검사검역 심사 결과</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>
<body>
<div class="app-container">
    <main class="main-content-area">
		
		<form action="/pdf/download2.do" id="pdfDownFrom" method="get">
				<input type="hidden" name="url" value="servant/inspectReviewResult.do?hcNo=${resultData.HC_NO}"/>
				<button type="submit" class="btn btn-primary btn-c btn-sm">pdf 다운로드</button>
		</form>

        <div id="pdfTarget" style="background: #ffffff !important; border-radius: 12px; padding: 30px; backdrop-filter: blur(5px); border: 1px solid rgba(255, 255, 255, 0.1); box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37); width: 100%; box-sizing: border-box; margin-bottom: 30px;">
            
            <!-- 문서 헤더 -->
            <div style="text-align: center; margin-bottom: 20px; position: relative; padding: 10px 0; border-bottom: 2px solid #e0e0e0;">
                <div style="position: absolute; left: 20px; top: 50%; transform: translateY(-50%); display: flex; align-items: center; gap: 5px;">
                    <span style="font-size: 28px; font-weight: bold; color: #2a73d8;">Border7</span>
                </div>
                <h2 style="font-size: 26px; font-weight: bold; margin: 0; color: #333;">검사·검역 결과 보고서</h2>
            </div>

            <!-- 1. 기본 정보 (두 개의 열로 구성) -->
            <div style="display: flex; justify-content: space-between; gap: 2%; margin-bottom: 20px; margin-top: 20px;">
                <!-- 왼쪽 열: 물품 정보 -->
                <div style="width: 49%; background-color: #fff; padding: 20px; border-radius: 8px; border: 1px solid #e0e0e0; box-sizing: border-box;">
                    <h3 style="font-size: 16px; font-weight: bold; margin-top: 0; margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #e0e0e0; color: #333;">검사·검역 대상 물품 정보</h3>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 100px; flex-shrink: 0;">품명:</label><span style="color: #333;">${resultData.PRODUCT_NAME}</span></div>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 100px; flex-shrink: 0;">품종:</label><span style="color: #333;">${resultData.HS_NCC_NAME} (${resultData.HS_KR_NAME})</span></div>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 100px; flex-shrink: 0;">무게:</label><span style="color: #333;"><fmt:formatNumber value="${resultData.HC_WEIGHT}" pattern="#,##0.##" /> KG</span></div>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 100px; flex-shrink: 0;">수량:</label><span style="color: #333;">${resultData.HC_QTY} 개</span></div>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 100px; flex-shrink: 0;">학명:</label><span style="color: #333;">${resultData.HS_EN_NAME}</span></div>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 100px; flex-shrink: 0;">원산지:</label><span style="color: #333;">${resultData.PRODUCT_ORIGIN}</span></div>
                </div>

                <!-- 오른쪽 열: 신청 정보 -->
                <div style="width: 49%; background-color: #fff; padding: 20px; border-radius: 8px; border: 1px solid #e0e0e0; box-sizing: border-box;">
                    <h3 style="font-size: 16px; font-weight: bold; margin-top: 0; margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #e0e0e0; color: #333;">신청 기본 정보</h3>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 140px; flex-shrink: 0;">신고접수번호:</label><span style="color: #333;">${resultData.HC_NO}</span></div>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 140px; flex-shrink: 0;">접수일:</label><span style="color: #333;"><fmt:formatDate value="${resultData.QRNT_RECEPT_DATE}" pattern="yyyy-MM-dd"/></span></div>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 140px; flex-shrink: 0;">신청인 성명:</label><span style="color: #333;">${resultData.CONSIGNOR_USER_NAME}</span></div>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 140px; flex-shrink: 0;">상호명:</label><span style="color: #333;">${resultData.CONSIGNOR_NAME}</span></div>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 140px; flex-shrink: 0;">주소:</label><span style="color: #333;">${resultData.CONSIGNOR_ADDR} ${resultData.CONSIGNOR_DET_ADDR}</span></div>
                    <div style="margin-bottom: 12px; display: flex; align-items: center; font-size: 13px;"><label style="font-weight: bold; color: #555; width: 140px; flex-shrink: 0;">전화번호:</label><span style="color: #333;">${resultData.HC_TEL}</span></div>
                </div>
            </div>

            <!-- 2. 현장 검사 -->
            <h3 style="background-color: #eef2f8; padding: 8px 10px; margin-top: 20px; margin-bottom: 0; font-size: 15px; font-weight: bold; border: 1px solid #ccc; border-bottom: none; color: #333;">2. 현장 검사</h3>
            <table style="width: 100%; border-collapse: collapse; margin-bottom: 20px;">
                <thead style="background-color: #f7f7f7;">
                    <tr>
                        <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: center; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: bold; color: #555; width: 30%;">내용</th>
                        <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: center; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: bold; color: #555;">결과</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555;">포장상자 개봉·파손</th>
                        <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333;">
                            <c:choose>
                                <c:when test="${not empty resultData.HC_PACKAGING_CONDITION}">${resultData.HC_PACKAGING_CONDITION}</c:when>
                                <c:otherwise>이상 없음</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555;">보존/보관상태</th>
                        <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333;">
                             <c:choose>
	                            <c:when test="${not empty resultData.HC_STORAGE_CONDITION}">${resultData.HC_STORAGE_CONDITION}</c:when>
	                            <c:otherwise>이상 없음</c:otherwise>
	                        </c:choose>
                        </td>
                    </tr>
                     <tr>
                        <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555;">성상/색깔/냄새/육질 등</th>
                        <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333;">
                             <c:choose>
	                            <c:when test="${not empty resultData.HC_SENSORY_PROPERTIES}">${resultData.HC_SENSORY_PROPERTIES}</c:when>
	                            <c:otherwise>이상 없음</c:otherwise>
	                        </c:choose>
                        </td>
                    </tr>
                     <tr>
                        <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555;">부패/변질</th>
                        <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333;">
                            <c:choose>
	                            <c:when test="${not empty resultData.HC_SPOILAGE_CHECK}">${resultData.HC_SPOILAGE_CHECK}</c:when>
	                            <c:otherwise>이상 없음</c:otherwise>
	                        </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555;">이물질</th>
                        <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333;">
                            <c:choose>
	                            <c:when test="${not empty resultData.HC_FOREIGN_SUBSTANCE_CHECK}">${resultData.HC_FOREIGN_SUBSTANCE_CHECK}</c:when>
	                            <c:otherwise>이상 없음</c:otherwise>
	                        </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555;">한글표시사항</th>
                        <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333;">
                            ${resultData.HC_KR_NOTATION == 1 ? '적합' : '부적합'}
                        </td>
                    </tr>
                    <tr>
                        <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555;">질병 관리</th>
                         <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333;">
	                        <c:choose>
	                            <c:when test="${not empty resultData.diseaseNames}">
	                                <c:forEach var="disease" items="${resultData.diseaseNames}" varStatus="status">
	                                    ${disease.DISEASE_KR_NAME}${not status.last ? ', ' : ''}
	                                </c:forEach>
	                            </c:when>
	                            <c:otherwise>
	                                해당 사항 없음
	                            </c:otherwise>
	                        </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555;">기타 (결격 사유 등)</th>
                        <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333;">
                            <c:choose>
	                            <c:when test="${not empty resultData.HC_ETC}">${resultData.HC_ETC}</c:when>
	                            <c:otherwise>특이사항 없음</c:otherwise>
	                        </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555;">담당 검역 검사관</th>
                        <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff; color: #333;">
                            ${resultData.SERVANT_NAME}
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- 3. 종합 판정 -->
            <h3 style="background-color: #eef2f8; padding: 8px 10px; margin-top: 20px; margin-bottom: 0; font-size: 15px; font-weight: bold; border: 1px solid #ccc; border-bottom: none; color: #333;">3. 종합 판정</h3>
             <table style="width: 100%; border-collapse: collapse;">
                <tr>
                    <th style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 13px; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #f7f7f7; font-weight: normal; color: #555; width: 120px;">최종 검사 결과</th>
                    <td style="border: 1px solid #ccc; padding: 8px 10px; text-align: left; font-size: 14px; font-weight: bold; vertical-align: middle; height: 30px; box-sizing: border-box; background-color: #fff;">
                        <c:choose>
	                        <c:when test="${resultData.HC_YN == 1}">
	                            <span style="color: #2a73d8;">합격</span>
	                        </c:when>
	                        <c:otherwise>
	                            <span style="color: #d9534f;">불합격</span>
	                        </c:otherwise>
	                    </c:choose>
                    </td>
                </tr>
            </table>

        </div>
    </main>
</div>
</body>
</html>
