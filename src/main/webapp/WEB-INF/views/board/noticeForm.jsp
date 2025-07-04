<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<%@ include file="../modules/header.jsp"%>
<%@ include file="../modules/sidebar.jsp"%>
<link rel="stylesheet" href="/css/main.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style type="text/css">

/* 파일 입력 필드 (새로 추가) */
.form-input-file {
	width: 100%;
	padding: 12px 15px;
	border: 1px solid #4a4a60;
	background-color: #3a3a50;
	color: #f0f0f0;
	border-radius: 8px;
	font-size: 1em;
	box-sizing: border-box;
	cursor: pointer;
}

.form-input-file::-webkit-file-upload-button {
	background-color: #007bff;
	color: white;
	padding: 8px 15px;
	border-radius: 5px;
	border: none;
	cursor: pointer;
	margin-right: 15px;
	transition: background-color 0.2s;
}

.form-input-file::-webkit-file-upload-button:hover {
	background-color: #0056b3;
}

.file-note {
	font-size: 0.85em;
	color: #a0a0d0;
	margin-top: 5px;
	padding-left: 5px;
}

/* 기존 CSS에서 재활용되는 부분 (이전에 통합된 CSS에 이미 존재함) */
/*
.form-section
.form-group
.form-group label
.form-input
.form-input:focus
textarea.form-input
select.form-input
.form-buttons
*/
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
							<li class="breadcrumb-item"><a href="/board/noticeList.do">공지사항</a></li>
							<c:set value="작성" var="name" />
							<c:if test="${status eq 'u' }">
								<c:set value="수정" var="name" />
							</c:if>
							<li class="breadcrumb-item"><a href="#">공지사항 ${name }</a></li>
						</ol>
					</div>
				</div>

				<div class="content-title">공지사항 ${name }</div>
				<p class="desc">공지사항을 ${name }할 수 있습니다.</p>
			</div>

			<div class="section">
				<form action="/board/noticeInsert" method="post"
					id="noticeWriteForm" enctype="multipart/form-data">

					<c:if test="${status eq 'u' }">
						<input id="noticeNo" type="hidden" name="noticeNo"
							value="${notice.noticeNo }" />
					</c:if>
					<div class="form-group">
						<label for="noticeTitle">제목</label> <input type="text"
							id="noticeTitle" class="form-input" name="noticeTitle"
							placeholder="공지사항 제목을 입력하세요." value="${notice.noticeTitle }">
					</div>

					<div class="form-group">
						<label for="noticeContent">내용</label>
						<textarea id="noticeContent" rows="20" cols="200"
							name="noticeContent" style="border-radius: 10px;"
							placeholder="공지사항 내용을 입력하세요.">${notice.noticeContent }</textarea>
					</div>
					<div class="form-group">
						<div class="custom-file">
							<label for="inputDescription">파일 선택</label>
							 <input type="file"class="custom-file-input" name="noticeFile" id="noticeFile"multiple="multiple">
							  <label class="custom-file-label" for="noticeFile">파일을 선택해주세요</label>
						</div>
					</div>
					<c:if test="${status eq 'u' }">

						<div>
							<ul
								class="mailbox-attachments d-flex align-items-stretch clearfix">
								<c:if test="${not empty notice.noticeFileList }">
									<c:forEach items="${notice.noticeFileList }" var="noticeFile">
											<div>
													<span class="btn btn-default btn-sm float-right attachmentFileDel" id="span_${noticeFile.comFileDetailNo }">
																	<i class="bi bi-x"></i>
													</span>
												${noticeFile.comFileDetailOriginalName} <span
													class="mailbox-attachment-size clearfix mt-1"> <span>${noticeFile.comFileDetailSize }</span>

												</span>
											</div>
									</c:forEach>
								</c:if>
							</ul>
						</div>
					</c:if>
				</form>
				<div class="form-buttons" style="float: inline-end">

					<c:if test="${status eq 'u' }">
						<button id="cencelBtn" class="btn btn-primary">취소</button>
					</c:if>
					<c:if test="${status ne 'u' }">
						<button id="listBtn" class="btn btn-primary">목록</button>
					</c:if>

					<button id="submitBtn" type="submit" class="btn btn-primary">공지${name }</button>
				</div>

			</div>
		</main>
	</div>
</body>
<script type="text/javascript">
	$(function() {

		let noticeWriteForm = $("#noticeWriteForm");
		let submitBtn = $("#submitBtn");
		let listBtn = $("#listBtn");
		let cencelBtn = $("#cencelBtn");
		let noticeNo = $("#noticeNo").val();
		let noticeFile = $("#noticeFile");

		listBtn.on("click", function() {
			location.href = "/board/noticeList.do";
		})

		cencelBtn.on("click", function() {
			location.href = "/board/noticeDetail/" + noticeNo;
		})

		submitBtn.on("click", function() {
			let title = $("#noticeTitle").val();
			let content = $("#noticeContent").val();
			let noticeFileValue = $("#noticeFile").val();

			if (title == null || title == "") {
				alertify.error('제목을 입력해주세요.');
				/* alert("제목을 입력해주세요."); */
				return false;
			}

			if (content == null || content == "") {
				alertify.error('내용을 입력해주세요.');
				/* alert("내용을 입력해주세요."); */
				return false;
			}
			
			
			
			if($(this).text()== "공지수정"){
				noticeWriteForm.attr("action","/board/noticeUpdate");
			}
				
				
			noticeWriteForm.submit();
		})
		
			//파일이 가지고있는 x 버튼을 클릭했을때 
		noticeWriteForm.on("click", ".attachmentFileDel",function(){
			let id = $(this).prop("id");
			let idx = id.indexOf("_");
			let fileNo = id.substring(idx+1);
			let ptrn = "<input type='hidden' name='delFileNo' value='%V'/>";
			noticeWriteForm.append(ptrn.replace("%V",fileNo));
			
			$(this).parents("div:first").hide(); //내가 누른 span중의 첫번째 li를 가린다
		})
		
		//파일 입력시 이름 나오게
		noticeFile.on("change",function(){
			let fileNames = "";
			
			if(this.files && this.files.length > 0){
				if(this.files.length > 1){
					fileNames = this.files.length + "개의 파일이 선택되었습니다";
				}else{
					fileNames = this.files[0].name;
				}
			}
			   $(this).next(".custom-file-label").html(fileNames);
			
		})

	})
</script>
</html>