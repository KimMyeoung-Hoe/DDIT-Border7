<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./lModule/headerPart.jsp" %>
<body class="hold-transition">
	<div class="login-box">
		<div class="card">
			<div class="card-body login-card-body">
				<h2 class="login-box-msg"><b>DDIT</b> BOARD</h2>
	
				<form action="" method="post" id="signForm">
					<div class="input-group mb-3">
						<input type="text" class="form-control login" name="" id="memId" placeholder="아이디를 입력해주세요">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-user"></span>
							</div>
						</div>
						<span class="error invalid-feedback" style="display:block;"></span>
					</div>
					<div class="input-group mb-3">
						<input type="password" class="form-control login" name="" id="memPw" placeholder="비밀번호를 입력해주세요">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-lock"></span>
							</div>
						</div>
						<span class="error invalid-feedback" style="display:block;"></span>
					</div>
					<div class="row">
						<div class="col-8">
							<div class="icheck-primary">
								<input type="checkbox" id="remember"> 
								<label for="remember"> Remember Me </label>
							</div>
						</div>
						<div class="col-4">
							<button type="button" class="btn btn-dark btn-block" id="signinBtn">로그인</button>
						</div>
					</div>
				</form>
				<p class="mb-1">
					<a href="">아이디 & 비밀번호 찾기</a>
				</p>
				<p class="mb-0">
					<a href="" class="text-center">회원가입</a>
				</p>
			</div>
		</div>
	</div>

	<%@ include file="./lModule/footerPart.jsp" %>
</body>
</html>
