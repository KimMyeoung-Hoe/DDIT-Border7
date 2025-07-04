<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ리스트</title>
<%@ include file="../modules/header.jsp"%>
<%@ include file="../modules/sidebar.jsp"%>
<link rel="stylesheet" href="/css/main.css">
<sec:authentication property="principal" var="princ" />
<c:if test="${princ ne 'anonymousUser'}">
	<sec:authentication property="principal.user" var="user" />
	<sec:authentication property="authorities" var="auth" />
</c:if>
<style type="text/css">
.faq-question {
	background-color: #f9f9f9;
	padding: 15px;
	cursor: pointer;
	font-weight: bold;
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #eee; /* 질문과 답변 사이 구분선 */
	position: relative;
}
.faq-question > a.editBtn {
	position: absolute;
	right: 20px;
	top: 50%;
    transform: translateY(-50%);
}

.faq-question:hover {
	background-color: #f0f0f0;
}

/* 질문 옆 토글 아이콘 스타일 */
.faq-question .toggle-icon { /* fas fa-chevron-down 토글 아이콘 스타일 */
	transition: transform 0.3s ease;
}

.faq-question.active .toggle-icon {
	transform: rotate(180deg); /* 열릴 때 아이콘 회전 */
}

/* FAQ 답변 부분 스타일 (기본적으로 숨김) */
.faq-answer { /* 이름을 .faq-result 에서 .faq-answer 로 변경하는 것을 추천 */
	padding: 0 15px; /* 초기 패딩 0으로 설정하여 내용 숨김 */
	max-height: 0; /* 초기 높이 0으로 설정하여 내용 숨김 */
	overflow: hidden; /* 넘치는 내용 숨김 */
	transition: max-height 0.3s ease-out, padding 0.3s ease-out;
	/* 부드러운 전환 효과 */
	background-color: #fff;
	border-top: none; /* 질문과의 경계선 중복 방지 */
	color: #555; /* 답변 텍스트 색상 */
}

/* 답변이 보일 때의 스타일 */
.faq-answer.show {
	padding: 15px; /* 답변이 보일 때 패딩 추가 */
	max-height: 500px; /* 충분히 큰 값으로 설정하여 내용이 다 보이도록 (내용 길이에 따라 조절) */
}
/* FAQ 카테고리 태그 스타일 */
.faq-category-tag {
	display: inline-block;
	padding: 4px 8px;
	border-radius: 4px;
	font-size: 0.8em;
	margin-right: 10px;
	color: #fff;
	background-color: #007bff; /* 기본 색상 */
}

.support-tabs {
	position: relative;
}

.tab-item-btn {
	position: absolute;
	right: 0;
	top: 0;
}
.category-wrap{
	overflow-x: auto; /* 가로 스크롤 활성화 */
    white-space: nowrap; /* 자식 요소들이 줄바꿈되지 않도록 설정 */
    -webkit-overflow-scrolling: touch; /* iOS Safari 부드러운 스크롤 */
}
.categoryBtn{
	display: inline-block;
	border: 1px solid;
    width: auto;
    min-width: 100px;
}
.categoryBtn + .categoryBtn{
	margin-left: 10px;
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
						</ol>
					</div>
				</div>

				<div class="content-title">자주 찾는 질문(FAQ)</div>
				<p class="desc">자주 찾는 질문을 볼 수 있습니다.</p>
			</div>

			<div class="container section">
				<div class="support-tabs">
					<div class="tab-item" data-tab="notice">
						<i class="fas fa-bullhorn tab-icon"></i><span id="gonoticeBtn">공지사항</span>
					</div>
					<div class="tab-item active" data-tab="faq">
						<i class="fas fa-question-circle tab-icon"></i> 자주 찾는 질문(FAQ)
					</div>
					<div class="tab-item" data-tab="appeal">
						<i class="fas fa-bullhorn tab-icon"></i> <span id="goClaimBtn">민원</span>
					</div>
					<sec:authorize access="hasAnyRole('ROLE_SVT_MANDARIN','ROLE_SVT_QUARANTINE','ROLE_SVT_ADMIN')">
						<div class="tab-item-btn">
							<button class="btn btn-primary" id="registerBtn">공지 등록</button>
						</div>
					</sec:authorize>
				</div>
				<form method="post" id="searchForm">
					<div class="search-filter-section">
						<div class="search-input-wrapper">
							<div class="search-input-icon"></div>
							<input type="hidden" name="page" id="page" /> <input type="text"
								class="form-input search-input" placeholder="FAQ 검색"
								name="searchWord" value="${searchWord }">
						</div>
						<div class="filter-group">
							<button class="btn btn-light" style="border: 1px solid;">검색</button>
						</div>
					</div>
				</form>

				<div class="category-wrap">
					<c:forEach items="${categoryVo }" var="bar">
						<button class="btn btn-light categoryBtn"
							data-no="${bar.faqCategory }" >${bar.faqCategory }</button>
					</c:forEach>
				</div>

				<div class="faq-list-container dashboard-section" id="faqContent"
					style="margin-top: 30px">
					<c:set value="${pageVo.dataList }" var="faqList" />
					<c:forEach items="${faqList }" var="faq">
						<div class="faq-item">
							<div class="faq-question">
								<span class="faq-category-tag account-tag">${faq.faqCategory }</span>
								<span style="margin-right: auto">${faq.faqTitle } </span><i
									class="fas fa-chevron-down toggle-icon"></i>
									
								<sec:authorize access="hasRole('ROLE_SVT_ADMIN')">
									<a href="/board/faqDetail/${faq.faqNo }" id="registerBtn" class="editBtn">수정</a>
								</sec:authorize>
							</div>
							<div class="faq-answer">
								<span>${faq.faqContent }</span>
							</div>
						</div>
					</c:forEach>

					<div class="table-footer">
						<div class="pagination" id="pagingArea">${pageVo.pagingHTML}</div>
					</div>
				</div>
			</div>
		</main>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		let gonoticeBtn = $("#gonoticeBtn");
		let goClaimBtn = $("#goClaimBtn");
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm");
		let categoryBtn = $(".categoryBtn");
		let faqContent = $("#faqContent");
		let registerBtn = $("#registerBtn");
		
		pagingArea.on("click","a",function(e){
			e.preventDefault();
			let pageNo = $(this).data("page");
			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		})

		gonoticeBtn.on("click", function() {
			console.log("노티스 클릭");
			location.href = "/board/noticeList.do";

		})

		goClaimBtn.on("click", function() {
			console.log("민원 클릭");
			location.href = "/board/appealList.do";
		})
		
		categoryBtn.on("click",function(){
			let category = $(this).data("no");
			
			$.ajax({
				url:"/board/categoryBoardList",
				type: "get",
				data : ({category : category}),
				success:function(result){
					console.log(result);
					let html = ``;
					if(result.length > 0){
						faqContent.empty();
						
						for(let i = 0; i <result.length; i++){
							html+= `
							<div class="faq-item" id="faqArea">
								<div class="faq-question">
									<span class="faq-category-tag account-tag">\${result[i].faqCategory }</span>
									<span style="margin-right: auto">\${result[i].faqTitle } </span>
									<i class="fas fa-chevron-down toggle-icon"></i>
									<sec:authorize access="hasRole('ROLE_SVT_ADMIN')">
									<a href="/board/faqDetail/\${result[i].faqNo }" id="registerBtn" class="editBtn">수정</a>
								</sec:authorize>

								</div>
								<div class="faq-answer">
									<span>\${result[i].faqContent }</span>
								</div>
							</div>
							
						
							`;
						}
					}
					faqContent.html(html);
					
				}
			})
			
		})

		faqContent.on("click",".faq-question",function(){
			$(this).toggleClass("active");
			const answer = $(this).next(".faq-answer");
			answer.toggleClass("show");
		})
		

		
		registerBtn.on("click",function(){
			location.href = "/board/faqform.do";
		})
		
		document.addEventListener('DOMContentLoaded', () => {
		    const ele = document.querySelector('.category-wrap');
		    let pos = { top: 0, left: 0, x: 0, y: 0 };

		    const mouseDownHandler = function(e) {
		        ele.style.cursor = 'grabbing';
		        ele.style.userSelect = 'none';
		        pos = {
		            left: ele.scrollLeft,
		            top: ele.scrollTop,
		            // 현재 마우스 포인터의 X, Y 좌표
		            x: e.clientX,
		            y: e.clientY,
		        };

		        document.addEventListener('mousemove', mouseMoveHandler);
		        document.addEventListener('mouseup', mouseUpHandler);
		    };

		    const mouseMoveHandler = function(e) {
		        // 마우스가 얼마나 이동했는지 계산
		        const dx = e.clientX - pos.x;
		        const dy = e.clientY - pos.y;

		        // 요소의 스크롤 위치 업데이트
		        ele.scrollTop = pos.top - dy;
		        ele.scrollLeft = pos.left - dx;
		    };

		    const mouseUpHandler = function() {
		        ele.style.cursor = 'grab';
		        ele.style.removeProperty('user-select');
		        document.removeEventListener('mousemove', mouseMoveHandler);
		        document.removeEventListener('mouseup', mouseUpHandler);
		    };

		    ele.addEventListener('mousedown', mouseDownHandler);
		});
		
		
		
		
	})
</script>
</html>