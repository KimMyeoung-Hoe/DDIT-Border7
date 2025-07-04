<%@page import="kr.or.ddit.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용자 정보 수정 페이지</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<style type="text/css">
/* myInfo.jsp 스타일 적용 */
.table-section { margin: 0px auto 15px; }
.td-h { min-width: 180px; max-width: 180px; font-weight: bold; background-color: #f8f9fa; }
.td-b { width: 100%; }
.td-p { min-width: 200px; height: 200px; position: relative; }
.profileImg { width: 200px; height: 200px; border-radius: 50%; object-fit: cover; }
.profileBtn { width: 45px; height: 45px; border: none; border-radius: 50%; background-color: #f5f7fa; box-shadow: 0 0 10px 5px rgba(0, 0, 0, 0.3); position: absolute; right: 20px; bottom: 20px; z-index: 1; cursor: pointer; }
.ynSpan { vertical-align: middle; margin-left: 5px; }
.btn-container { text-align: right; margin-top: 20px; }
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
                        <li class="breadcrumb-item"><a href="#">일반이용자 정보수정</a></li>
                     </ol>
                  </div>
               </div>
               <div class="content-title">이용자 정보 수정</div>
               <p class="desc">선택한 이용자의 정보를 수정합니다.</p>
            </div>
            
            <div class="section">
                <form id="userEditForm" method="post" action="/servant/userMngUpdate.do" enctype="multipart/form-data">
                    <input type="hidden" name="userNo" value="${userVO.userNo}" />
                    <input type="hidden" name="authCode" value="${userVO.authCode}" />

                    <div class="table-section">
                        <table class="data-table">
                            <thead>
                                <tr><th colspan="4">계정 정보</th></tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="td-p" rowspan="6">
                                        <button type="button" class="profileBtn" title="프로필 이미지 수정">
                                        	<i class="img-update fas fa-pencil-alt"></i>
                                        </button>
                                        <c:set var="profilePath" value="/img/default_profile.png" />
										<c:if test="${userVO.authCode eq 'ROLE_CONSIGNOR' and not empty userVO.consignorVO.consignorProfileImg}">
										    <%-- ▼▼▼ src 경로를 /servant/displayProfileImage로 수정 ▼▼▼ --%>
										    <c:set var="profilePath" value="/servant/displayProfileImage?fileName=${userVO.consignorVO.consignorProfileImg}"/>
										</c:if>
										                                        	
										<c:if test="${userVO.authCode eq 'ROLE_CCA' and not empty userVO.ccaVO.ccaProfileImg}">
										    <c:set var="profilePath" value="/servant/displayProfileImage?fileName=${userVO.ccaVO.ccaProfileImg}"/>
										</c:if>
										                                        	
										<c:if test="${userVO.authCode eq 'ROLE_LOGISTICS' and not empty userVO.logistMngVO.logistMngProfileImg}">
										    <c:set var="profilePath" value="/servant/displayProfileImage?fileName=${userVO.logistMngVO.logistMngProfileImg}"/>
										</c:if>
										                                        	
										<img class="profileImg" src="${profilePath}" alt="프로필 사진" />
										<input type="file" name="profileImageFile" id="hiddenProfileFileInput" accept="image/*" style="display: none;" />
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
                                	<td class="td-h">가입일자</td>
                                	<td class="td-b td-tl"><fmt:formatDate value="${userVO.regDate}" pattern="yyyy-MM-dd" /></td>
                                	<%-- <td class="td-b"><input type="text" class="form-control" value="<fmt:formatDate value="${userVO.regDate}" pattern="yyyy-MM-dd" />" readonly/></td> --%>
                                </tr>
                                <c:if test="${not empty userVO.withdrawDate }">
                                <tr>
                                	<td class="td-h">탈퇴일자</td>
                                	<td class="td-b td-tl"><fmt:formatDate value="${userVO.withdrawDate}" pattern="yyyy-MM-dd" /></td>
                                	<%-- <td class="td-b"><input type="text" class="form-control" value="<fmt:formatDate value="${userVO.withdrawDate}" pattern="yyyy-MM-dd" />" readonly/></td> --%>
                                </tr>
                                </c:if>
                                <tr>
                                    <td class="td-h">계정 상태</td>
                                    <td class="td-b td-tl">
                                        <select name="userStatus" class="form-select" style="width:120px;">
                                            <option value="false" ${!userVO.userStatus ? 'selected' : ''}>활성</option>
                                            <option value="true" ${userVO.userStatus ? 'selected' : ''}>비활성</option>
                                        </select>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="table-section">
                        <table class="data-table">
                            <thead>
                                <tr><th colspan="2">업체 정보</th></tr>
                            </thead>
                            <tbody>
                                <c:if test="${userVO.authCode eq 'ROLE_CONSIGNOR'}">
                                    <tr>
                                    	<td class="td-h">통관번호</td>
                                    	<td class="td-b td-tl"><input type="text" name="consignorVO.consignorCustomsCode" class="form-control" value="${userVO.consignorVO.consignorCustomsCode}"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="td-h">사업자명</td>
                                    		<td class="td-b td-tl"><input type="text" name="consignorVO.consignorName" class="form-control" value="${userVO.consignorVO.consignorName}"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="td-h">사업자번호</td>
                                    	<td class="td-b td-tl"><input type="text" name="consignorVO.businessNumber" class="form-control" value="${userVO.consignorVO.businessNumber}"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="td-h">전화번호</td>
                                    	<td class="td-b td-tl"><input type="text" name="consignorVO.consignorTel" class="form-control" value="${userVO.consignorVO.consignorTel}"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="td-h">주소</td>
                                    	<td class="td-b td-tl"><input type="text" name="consignorVO.consignorAddr" class="form-control" value="${userVO.consignorVO.consignorAddr} ${userVO.consignorVO.consignorDetAddr}"/></td>
                                    </tr>
                                </c:if>
                                
                                <c:if test="${userVO.authCode eq 'ROLE_CCA'}">
                                    <tr>
                                    	<td class="td-h">관세사명</td>
                                    	<td class="td-b td-tl"><input type="text" name="ccaVO.ccaName" class="form-control" value="${userVO.ccaVO.ccaName}"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="td-h">관세사등록번호</td>
                                    	<td class="td-b td-tl"><input type="text" name="ccaVO.ccaRegistrationNumber" class="form-control" value="${userVO.ccaVO.ccaRegistrationNumber}"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="td-h">전화번호</td>
                                    	<td class="td-b td-tl"><input type="text" name="ccaVO.ccaTel" class="form-control" value="${userVO.ccaVO.ccaTel}"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="td-h">주소</td>
                                    	<td class="td-b td-tl"><input type="text" name="ccaVO.ccaAddr" class="form-control" value="${userVO.ccaVO.ccaAddr} ${userVO.ccaVO.ccaDetAddr}"/></td>
                                    </tr>
                                    <tr>
									    <td class="td-h">주력분야</td>
									    <td class="td-b td-tl" style="text-align: left;">
									        <input type="checkbox" name="ccaVO.ccaSpecialtyCodeList" value="1" ${specialtyCheckedMap.specialty1 ? 'checked' : ''} />수출입신고<br/>
									        <input type="checkbox" name="ccaVO.ccaSpecialtyCodeList" value="2" ${specialtyCheckedMap.specialty2 ? 'checked' : ''} />FTA<br/>
									        <input type="checkbox" name="ccaVO.ccaSpecialtyCodeList" value="3" ${specialtyCheckedMap.specialty3 ? 'checked' : ''} />관세환급<br/>
									        <input type="checkbox" name="ccaVO.ccaSpecialtyCodeList" value="4" ${specialtyCheckedMap.specialty4 ? 'checked' : ''} />품목분류(HS CODE 분류)<br/>
									        <input type="checkbox" name="ccaVO.ccaSpecialtyCodeList" value="5" ${specialtyCheckedMap.specialty5 ? 'checked' : ''} />관세평가<br/>
									        <input type="checkbox" name="ccaVO.ccaSpecialtyCodeList" value="6" ${specialtyCheckedMap.specialty6 ? 'checked' : ''} />관세조사 대응<br/>
									        <input type="checkbox" name="ccaVO.ccaSpecialtyCodeList" value="7" ${specialtyCheckedMap.specialty7 ? 'checked' : ''} />관세/무역 컨설팅<br/>
									    </td>
									</tr>
                                </c:if>
                                
                                <c:if test="${userVO.authCode eq 'ROLE_LOGISTICS'}">
                                    <tr>
                                    	<td class="td-h">사업자명</td>
                                    	<td class="td-b"><input type="text" name="logistMngVO.logistMngName" class="form-control" value="${userVO.logistMngVO.logistMngName}"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="td-h">사업자번호</td>
                                    	<td class="td-b"><input type="text" name="logistMngVO.businessNumber" class="form-control" value="${userVO.logistMngVO.businessNumber}"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="td-h">전화번호</td>
                                    	<td class="td-b"><input type="text" name="logistMngVO.logistMngTel" class="form-control" value="${userVO.logistMngVO.logistMngTel}"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="td-h">주소</td>
                                    	<td class="td-b"><input type="text" name="logistMngVO.logistMngAddr" class="form-control" value="${userVO.logistMngVO.logistMngAddr} ${userVO.logistMngVO.logistMngDetAddr}"/></td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <div class="table-section">
                        <table class="data-table">
                            <thead>
                                <tr><th colspan="2">담당자 정보</th></tr>
                            </thead>
                            <tbody>
                            	<tr>
	                                <td class="td-h">담당자명</td>
	                                <td class="td-b td-tl">${userVO.userName}</td>
                                	<%-- <td class="td-b"><input type="text" class="form-control" value="${userVO.userName}" readonly/></td> --%>
                                </tr>
                                <tr>
                                	<td class="td-h">핸드폰번호</td>
                                    <td class="td-b td-tl">
	                                    <input type="text" name="userTel" class="form-control" value="${userVO.userTel}" />
	                                    	<span class="ynSpan">SMS 수신</span>
	                                    <input type="checkbox" name="smsYn" value="true" ${userVO.smsYn ? 'checked' : ''} />
                                    </td>
                                </tr>
                                <tr>
                                	<td class="td-h">이메일</td>
                                    <td class="td-b td-tl">
                                        <input type="email" name="userEmail" class="form-control" value="${userVO.userEmail}" />
                                        	<span class="ynSpan">이메일 수신</span>
                                        <input type="checkbox" name="emailYn" value="true" ${userVO.emailYn ? 'checked' : ''} />
                                    </td>
                                </tr>
                                <tr>
                                	<td class="td-h">팩스 (선택)</td>
                                	<td class="td-b td-tl"><input type="text" name="userFax" class="form-control" value="${userVO.userFax}" /></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="btn-container">
                        <button type="button" class="btn btn-primary btn-c" id="saveBtn">수정</button>
                        <button type="button" class="btn btn-secondary btn-c" id="cancelBtn">취소</button>
                    </div>
                </form>
            </div>
        </main>
	</div>
</body>
<script type="text/javascript">
$(function(){
	// 프로필 이미지 변경 로직
	$('.profileBtn').on('click', function () {
		$('#hiddenProfileFileInput').click();
	});
	
	$('#hiddenProfileFileInput').on('change', function(event) {
    	let file = event.target.files[0];
    	if (file && file.type.startsWith('image/')) {
        	let reader = new FileReader();
          	reader.onload = function(e) {
				$('.profileImg').attr('src', e.target.result);
			}
			reader.readAsDataURL(file);
    	} else {
    		alertify.alert('이미지 파일만 선택 가능합니다.');
		}
    });

	// 수정 버튼 클릭
	$("#saveBtn").on("click", function(){
	    if(confirm("수정된 내용을 저장하시겠습니까?")) {
	        // smsYn 체크박스
	        if (!$('input[name="smsYn"]').is(':checked')) {
	            // 'false' 값을 추가하여 전송
	            $('<input>').attr({
	                type: 'hidden',
	                name: 'smsYn',
	                value: 'false'
	            }).appendTo('#userEditForm');
	        }
	        
	        // emailYn 체크박스
	        if (!$('input[name="emailYn"]').is(':checked')) {
            	// 'false' 값을 추가하여 전송
	            $('<input>').attr({
	                type: 'hidden',
	                name: 'emailYn',
	                value: 'false'
	            }).appendTo('#userEditForm');
	        }
	        $("#userEditForm").submit();
	        
	    }
	});

	// 취소 버튼 클릭
	$("#cancelBtn").on("click", function(){
		if(confirm("수정을 취소하고 상세 페이지로 돌아가시겠습니까?")) {
			location.href = '/servant/userMngDetail.do?userNo=' + ${userVO.userNo};
		}
	});
});
</script>
</html>