<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 작성</title>
<%@ include file="../modules/header.jsp" %>
<%@ include file="../modules/sidebar.jsp" %>
<link rel="stylesheet" href="/css/main.css">
<style type="text/css">
     .badge-container {
            margin-top: 15px;
            border: 1px solid #dee2e6;
            padding: 10px;
            min-height: 50px;
            display: flex;
            flex-wrap: wrap; /* 배지가 여러 개일 때 다음 줄로 넘어가도록 */
            gap: 5px; /* 배지들 사이 간격 */
        }
        .badge-keyword {
            cursor: pointer; /* 클릭 가능하게 */
            padding-right: 1em; /* 닫기 버튼 공간 확보 */
        }
        .badge-keyword .btn-close {
            font-size: 2em; /* 닫기 버튼 크기 조절 */
            margin-left: 5px;
            vertical-align: middle;
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
							<li class="breadcrumb-item"><a href="/board/faqList.do">자주 찾는 질문(FAQ)</a></li>
							<li class="breadcrumb-item"><a href="#">FAQ 작성</a></li>
						</ol>
					</div>
				</div>

				<div class="content-title">FAQ 작성</div>
				<p class="desc">자주 찾는 질문을 작성할 수 있습니다.</p>
			</div>
		
		
			
			<div class="dashboard-section section">
			    <form action="/board/faqInsert" method="post" id="faqWriteForm">
			    	<c:if test="${status eq 'u' }">
			    		<input type="hidden" name="faqNo" value="${faqVo.faqNo }"/>
			    	</c:if>
			        <div class="form-group">
			            <label for="faqCategory">카테고리</label>
			            <select id="faqCategory" class="form-input" name="faqCategory">
			                <option value="">카테고리 선택</option>
			               	<c:forEach items="${categoryVo }" var="c">
			               		<c:set value="${faqVo.faqCategory }" var="cate"/>
			               		<option value="${c.faqCategory }" <c:if test="${c.faqCategory == cate }"> selected</c:if> >
			               			${c.faqCategory }
			               		</option>
			               	</c:forEach>
			            </select>
			        </div>
			        
			        <div class="form-group">
			            <label for="faqSummary">답변 요약</label>
			             <input type="text" id="faqSummary" name="faqSummary" class="form-input" placeholder="질문을 입력하세요." maxlength="10" value="${faqVo.faqSummary }">
			        </div>
			        
			      
			
			        <div class="form-group">
			            <label for="faqTitle" >질문 (Q)</label>
			            <input type="text" id="faqTitle"  name="faqTitle" class="form-input" placeholder="질문을 입력하세요." value="${faqVo.faqTitle }">
			        </div>
			
			        <div class="form-group">
			            <label for="faqContent">답변 (A)</label>
			            <textarea id="faqContent" name="faqContent" class="form-input" rows="10" placeholder="답변 내용을 입력하세요." >${faqVo.faqContent }</textarea>
			        </div>
			        
			         <div class="form-group">
                        <label for="faqTypeInput">FAQ 타입</label>
                        <div class="badge-container form-input" id="keywordBadges">
                       	<c:if test="${status eq 'u' }">
	                       	<c:set var="faqTypesArray" value="${fn:split(faqVo.faqType, ',')}" />

						    <c:forEach var="keyword" items="${faqTypesArray}">
						        <span class="badge bg-primary text-white badge-keyword">
						            <span class="keyWordValue" >${keyword}</span>
						            <input type="hidden" class="keyWordValue" name="faqTypeList" value="${keyword}"/>
						            <button type="button" class="btn-close btn-close-white" aria-label="Close"></button>
						        </span>
						    </c:forEach>
                       	</c:if>
                            </div>
                            
                    </div>
			        
			
			        <div class="form-buttons" style="float: inline-end">
			        ${message }
			        <button id="listBtn" class="btn btn-primary">목록</button>
			        <c:if test="${empty status }">
			            <button type="reset" class="btn btn-primary">초기화</button>
			        </c:if>
			            <c:set value="등록" var="text"/>
			            <c:if test="${status eq 'u' }">
			            	<c:set  value="수정" var="text"/>
			            </c:if>
			            <input id="formBtn" type="button" class="btn btn-primary" value="${text }">
			        </div>
			    </form>
			</div>
		</main>
	</div>
</body>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		let faqTitle = $("#faqTitle");
		let keywordBadges = $("#keywordBadges");
		let faqWriteForm = $("#faqWriteForm");
		let formBtn = $("#formBtn");
		let listBtn = $("#listBtn");
		
		listBtn.on("click",function(e){
			e.preventDefault();
			location.href = "/board/faqList.do";
		})
		
		faqTitle.on("keypress",function(e){
			if(e.which === 13){
				e.preventDefault();
				addKeywordBadge();
			}
		})
		
		function addKeywordBadge(){
			let keyword = faqTitle.val().trim();
			  const badgeHtml = `
                  <span class="badge bg-primary text-white badge-keyword">
                      <span class = "keyWordValue">\${keyword}</span>
                      <input type= "hidden" class = "keyWordValue" name="faqTypeList" value = "\${keyword}"/>
                      <button type="button" class="btn-close btn-close-white" aria-label="Close"></button>
                  </span>
              `;

              
			  keywordBadges.append(badgeHtml);
			   // 추가된 배지의 닫기 버튼에 클릭 이벤트 리스너 추가
              $('#keywordBadges .badge-keyword .btn-close').off('click').on('click', function() {
                  $(this).closest('.badge-keyword').remove(); // 해당 배지 제거
              });
		}
		
		  $('#keywordBadges .badge-keyword .btn-close').on('click', function() {
              $(this).closest('.badge-keyword').remove();
          });
		
		  
		  function getAllKeyWord(){
			  const keyWords = [];
			  
			  $(".keyWordValue").each(function(){
				  keyWords.push($(this).text());
			  })
			  return keyWords;
		  }
		
		
		  formBtn.on("click",function(e){
			  e.preventDefault();
			  
			  let faqCategory = $("#faqCategory").val();
			  let faqSummary = $("#faqSummary").val();
			  let faqTitle = $("#faqTitle").val();
			  let faqContent = $("#faqContent").val();
			  let faqTypeList = getAllKeyWord();
			  
			  console.log(faqCategory);
			  console.log(faqSummary);
			  console.log(faqTitle);
			  console.log(faqContent);
			  console.log(faqTypeList);
			  
			  
			  
			  if(faqCategory == null || faqCategory == ""){
				  alertify.error('카테고리를 선택해주세요!');
				  $("#faqCategory").focus();
				  return false;
			  }

			  if(faqSummary == null || faqSummary == ""){
				 /*  alert("답변 요약을 입력하세요!"); */
				  alertify.error('답변 요약을 입력하세요!');
				  $("#faqSummary").focus();
				  return false;
			  }
			  
			  if(faqTitle == null || faqTitle == ""){
				 /*  alert("질문 제목을 입력해주세요!"); */
				  alertify.error('질문 제목을 입력하세요!');
				  $("#faqTitle").focus();
				  return false;
			  }
			  
			  if(faqContent == null || faqContent == ""){
				 /*  alert("내용을 입력해주세요!"); */
				  alertify.error('내용을 입력하세요!');
				  $("#faqContent").focus();
				  return false;
			  }
			  
			  if(faqTypeList == null || faqTypeList == ""){
				 /*  alert("FAQ 타입을 입력해주세요!"); */
				  alertify.error('FAQ 타입을 입력하세요!');
				  return false;
			  }
			  
			  if($(this).val()=="수정"){
				  faqWriteForm.attr("action","/board/modify");
			  }
			  
			  faqWriteForm.submit();
			  
		  })
		
		
		  
		
		
		
		
		
		
		
	})
</script>
</html>