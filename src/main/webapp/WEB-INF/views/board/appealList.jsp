<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>민원사항 게시판</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<sec:authentication property="principal" var="princ"/>
<c:set value="${princ.user }" var="userVO"></c:set>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>

<style>
.appeal-answer-row {
    display: none; /* 초기에는 숨김 */
    background-color: #f9f9f9; /* 답변 영역 배경색 */
    border-top: 1px solid #ddd;
}
.appeal-answer-content {
    padding: 15px;
}
.appeal-answer-file-list {
    margin-top: 10px;
    font-size: 0.9em;
    color: #555;
}
.appeal-answer-file-list a {
    display: block; /* 파일 목록을 블록 레벨로 표시 */
    margin-bottom: 5px;
}
/* 클릭 가능한 제목에 마우스 오버 시 커서 변경 */
.appeal-title-link {
    cursor: pointer;
    text-decoration: none; /* 기본 밑줄 제거 */
    color: #007bff; /* 링크 색상 */
}
.appeal-title-link:hover {
    text-decoration: underline; /* 호버 시 밑줄 */
}
/* 답변 없는 제목 텍스트 스타일 */
.appeal-title-text {
    color: #333; /* 일반 텍스트 색상 */
    cursor: default; /* 기본 커서 모양 */
}

/* 추가된 CSS: 내용 자르기 및 더보기 버튼 관련 */
.appeal-content-cell {
    max-width: 250px; /* 내용 컬럼의 최대 너비 설정 */
    white-space: normal; /* 기본 줄바꿈 허용 */
    word-wrap: break-word; /* 긴 단어 강제 줄바꿈 */
}
.full-content {
    display: none; /* 초기에는 전체 내용 숨김 */
}
.toggle-content-btn {
    display: inline-block; /* 버튼 형태로 표시 */
    margin-left: 5px;
    color: #007bff;
    cursor: pointer;
    text-decoration: underline;
    font-size: 0.9em;
}
.toggle-content-btn:hover {
    color: #0056b3;
}
.pagination .page-link {
  border-radius: 999px !important;
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
                    <li class="breadcrumb-item"><a href="/board/appealList.do">민원</a></li>
                 </ol>
              </div>
           </div>
        <div class="content-title">민원</div>
           <p class="desc" style="font-size: small;"> <br/>각 민원 제목을 클릭하면 상세페이지로 이동됩니다</p>
        </div>
        <div class="section">
            <div class="support-tabs">
                <div class="tab-item " data-tab="notice">
                    <i class="fas fa-bullhorn tab-icon"></i><span id="goNoticeBtn"> 공지사항</span>
                </div>
                <div class="tab-item" data-tab="faq">
                    <i class="fas fa-question-circle tab-icon"></i><span id="goFaqBtn">자주 찾는 질문 (FAQ)</span> 
                </div>
                <div class="tab-item active" data-tab="appeal">
                    <i class="fas fa-bullhorn tab-icon"></i> <span id="goAppeal">민원</span>
                </div>
            </div>    
        
            <div class="search-filter-section">
                <div class="filter-group">
                    <select class="form-select" id="searchType" >
                      <option>
                         검색 타입선택
                     </option>
                     <option value="APPEAL_TITLE" <c:if test="${searchType == 'APPEAL_TITLE'}">selected</c:if>>
                        민원 제목
                     </option>
                     <option value="APPEAL_TYPE" <c:if test="${searchType == 'APPEAL_TYPE'}">selected</c:if>>
                        민원 분류
                     </option>
                  </select>
                </div>
               <div class="search-input-wrapper">
                  <div class="search-input-icon"></div>
                  <input type="text" class="form-input search-input" value="${searchWord }" placeholder="제목,분류 검색">
               </div>
               <div class="filter-group">
                  
                  <select class="form-select" id="sortColumn1">
                     <option>
                         순서 정렬
                     </option> 
                     <option value="APPEAL_REG_DATE" <c:if test="${fn:startsWith(sortColumn, 'APPEAL_REG_DATE')}">selected</c:if>>
                        민원 작성 일시
                     </option>
                     <option value="APPEAL_ANSWER" <c:if test="${fn:startsWith(sortColumn, 'APPEAL_ANSWER')}">selected</c:if>>
                        답변 여부
                     </option>
                  </select>
                  <select class="form-select" id="sortColumn2">
                     <option>
                         정렬 방향
                     </option>
                     <option value="DESC" <c:if test="${fn:endsWith(sortColumn, 'DESC')}">selected</c:if>>
                        내림차순 정렬
                     </option>
                     <option value="ASC" <c:if test="${fn:endsWith(sortColumn, 'ASC')}">selected</c:if>>
                        오름차순 정렬
                     </option>
                  </select>
                  <button class="btn btn-primary" id="searchBtn">검색</button>
               </div>
            </div>

            <div class="table-section">
                <table class="data-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>민원 제목</th>
                        <th>민원 분류</th>
                        <th>민원 내용</th>
                        <th>민원 작성일시</th>
                        <th>답변 여부</th>
                        <th>내 첨부파일 여부</th>
                        <c:choose>
                        	<c:when test="">
                        		 <th>삭제</th>
                        	</c:when>
                        	<c:otherwise>
                        		<th>답변</th>
                        	</c:otherwise>
                        </c:choose>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty appealList}">
                    <tr>
                        <td colspan="7" style="text-align: center;">민원 신청 내역이 없습니다.</td>
                    </tr>
                    </c:if>
                    <c:if test="${not empty appealList }">
                        <c:forEach items="${appealList }" var="appeal" varStatus="vs">
                            <tr class="appeal-row" data-appeal-no="${appeal.appealNo}">
                                <td>${vs.count }</td>
								<td>
								    <c:if test="${not empty appeal.appealAnswer}">
								        <a href="#" class="appeal-title-link" data-appeal-no="${appeal.appealNo}">
								            ${appeal.appealTitle}
								        </a>
								    </c:if>
								    <c:if test="${empty appeal.appealAnswer}">
								        <span class="appeal-title-text">${appeal.appealTitle}</span>
								    </c:if>
								</td>
                                <td>${appeal.appealType }</td>
                                <td class="appeal-content-cell">
                                    <c:set var="maxLength" value="20" />
                                    <c:set var="contentLength" value="${fn:length(appeal.appealContent)}" />
                                    
                                    <c:if test="${contentLength > maxLength}">
                                        <span class="truncated-content" >${fn:substring(appeal.appealContent, 0, maxLength)}...</span>
                                        <span class="full-content" style="display:none;">${appeal.appealContent}</span>
                                        <a href="#" class="toggle-content-btn" data-state="truncated">더보기</a>
                                    </c:if>
                                    <c:if test="${contentLength <= maxLength}">
                                        <span>${appeal.appealContent}</span>
                                    </c:if>
                                </td>
                                <td>${appeal.appealRegDate }</td>
                                <td>
                                    <c:if test="${empty appeal.appealAnswer }">
                                        없음
                                    </c:if>
                                    <c:if test="${not empty appeal.appealAnswer }">
                                        있음
                                    </c:if>
                                </td>
								<c:if test="${appeal.appealAttch != 0}">
								    <td>
								        <a href="#" class="fileDetail"
								           data-appeal-no="${appeal.appealNo}"
								           <c:forEach items="${appeal.appealFileList }" var="file" varStatus="vs">
								               data-file-${vs.index}-save-path="${fn:escapeXml(file.comFileDetailSaveName)}"
								               data-file-${vs.index}-original-name="${fn:escapeXml(file.comFileDetailOriginalName)}"
								           </c:forEach>
								           data-file-count="${fn:length(appeal.appealFileList)}"
								        >있음</a>
								    </td>
								</c:if>
								<c:if test="${appeal.appealAttch == 0 }">
								    <td>없음</td>
								</c:if>
                                <td>
                                <c:choose>
		                        	<c:when test="${fn:startsWith(userVO.authCode,'ROLE_SVT') && empty appeal.appealAnswer}">
		                        		 <button class="btn btn-primary" id="appealAnswerBtn_${vs.index}" data-appeal-no="${appeal.appealNo}">민원 답변하기</button>
		                        	</c:when>
		                        	<c:otherwise>
		                        		<c:if test="${empty appeal.appealAnswer}">
                                		<button class="btn btn-secondary delete-appeal-btn" data-appeal-no="${appeal.appealNo}">민원 삭제하기</button> <%-- ID가 아닌 클래스를 사용해야 합니다. --%>
                                	</c:if>
                                	<c:if test="${not empty appeal.appealAnswer}">
                                		<span>삭제불가</span>
                                	</c:if>
		                        	</c:otherwise>
		                        </c:choose>
                                </td>
                            </tr>
                            <tr class="appeal-answer-row" id="answer-row-${appeal.appealNo}">
                                <td colspan="1">${vs.count }</td>
                                <td colspan="1"><strong>[답변]</strong></td>
                                <td colspan="6">
                                
                                    <div class="appeal-answer-content"">
                                    <%-- <c:out value="${appeal }"></c:out> --%>
                                        <c:if test="${not empty appeal.appealAnswer }">
                                        	<c:if test="${not empty appeal.answerFileList}">
                                                <div class="appeal-answer-file-list">
                                                    <strong>첨부 답변 파일:</strong><br/>
                                                    <c:forEach items="${appeal.answerFileList }" var="answerFile">
                                                        <a href="/upload/appeal_answer/${answerFile.comFileDetailSaveName}" download>${answerFile.comFileDetailOriginalName }</a>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                        	<div style="display: flex; justify-content: space-between; align-items: center;">
											    ${appeal.appealAnswer } 
											    <small>답변일: <fmt:formatDate value="${appeal.appealAnswerDate}" pattern="yyyy-MM-dd HH:mm"/></small>
											</div>
                                        </c:if>
                                        <c:if test="${empty appeal.appealAnswer }">
                                            <p>아직 답변이 등록되지 않았습니다.</p>
                                        </c:if>
                                    </div>
                                    
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>
            </div>
            <div class="table-footer">
                    <div class="d-flex justify-content-center mt-4">
                        <ul class="pagination">
                            <c:if test="${paginationInfo.startPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="#" data-page="${paginationInfo.startPage - paginationInfo.blockSize}">이전</a>
                                </li>
                            </c:if>
                        
                            <c:forEach var="i" begin="${paginationInfo.startPage}" end="${paginationInfo.totalPage}">
                                <li class="page-item ${i == paginationInfo.currentPage ? 'active' : ''}">
                                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                                </li>
                            </c:forEach>
                        
                            <c:if test="${paginationInfo.endPage < paginationInfo.totalPage}">
                                <li class="page-item">
                                    <a class="page-link" href="#" data-page="${paginationInfo.endPage + 1}">다음</a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                    
                    <c:if test="${not fn:startsWith(userVO.authCode,'ROLE_SVT')}">
                        <div class="header-action-buttons">
                            <button class="action-button primary small-button" id="addBtn">새 민원 등록</button>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
    </div>
    
<div class="modal fade" id="appealModal" tabindex="-1" aria-labelledby="appealModalLabel" >
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="appealModalLabel">민원사항 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <form id="appealForm" enctype="multipart/form-data">
          <div class="mb-3">
            <label for="appealTitle" class="form-label">제목</label>
            <input type="text" class="form-control" id="appealTitle" name="appealTitle" placeholder="제목을 입력하세요" required>
          </div>

          <div class="mb-3">
            <label for="appealType" class="form-label">민원 종류</label>
            <select class="form-select" id="appealType" name="appealType" required>
              <option value="">종류 선택</option>
              <option value="불편사항">불편사항</option>
              <option value="건의사항">건의사항</option>
              <option value="기타">기타</option>
            </select>
          </div>

          <div class="mb-3">
            <label for="appealContent" class="form-label">내용</label>
            <textarea class="form-control" id="appealContent" name="appealContent" rows="4" placeholder="내용을 입력하세요" required></textarea>
          </div>
          
          <div class="mb-3">
            <label for="appealContent" class="form-label">관세대리업무 계약번호</label>
            <input type="text" class="form-control" id="declno" name="declno" placeholder="만약 업무관련이라면 작성해주세요">
          </div>

          <div class="mb-3">
            <label for="appealFile" class="form-label">첨부파일</label>
            <input class="form-control" type="file" id="appealFiles" name="appealFiles" multiple="multiple">
            <div id="selectedFilesDisplay" class="mt-2 text-muted small"></div>
          </div>
          <div>
            
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="submit" class="btn btn-primary" id="submitAppealBtn">등록</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="answerModal" tabindex="-1" aria-labelledby="answerModalLabel" >
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title" id="appealModalLabel">민원 답변 등록</h5>
			</div>
			<div class="modal-body">
				<div class="mb-3">
					<label for="appealTitle" class="form-label">제목</label>
					<input type="text" id="modalAppealTitle" class="form-control" readonly>
				</div>
				<div class="mb-3">
					<label for="appealType" class="form-label">민원 종류</label>
					<input type="text" id="modalAppealType" class="form-control" readonly>
				</div>
				<div class="mb-3">
					<label for="appealContent" class="form-label">내용</label>
					<textarea id="modalAppealContent" class="form-control" readonly></textarea>
				</div>
			</div>
			<div class="modal-body">
				<div class="mb-3">
				  <label for="appealTitle" class="form-label">답변</label>
				  <textarea id="appealAnswer" rows="10" cols="51" placeholder="답변을 입력하세요"></textarea>
				</div>
			</div>
			<div class="mb-3">
				<label for="appealFile" class="form-label">첨부파일</label>
				<input class="form-control" type="file" id="appealAnswerFiles" name="appealAnswerFiles" multiple="multiple">
				<div id="selectedAnswerFilesDisplay" class="mt-2 text-muted small">
				
				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-primary" id="submitAppealAnserBtn">등록</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="fileModal" tabindex="-1" aria-labelledby="fileModalLabel">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title" id="fileModalLabel">첨부 파일 목록</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
			</div>
			<div class="modal-body">
				<div id="fileListContainer" class="list-group">
					</div>
                <p id="noFilesMessage" style="display:none; text-align: center; margin-top: 20px; color: #6c757d;">첨부된 파일이 없습니다.</p>
			</div>
			<div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
		</div>
	</div>
</div>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>

<script type="text/javascript">
$(function(){
    // AlertifyJS 기본 설정 (옵션)
    alertify.defaults.glossary.title = '알림';
    alertify.defaults.glossary.ok = '확인';
    alertify.defaults.glossary.cancel = '취소';
    alertify.defaults.notifier.delay = 3; // 알림 유지 시간 (초)
    alertify.defaults.closable = true; // 닫기 버튼 표시

    var goFaqBtn = $("#goFaqBtn");
    var goNoticeBtn = $("#goNoticeBtn");
    var goAppeal = $("#goAppeal");
    var addBtn = $("#addBtn");
    var submitAppealBtn = $('#submitAppealBtn');
    var appealFilesInput = $('#appealFiles');
    var appealAnswerFiles = $('#appealAnswerFiles');
    var selectedFilesDisplay = $('#selectedFilesDisplay');
    var selectedAnswerFilesDisplay = $('#selectedAnswerFilesDisplay');

    goNoticeBtn.on("click",function(){
        window.location.href="/board/noticeList.do";
    });
    goFaqBtn.on("click",function(){
        window.location.href="/board/faqList.do";
    });
//--------------------------------------------------------------------------
// 민원 답변 모달 출력 이벤트
$("[id^='appealAnswerBtn']").on('click', function() {
    let appealNo = $(this).data("appealNo");
    let thisRow = $(this).closest("tr");
    
    // appealNo 값 저장
    $("#submitAppealAnserBtn").data("appealNo", appealNo);
    // 각 셀에서 필요한 값 추출
    let appealTitle = thisRow.find(".appeal-title-link, .appeal-title-text").text().trim();
    let appealType = thisRow.find("td").eq(2).text().trim();
    let appealContent = thisRow.find(".full-content").text().trim();
	 if (!appealContent) {
	     appealContent = thisRow.find(".appeal-content-cell span").first().text().trim();
	 }
	 
    // 모달 input 요소에 값 세팅
    $("#modalAppealTitle").val(appealTitle);
    $("#modalAppealType").val(appealType);
    $("#modalAppealContent").val(appealContent); 
    
    // 모달 열기
    let answerModal = new bootstrap.Modal(document.getElementById('answerModal'));
    answerModal.show();
    
});
	//--------------------------------------------------------------------------
	// 민원 답변 등록 이벤트
	$("#submitAppealAnserBtn").on('click',function() {
		// FormData 객체 생성
    	const formData = new FormData();

    	// textarea 값 추가
    	const answerText = $("#appealAnswer").val().trim();
    	formData.append("appealAnswer", answerText);

    	// 첨부된 파일들 추가
    	const files = $("#appealAnswerFiles")[0].files;
    	for (let i = 0; i < files.length; i++) {
       	 formData.append("appealAnswerFiles", files[i]);
    	}  
		const appealNo = $("#submitAppealAnserBtn").data("appealNo");
		formData.append("appealNo", appealNo);

		$.ajax({
			url : "<%=request.getContextPath()%>/board/answerAppeal.do",
			type: "POST",
        	data: formData,
        	processData: false,
        	contentType: false,
			success : function (res) {
            	if (res > 0) {
                	location.reload();
            	} 
        	},
        	error: function (xhr, status, error) {
            	console.error("등록 실패 오류:", error);
            	alertify.alert("답변 등록 중 오류가 발생했습니다. 다시 시도해주세요.");
       		}
    	});
	})
//--------------------------------------------------------------------------
//새민원등록버튼 이벤트
    addBtn.on("click",function(){
        $('#appealForm')[0].reset();
        selectedFilesDisplay.empty();
        $("#appealModal").modal("show");
    });
//--------------------------------------------------------------------------
// 파일 선택 시 파일 이름 표시
    appealFilesInput.on('change', function() {
        selectedFilesDisplay.empty(); 
        var files = this.files;
        if (files.length > 0) {
            for (var i = 0; i < files.length; i++) {
                selectedFilesDisplay.append('<div class="file-name">' + files[i].name + '</div>');
            }
        } else {
            selectedFilesDisplay.append('<div>선택된 파일 없음</div>');
        }
    });
//--------------------------------------------------------------------------
// 파일 상세 모달 출력 이벤트 (List에서 하나씩 꺼내 넘겨주는 방식)
$(document).on("click", ".fileDetail", function(e){
    e.preventDefault();

    const $fileListContainer = $('#fileListContainer');
    const $noFilesMessage = $('#noFilesMessage');

    $fileListContainer.empty();
    $noFilesMessage.hide();

    // JSP에서 추가된 data-file-count 속성을 사용하여 파일 개수를 가져옵니다.
    const fileCount = $(this).data("file-count");
  
    let files = [];

    if (fileCount > 0) {
        for (let i = 0; i < fileCount; i++) {
            // 인덱스를 사용하여 각 파일의 save-path와 original-name을 가져옵니다.
            const savePath = $(this).data(`file-\${i}-save-path`);
            const originalName = $(this).data(`file-\${i}-original-name`);

            // null 또는 undefined 체크를 추가하여 데이터가 없는 경우를 방지합니다.
            if (savePath && originalName) {
                files.push({
                    savePath: savePath,       // JavaScript 객체 속성명은 일관되게 camelCase로
                    originalName: originalName
                });
            }
        }
    }

    if (files.length > 0) {
        files.forEach(function(file) {
            const fileLink = `
                <a href="/upload/appeal/${file.savePath}" download class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                    \${file.originalName}
                    <i class="fas fa-download ms-auto"></i>
                </a>
            `;
            \$fileListContainer.append(fileLink);
        });
    } else {
        $noFilesMessage.show(); // 파일이 없는 경우 메시지 표시
    }

    const fileModal = new bootstrap.Modal(document.getElementById('fileModal'));
    fileModal.show();
});

//--------------------------------------------------------------------------
// 답변 시 파일 선택 시 파일 이름 표시
    appealAnswerFiles.on('change', function() {
    	selectedAnswerFilesDisplay.empty(); 
        var files = this.files;
        if (files.length > 0) {
            for (var i = 0; i < files.length; i++) {
            	selectedAnswerFilesDisplay.append('<div class="file-name">' + files[i].name + '</div>');
            }
        } else {
        	selectedAnswerFilesDisplay.append('<div>선택된 파일 없음</div>');
        }
    });
    
//--------------------------------------------------------------------------    
// 등록버튼 이벤트 (jQuery Confirm 적용)
	submitAppealBtn.on('click', function () {
	    // 파일 입력 필드 처리 (빈 파일 필드 제거)
	    document.querySelectorAll('input[type="file"]').forEach(input => {
	        if (!input.files || input.files.length === 0 || input.files[0].size === 0) {
	            input.remove();
	        }
	    });
	
	    $.confirm({
	        title: '민원 등록 확인',
	        content: '민원사항은 한 번 등록하면 수정할 수 없습니다.<br>계속 진행하시겠습니까?',
	        buttons: {
	            confirm: {
	                text: '등록하기',
	                btnClass: 'btn-primary',
	                action: function () {
	                    const form = $('#appealForm')[0];
	                    const formData = new FormData(form);
	                    const userNo = `${userVO.userNo}`;
	                    formData.append("userNo", userNo);
	
	                    $.ajax({
	                        url: "<%=request.getContextPath()%>/board/registAppeal.do",
	                        type: "POST",
	                        data: formData,
	                        processData: false,
	                        contentType: false,
	                        dataType: "text",
	                        success: function (cnt) {
	                            if (cnt > 0) {
	                                alertify.success("민원 등록 성공!"); // AlertifyJS success
	                                $('#appealModal').modal('hide'); // 모달 닫기
	                                location.reload(); // 페이지 새로고침
	                            } else {
	                                alertify.error("민원 등록 실패!"); // AlertifyJS error
	                            }
	                        },
	                        error: function (xhr, status, error) {
	                            console.error("등록 실패 오류:", error);
	                            alertify.error("민원 등록 중 오류가 발생했습니다. 다시 시도해주세요."); // AlertifyJS error
	                        }
	                    });
	                }
	            },
	            cancel: {
	                text: '취소',
	                btnClass: 'btn-danger',
	                action: function () {
	                    alertify.error('민원 작성을 취소했습니다.'); // AlertifyJS error
	                }
	            }
	        }
	    });
	});

//--------------------------------------------------------------------------
// 민원 제목 클릭 시 아코디언 토글 이벤트
    $(document).on("click", ".appeal-title-link", function(e){
        e.preventDefault(); 

        var appealNo = $(this).data("appeal-no"); 
        var $answerRow = $("#answer-row-" + appealNo); 
        
        $(".appeal-answer-row").not($answerRow).slideUp(); 
        $answerRow.slideToggle("fast");
    });
    
//--------------------------------------------------------------------------
// 민원 내용 "더보기/간략히" 토글 이벤트
    $(document).on("click", ".toggle-content-btn", function(e){
        e.preventDefault();
        var $cell = $(this).closest('.appeal-content-cell');
        var $truncated = $cell.find('.truncated-content');
        var $full = $cell.find('.full-content');
        var $btn = $(this);

        if ($btn.data('state') === 'truncated') {
            $truncated.hide();
            $full.show();
            $btn.text('간략히');
            $btn.data('state', 'full');
        } else {
            $full.hide();
            $truncated.show();
            $btn.text('더보기');
            $btn.data('state', 'truncated');
        }
    });
//------------------------------------------------------------
// 삭제버튼 클릭이벤트 (class 셀렉터 사용 및 data-appeal-no 활용)
	$(document).on("click", ".delete-appeal-btn", function(){ // ID가 아닌 클래스 셀렉터를 사용하고, 동적 요소에도 적용되도록 document에 바인딩
		var appealNo = $(this).data("appealNo"); // 클릭된 버튼의 data-appeal-no 가져오기
		
		$.confirm({
			title: '삭제 확인',
			content: '정말로 삭제하시겠습니까?',
			buttons: {
				confirm: {
					text: '삭제하기',
					btnClass: 'btn-danger',
					action: function () {
						$.ajax({
							url: "<%=request.getContextPath()%>/board/deleteAppeal.do",
							type: "POST",
							data: {
								appealNo : appealNo // 가져온 appealNo 사용
							},
							dataType: "text",
							success: function (cnt) {
								if (cnt > 0) {
									alertify.success("민원 삭제 성공!"); // AlertifyJS success
									location.reload(); // 페이지 새로고침
								} else {
									alertify.error("민원 삭제 실패!"); // AlertifyJS error
								}
							},
							error: function (xhr, status, error) {
								console.error("삭제 실패 오류:", error);
								alertify.error("민원 삭제 중 오류가 발생했습니다. 다시 시도해주세요."); // AlertifyJS error
							}
						});
					}
				},
				cancel: {
					text: '취소',
					btnClass: 'btn-primary',
					action: function () {
						alertify.error('민원 삭제를 취소했습니다.'); // AlertifyJS error
					}
				}
			}
		});
	});
//---------------------------------------------------------------------------
	// 페이지 이동 이벤트
	$(".pagination .page-link").click(function (e) {
	    e.preventDefault();

	    var currentPage = $(this).attr("data-page");
	    var contextPath = "<%=request.getContextPath()%>";
	    var url = new URL(window.location.href);

	    // 기존 currentPage 파라미터 제거
	    url.searchParams.delete("currentPage");

	    // 새로운 currentPage 파라미터 추가
	    url.searchParams.append("currentPage", currentPage);

	    window.location.href = contextPath + "/board/appealList.do" + url.search;
	});
	
	
});
</script>
</html>