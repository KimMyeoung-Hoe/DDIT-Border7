<%@page import="kr.or.ddit.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공무원의 이용자 상세정보 관리 페이지</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<style type="text/css">
/* myInfo.jsp 스타일 적용 */
        .table-section {
            margin: 0px auto 15px;
        }
        .td-h {
            min-width: 180px;
            max-width: 180px;
            font-weight: bold;
            background-color: #f8f9fa;
        }
        .td-b {
            width: 100%;
        }
        .td-p {
            min-width: 200px;
            height: 200px;
            position: relative;
        }
        .profileImg {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            object-fit: cover; /* 이미지가 잘리지 않고 채워지도록 */
        }
        .ynSpan {
            vertical-align: middle;
            height: 30px;
            margin-left: 5px;
        }
        #emailYn, #smsYn {
            vertical-align: middle;
        }
        .form-control[readonly] {
        	background-color: #fff;
        	border: none;
        }
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
                        <li class="breadcrumb-item"><a href="/servant/userMng.do">일반이용자 관리</a></li>
                        <li class="breadcrumb-item"><a href="#">일반이용자 상세정보</a></li>
                     </ol>
                  </div>
               </div>
               <div class="content-title">일반이용자 상세정보</div>
               <p class="desc">일반이용자의 상세정보를 보는 페이지입니다.</p>
            </div>
            
            <div class="section">
                <div class="table-section">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th colspan="4">계정 정보</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="td-p" rowspan="5">
                                    <c:choose>
								        <c:when test="${userVO.authCode eq 'ROLE_CONSIGNOR'}">
								            <img class="profileImg" src="/servant/displayProfileImage?fileName=${userVO.consignorVO.consignorProfileImg}" alt="프로필 사진" />
								        </c:when>
								        <c:when test="${userVO.authCode eq 'ROLE_CCA'}">
								            <img class="profileImg" src="/servant/displayProfileImage?fileName=${userVO.ccaVO.ccaProfileImg}" alt="프로필 사진" />
								        </c:when>
								        <c:when test="${userVO.authCode eq 'ROLE_LOGISTICS'}">
								            <img class="profileImg" src="/servant/displayProfileImage?fileName=${userVO.logistMngVO.logistMngProfileImg}" alt="프로필 사진" />
								        </c:when>
								        <c:otherwise>
								            <img class="profileImg" src="/img/default_profile.png" alt="기본 프로필 사진" />
								        </c:otherwise>
								    </c:choose>
                                </td>
                                <td class="td-h">권한</td>
                                <td class="td-b td-tl">
                                    <c:choose>
                                        <c:when test="${userVO.authCode eq 'ROLE_CONSIGNOR'}">화주</c:when>
                                        <c:when test="${userVO.authCode eq 'ROLE_CCA'}">관세사</c:when>
                                        <c:when test="${userVO.authCode eq 'ROLE_LOGISTICS'}">물류관리자</c:when>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <td class="td-h">아이디</td>
                                <td class="td-b td-tl">${userVO.userId}</td>
                            </tr>
                            <tr>
                                <td class="td-h">내부 이메일</td>
                                <td class="td-b td-tl">${userVO.userId}@border7.kr</td>
                            </tr>
                            <tr>
                                <td class="td-h">가입일자</td>
                                <td class="td-b td-tl"><fmt:formatDate value="${userVO.regDate}" pattern="yyyy-MM-dd" /></td>
                            </tr>
                            <c:if test="${not empty userVO.withdrawDate }">
                            <tr>
                            	<td class="td-h">탈퇴일자</td>
                            	<td class="td-h td-tl"><fmt:formatDate value="${userVO.withdrawDate }" pattern="yyyy-MM-dd"/></td>
                            </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="table-section">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th colspan="2">업체 정보</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${userVO.authCode eq 'ROLE_CONSIGNOR'}">
                                <tr>
                                	<td class="td-h">통관번호</td>
                                	<td class="td-b td-tl">${userVO.consignorVO.consignorCustomsCode}</td>
                                </tr>
                                <tr>
                                	<td class="td-h">사업자명</td>
                                	<td class="td-b td-tl">${userVO.consignorVO.consignorName}</td>
                                </tr>
                                <tr>
                                	<td class="td-h">사업자번호</td>
                                	<td class="td-b td-tl">${userVO.consignorVO.businessNumber}</td>
                                </tr>
                                <tr>
                                	<td class="td-h">전화번호</td>
                                	<td class="td-b td-tl">${userVO.consignorVO.consignorTel}</td>
                                </tr>
                                <tr>
                                	<td class="td-h">주소</td>
                                	<td class="td-b td-tl">${userVO.consignorVO.consignorAddr} ${userVO.consignorVO.consignorDetAddr}</td>
                                </tr>
                            </c:if>
                            
                            <c:if test="${userVO.authCode eq 'ROLE_CCA'}">
                                <tr>
                                	<td class="td-h">관세사명</td>
                                	<td class="td-b td-tl">${userVO.ccaVO.ccaName}</td>
                                </tr>
                                <tr>
                                	<td class="td-h">관세사등록번호</td>
                                	<td class="td-b td-tl">${userVO.ccaVO.ccaRegistrationNumber}</td>
                                </tr>
                                <tr>
                                	<td class="td-h">전화번호</td>
                                	<td class="td-b td-tl">${userVO.ccaVO.ccaTel}</td>
                                </tr>
                                <tr>
                                	<td class="td-h">주소</td>
                                	<td class="td-b td-tl">${userVO.ccaVO.ccaAddr} ${userVO.ccaVO.ccaDetAddr}</td>
                                </tr>
                                <tr>
                                    <td class="td-h">주력분야</td>
                                    <td class="td-b td-tl" style="text-align: left;">
								        <input type="checkbox" value="1" disabled ${specialtyCheckedMap.specialty1 ? 'checked' : ''} />수출입신고<br/>
								        <input type="checkbox" value="2" disabled ${specialtyCheckedMap.specialty2 ? 'checked' : ''} />FTA<br/>
								        <input type="checkbox" value="3" disabled ${specialtyCheckedMap.specialty3 ? 'checked' : ''} />관세환급<br/>
								        <input type="checkbox" value="4" disabled ${specialtyCheckedMap.specialty4 ? 'checked' : ''} />품목분류(HS CODE 분류)<br/>
								        <input type="checkbox" value="5" disabled ${specialtyCheckedMap.specialty5 ? 'checked' : ''} />관세평가<br/>
								        <input type="checkbox" value="6" disabled ${specialtyCheckedMap.specialty6 ? 'checked' : ''} />관세조사 대응<br/>
								        <input type="checkbox" value="7" disabled ${specialtyCheckedMap.specialty7 ? 'checked' : ''} />관세/무역 컨설팅<br/>
								    </td>
                                </tr>
                            </c:if>
                            
                            <c:if test="${userVO.authCode eq 'ROLE_LOGISTICS'}">
                                <tr>
                                	<td class="td-h">사업자명</td>
                                	<td class="td-b td-tl">${userVO.logistMngVO.logistMngName}</td>
                                </tr>
                                <tr>
                                	<td class="td-h">사업자번호</td>
                                	<td class="td-b td-tl">${userVO.logistMngVO.businessNumber}</td>
                                </tr>
                                <tr>
                                	<td class="td-h">전화번호</td>
                                	<td class="td-b td-tl">${userVO.logistMngVO.logistMngTel}</td>
                                </tr>
                                <tr>
                                	<td class="td-h">주소</td>
                                	<td class="td-b td-tl">${userVO.logistMngVO.logistMngAddr} ${userVO.logistMngVO.logistMngDetAddr}</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="table-section">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th colspan="2">담당자 정보</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                            	<td class="td-h">담당자명</td>
                            	<td class="td-b td-tl">${userVO.userName}</td>
                            </tr>
                            <tr>
                                <td class="td-h">핸드폰번호</td>
                                <td class="td-b td-tl"> ${userVO.userTel}
                                    <span class="ynSpan">/ SMS 수신: </span>
                                    <input type="checkbox" disabled ${userVO.smsYn ? 'checked' : ''} />
                                </td>
                            </tr>
                            <tr>
                                <td class="td-h">이메일</td>
                                <td class="td-b td-tl"> ${userVO.userEmail}
                                	<span class="ynSpan">/ 이메일 수신 : </span>
                                    <input type="checkbox" disabled ${userVO.emailYn ? 'checked' : ''} />
                                </td>
                            </tr>
                            <tr>
                            	<td class="td-h">팩스 (선택)</td>
                            	<td class="td-b td-tl">${userVO.userFax}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="btn-container">
				    <button type="button" class="btn btn-primary btn-c" id="modifyBtn">수정</button>
				    <button type="button" class="btn btn-secondary btn-c" onclick="location.href='<c:url value='/servant/userMng.do' />'">목록</button>
				</div>
            </div>
        </main>
    </div>
</body>
<script type="text/javascript">
$(function(){
let modifyBtn = $("#modifyBtn");
	
	modifyBtn.on("click", function(){
		window.location.href = "/servant/userMngForm.do?userNo=" + ${userVO.userNo};
	});
});
    
</script>
</html>