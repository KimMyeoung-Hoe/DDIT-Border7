<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./nModule/headerPart.jsp" %>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<%@ include file="./nModule/header.jsp" %>

		<div class="content-wrapper">
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>공지사항 등록</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">DDIT HOME</a></li>
								<li class="breadcrumb-item active">공지사항 등록</li>
							</ol>
						</div>
					</div>
				</div>
			</section>
			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="card card-dark">
							<div class="card-header">
								<h3 class="card-title">공지사항 등록</h3>
								<div class="card-tools"></div>
							</div>
							<form role="form" action="" method="post" id="noticeForm">
								<div class="card-body">
									<div class="form-group">
										<label for="boTitle">제목을 입력해주세요</label> 
										<input type="text" id="boTitle" name="" value="" class="form-control" placeholder="제목을 입력해주세요">
									</div>
									<div class="form-group">
										<label for="boContent">내용을 입력해주세요</label>
										<textarea id="boContent" name="" class="form-control" rows="14"></textarea>
									</div>
									<div class="form-group">
										<div class="custom-file">
											<label for="inputDescription">파일 선택</label> 
											<input type="file" class="custom-file-input" name="" id="boFile" multiple="multiple"> 
											<label class="custom-file-label" for="boFile">파일을 선택해주세요</label>
										</div>
									</div>
								</div>
								<div class="card-footer bg-white">
									<ul class="mailbox-attachments d-flex align-items-stretch clearfix">
										<li>
											<span class="mailbox-attachment-icon">
												<i class="far fa-file-pdf"></i>
											</span>
											<div class="mailbox-attachment-info">
												<a href="#" class="mailbox-attachment-name">
													<i class="fas fa-paperclip"></i> 
													파일명을 입력해주세요.
												</a> 
												<span class="mailbox-attachment-size clearfix mt-1"> 
													<span>파일 팬시 크기를 입력해주세요.</span> 
													<span class="btn btn-default btn-sm float-right" id="">
														<i class="fas fa-times"></i>
													</span>
												</span>
											</div>
										</li>
									</ul>
								</div>
								<div class="card-footer bg-white">
									<div class="row">
										<div class="col-12">
											<input type="button" value="등록" id="formBtn" class="btn btn-secondary float-right">
											<input type="button" id="cancelBtn" value="취소" class="btn btn-dark float-right">
											<input type="button" id="listBtn" value="목록" class="btn btn-dark float-right">
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</section>
		</div>
		<%@ include file="./nModule/footer.jsp" %>

		<aside class="control-sidebar control-sidebar-dark">
		</aside>
	</div>
	<%@ include file="./nModule/footerPart.jsp" %>
</body>
</html>
