<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공무원 대시보드</title>
    
    <style>
        /* 기본 스타일 리셋 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            margin: 0;
            font-family: "Nanum Gothic", "Malgun Gothic", Arial, sans-serif;
            background: radial-gradient(farthest-side ellipse at 10% 0, #333867 20%, #17193b);
            color: #ffffff;
            min-height: 100vh;
        }
        
        /* 메인 레이아웃 */
        .dashboard-container {
            display: flex;
            min-height: 100vh;
            background: radial-gradient(farthest-side ellipse at 10% 0, #333867 20%, #17193b);
            color: #ffffff;
            font-family: "Nanum Gothic", "Malgun Gothic", Arial, sans-serif;
        }
        
        .main-wrapper {
            flex: 1;
            margin-left: 240px;
            width: calc(100% - 240px);
        }
        
        /* 메인 콘텐츠 영역 */
        .main-content-area {
            padding: 24px;
            height: calc(100vh - 64px);
            overflow: auto;
        }
        
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 320px;
            grid-template-rows: auto auto;
            grid-template-areas:
                "main side"
                "bottom bottom";
            gap: 24px;
            height: 100%;
        }
        
        .main-section {
            grid-area: main;
            background-color: rgba(0, 0, 0, 0.24);
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        
        .side-widgets {
            grid-area: side;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }
        
        .bottom-section {
            grid-area: bottom;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }
        
        .bottom-left,
        .bottom-right {
            background-color: rgba(0, 0, 0, 0.24);
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        
        .section-header {
            padding: 16px 20px;
            border-bottom: 1px solid #4a5568;
        }
        
        .section-header h2 {
            font-size: 18px;
            font-weight: 600;
            margin: 0;
            color: #ffffff;
        }
        
        /* 위젯 스타일 */
        .widget {
            background-color: rgba(0, 0, 0, 0.24);
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        
        .widget-header {
            padding: 16px;
            border-bottom: 1px solid #4a5568;
        }
        
        .widget-header h3 {
            font-size: 16px;
            font-weight: 600;
            margin: 0;
            color: #ffffff;
        }
        
        .widget-content {
            padding: 16px;
        }
        
        /* 빈 콘텐츠 */
        .empty-content {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 200px;
            color: #8a93a2;
            font-size: 14px;
        }
        
        /* 반응형 조정 */
        @media (max-width: 1200px) {
            .content-grid {
                grid-template-columns: 1fr;
                grid-template-areas:
                    "main"
                    "side"
                    "bottom";
            }
            
            .bottom-section {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 768px) {
            .main-wrapper {
                margin-left: 0;
                width: 100%;
            }
        }
        
        p {
            color: #ffffff;
        }
        
        h1 {
            color: #ffffff;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <%@ include file="../modules/servant/sidebar.jsp" %>
        
        <div class="main-wrapper">
            <%@ include file="../modules/servant/header.jsp" %>
            
            <!-- 메인 콘텐츠 영역 -->
            <div class="main-content-area">
                <!-- 여기에 기존 MainContentArea 내용을 JSP로 구현 -->
                <div class="content-grid">
                    <div class="main-section">
                        <div class="section-header">
                            <h2>상위 공무원 업무</h2>
                        </div>
                        <div class="empty-content">
                            <p>새 업무 내용이 여기에 표시됩니다.</p>
                        </div>
                    </div>
                    
                    <div class="side-widgets">
                        <div class="widget">
                            <div class="widget-header">
                                <h3>민원사항</h3>
                            </div>
                            <div class="widget-content">
                                <p>민원사항 내용</p>
                            </div>
                        </div>
                        
                        <div class="widget">
                            <div class="widget-header">
                                <h3>HS 코드 검색</h3>
                            </div>
                            <div class="widget-content">
                                <p>HS 코드 검색 위젯</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="bottom-section">
                        <div class="bottom-left">
                            <div class="section-header">
                                <h2>제재이력</h2>
                            </div>
                            <div class="empty-content">
                                <p>제재이력 정보가 존재하지 않습니다.</p>
                            </div>
                        </div>
                        
                        <div class="bottom-right">
                            <div class="section-header">
                                <h2>공지사항 / FAQ</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 전역 네비게이션 함수는 이제 sidebar.jsp에서 처리됨
        
        // 헤더 이벤트 핸들러들
        function onLogoClick() {
            var reactAppBaseUrl = 'http://localhost:3000';
            window.location.href = reactAppBaseUrl;
        }
        
        function onLoginClick() {
            var baseUrl = 'http://localhost:8080';
            window.location.href = baseUrl + '/login/main.do';
        }
        
        function onProfileClick() {
            var baseUrl = 'http://localhost:8080';
            window.location.href = baseUrl + '/myPage/main.do';
        }
        
        function onWebmailClick() {
            var baseUrl = 'http://localhost:8080';
            window.location.href = baseUrl + '/myPage/myMail.do';
        }
        
        function onPageLockClick() {
        	alertify.alert('페이지 잠금 기능');
        }
    </script>
</body>
</html>
