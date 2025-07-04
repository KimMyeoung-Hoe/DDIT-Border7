<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>캡차 인증 페이지</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; min-height: 100vh; background-color: #f4f4f4; }
        .container { background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        .captcha-img { border: 1px solid #ddd; margin-bottom: 15px; }
        .form-group { margin-bottom: 15px; }
        .form-group input { padding: 10px; width: 200px; border: 1px solid #ddd; border-radius: 4px; }
        .btn { padding: 10px 15px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin: 5px; }
        .btn:hover { background-color: #0056b3; }
        .message { margin-top: 15px; font-weight: bold; }
        .success { color: green; }
        .fail { color: red; }
    </style>
</head>
<body>
    <div class="container">
        <h2>캡차 인증</h2>

        <%-- 캡차 이미지 로드 --%>
        <div class="form-group">
            <%
                String captchaImageUrl = (String) request.getAttribute("captchaImageUrl");
            	System.out.println(captchaImageUrl);
                if (captchaImageUrl != null && !captchaImageUrl.isEmpty()) {
            %>
                    <img id="captchaImage" src="<%= captchaImageUrl %>" alt="캡차 이미지" class="captcha-img">
            <%
                } else {
            %>
                    <p style="color: red;">캡차 이미지를 불러올 수 없습니다. <%= request.getAttribute("captchaError") != null ? "(" + request.getAttribute("captchaError") + ")" : "" %></p>
            <%
                }
            %>
        </div>

        <%-- 캡차 갱신 버튼 (JavaScript를 통해 현재 페이지 재로드) --%>
        <div class="form-group">
            <button class="btn" onclick="location.reload();">새로운 캡차 받기</button>
            <%-- 또는 특정 컨트롤러 엔드포인트로 이동
            <button class="btn" onclick="location.href='<c:url value="/captcha/page.do"/>'">새로운 캡차 받기</button>
            --%>
        </div>

        <%-- 캡차 입력 폼 --%>
        <form action="${pageContext.request.contextPath}/captcha/verify.do" method="post">
            <div class="form-group">
                <input type="text" name="captchaInput" placeholder="캡차 입력" required>
            </div>
            <%-- 숨겨진 필드에 캡차 키 저장 --%>
            <input type="hidden" name="captchaKey" value="${captchaKey}">

            <div class="form-group">
                <button type="submit" class="btn">확인</button>
            </div>
        </form>

        <%-- 검증 결과 메시지 표시 --%>
        <div class="message">
            <%
                String verificationResult = (String) request.getAttribute("verificationResult");
                String message = (String) request.getAttribute("message");

                if (verificationResult != null) {
                    if ("success".equals(verificationResult)) {
            %>
                        <p class="success"><%= message %></p>
            <%
                    } else if ("fail".equals(verificationResult)) {
            %>
                        <p class="fail"><%= message %></p>
            <%
                    }
                }
            %>
        </div>
    </div>
</body>
</html>