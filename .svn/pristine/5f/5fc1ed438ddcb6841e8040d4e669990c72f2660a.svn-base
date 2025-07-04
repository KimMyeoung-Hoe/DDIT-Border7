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
							<h1>마이페이지</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">User Profile</li>
							</ol>
						</div>
					</div>
				</div>
			</section>
			
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-3">
			
							<div class="card card-dark card-outline">
								<div class="card-header">
									<div class="card-title">
										<h4>내정보</h4>
									</div>
								</div>
								<div class="card-body">
									<div class="position-relative">
										<img src="" alt="Photo 1" class="img-fluid">
										<div class="ribbon-wrapper ribbon-lg">
											<div class="ribbon bg-success text-lg">Profile</div>
										</div>
									</div>
									<div class="row mt-4">
										<div class="col-md-4 text-bold">아이디</div>
										<div class="col-md-8"></div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">비밀번호</div>
										<div class="col-md-8">PROTECTED</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">이름</div>
										<div class="col-md-8"></div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">성별</div>
										<div class="col-md-8"></div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">이메일</div>
										<div class="col-md-8"></div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">전화번호</div>
										<div class="col-md-8"></div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">주소</div>
										<div class="col-md-8"></div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">가입일</div>
										<div class="col-md-8"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-9">
							<div class="card card-dark card-outline">
								<form class="form-horizontal" action="" method="post" id="profileUdtForm">
									<div class="card-header">
										<div class="row">
											<div class="col-md-10">
												<h4>내정보 수정</h4>
											</div>
											<div class="col-md-2" align="right">
												<button type="submit" class="btn btn-info">수정하기</button>
											</div>
										</div>
									</div>
									<div class="card-body">
										<div class="tab-content">
											<div class="tab-pane active">
												<div class="form-group row">
													<label class="col-sm-2 col-form-label">프로필 이미지</label>
													<div class="col-md-10">
														<br/>
														<div class="custom-file">
															<input type="file" class="custom-file-input" name="" id="imgFile"> 
															<label class="custom-file-label" for="imgFile">프로필 이미지를 선택해주세요</label>
														</div>										
													</div>
												</div>
												<div class="form-group row">
													<label for="memId" class="col-sm-2 col-form-label">아이디</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="memId" name="" value="" placeholder="아이디를 입력해주세요.">
													</div>
												</div>
												<div class="form-group row">
													<label for="memPw" class="col-sm-2 col-form-label">비밀번호</label>
													<div class="col-sm-10">
														<input type="password" class="form-control" id="memPw" name="" value="" placeholder="아이디를 입력해주세요.">
													</div>
												</div>
												<div class="form-group row">
													<label for="memName" class="col-sm-2 col-form-label">이름</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="memName" name="" value="" placeholder="비밀번호를 입력해주세요.">
													</div>
												</div>
												<div class="form-group row">
													<label for="" class="col-sm-2 col-form-label">성별</label>
													<div class="col-sm-10">
														<div class="icheck-primary d-inline">
															<input type="radio" id="memGenderM" name="" value="M"> 
															<label for="memGenderM">남자</label>
														</div>
														<div class="icheck-primary d-inline">
															<input type="radio" id="memGenderF" name="" value="F"> 
															<label for="memGenderF">여자</label>
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label for="memEmail" class="col-sm-2 col-form-label">이메일</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="memEmail" name="" value="" placeholder="이메일을 입력해주세요.">
													</div>
												</div>
												<div class="form-group row">
													<label for="memPhone" class="col-sm-2 col-form-label">전화번호</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="memPhone" name="" value="" placeholder="전화번호를 입력해주세요.">
													</div>
												</div>
												<div class="input-group mb-3">
													<label for="" class="col-sm-2 col-form-label">주소</label>
													<div class="col-sm-10">
														<div class="input-group mb-3">
															<input type="text" class="form-control" id="memPostCode" name="" value="" placeholder="우편번호를 입력해주세요"> 
															<span class="input-group-append">
																<button type="button" class="btn btn-secondary btn-flat">우편번호 찾기</button>
															</span>
														</div>
														<div class="input-group mb-3">
															<input type="text" class="form-control" id="memAddress1" name="" value="" placeholder="주소를 입력해주세요">
														</div>
														<div class="input-group mb-3">
															<input type="text" class="form-control" id="memAddress2" name="" value="" placeholder="상세주소를 입력해주세요">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
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
