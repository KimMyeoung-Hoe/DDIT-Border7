<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ci/pl 작성후 오는 페이지</title>
    
    <%@ include file="../modules/header.jsp" %>
	<%@ include file="../modules/sidebar.jsp" %>
    
	<link rel="stylesheet" href="/css/main.css">
	<link rel="stylesheet" href="/css/contract.css">
	<link rel="stylesheet" href="/css/contract2.css">
    <style>
    </style>
</head>
<body>
	<div class="app-container">
		<main class="main-content-area">
			<div class="page-header-container">
                <h1 class="page-title">전자제품 수입통관</h1>
                <div class="header-info">
                    의뢰번호: ${contractVO.contractNo } | 등록일: 2025-05-10
                    <span class="status-badge-custom">수입</span>
                    <span class="status-badge-custom blue-variant">수출입신고서 작성</span>
                </div>
            </div>

            <div class="dashboard-section section progress-section">
                <h2 class="progress-title">진행 상태</h2>
                <p class="progress-subtitle">현재 의뢰 진행 상황: 수출입신고서 작성</p>
                
                <div class="status-bar-container">
                	<div class="status-step active">
				        <div class="step-circle">1</div>
				        <div class="step-text">신청 정보</div>
				    </div>
				    <div class="status-line active"></div> <div class="status-step active">
				        <div class="step-circle">2</div>
				        <div class="step-text">검사</div>
				    </div>
				    <div class="status-line"></div> <div class="status-step"> <div class="step-circle">3</div>
				        <div class="step-text">최종 업데이트</div>
				    </div>
				</div>
                <div class="progress-meta">
                    <div class="progress-meta-item">
                        <span class="label">담당 관세사</span>
                        <span class="value">김관세</span>
                    </div>
                    <div class="progress-meta-item">
                        <span class="label">최근 업데이트</span>
                        <span class="value">2025-05-12</span>
                    </div>
                </div>
            </div>

            <div class="tab-container">
                <div class="tab-buttons">
                    <button class="tab-button active" data-tab="detail">상세 정보</button>
                    <button class="tab-button" data-tab="documents">서류 관리</button>
                    <button class="tab-button" data-tab="history">진행 내역</button>
                </div>

                <div id="detail" class="tab-content active">
                    <div class="content-grid">
                        <div class="info-card-custom dashboard-section">
                            <h3 class="card-title">의뢰 정보</h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">의뢰 유형</span>
                                    <span class="info-value">수입</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">국가</span>
                                    <span class="info-value">중국</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">물품 종류</span>
                                    <span class="info-value">전자제품</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">물품명</span>
                                    <span class="info-value">스마트폰 부품</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">수량</span>
                                    <span class="info-value">1,000개</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">총 금액</span>
                                    <span class="info-value">50,000 USD</span>
                                </div>
                            </div>
                        </div>

                        <div class="info-card-custom dashboard-section contact-section">
                            <h3 class="card-title">담당자 정보</h3>
                            <div class="contact-item">
                                <div class="contact-avatar primary">관세사</div>
                                <div class="contact-details">
                                    <span class="contact-name">김관세</span>
                                    <span class="contact-info">010-1234-5678<br>kim@customs.com<br>팩스: 02-1234-5678</span>
                                </div>
                            </div>
                            <div class="contact-item">
                                <div class="contact-avatar secondary">의뢰인</div>
                                <div class="contact-details">
                                    <span class="contact-name">홍길동 (주)비디세븐</span>
                                    <span class="contact-info">010-9876-5432<br>hong@example.com</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="dashboard-section section description-section-custom">
                        <h3 class="card-title">상세 설명</h3>
                        <p>중국에서 생산된 스마트폰 부품을 수입하려고 합니다. 관세율과 필요한 인증에 대해 상담이 필요합니다.</p>
                    </div>
                </div>

                <div id="documents" class="tab-content">
                    <div class="dashboard-section section">
                        <h3 class="card-title">서류 관리</h3>
                        <div class="section-alert">
                            <i class="fas fa-exclamation-triangle"></i>
                            <p>서류 수정 불가<br>수출입신고서가 이미 작성되어 CI/PL 서류를 수정할 수 없습니다.</p>
                        </div>

                        <ul class="file-list">
                            <li class="file-item">
                                <div class="file-info">
                                    <i class="fas fa-file-alt"></i>
                                    <div class="file-details">
                                        <span class="file-name">상업송장.pdf (CI)</span>
                                        <span class="file-meta">최종 업데이트: 2025-05-10</span>
                                    </div>
                                </div>
                                <div class="file-actions">
                                    <button class="action-button secondary"><i class="fas fa-download"></i> 다운로드</button>
                                    <button class="action-button secondary disabled"><i class="fas fa-edit"></i> 수정</button>
                                </div>
                            </li>
                            <li class="file-item">
                                <div class="file-info">
                                    <i class="fas fa-file-alt"></i>
                                    <div class="file-details">
                                        <span class="file-name">패킹리스트.pdf (PL)</span>
                                        <span class="file-meta">최종 업데이트: 2025-05-10</span>
                                    </div>
                                </div>
                                <div class="file-actions">
                                    <button class="action-button secondary"><i class="fas fa-download"></i> 다운로드</button>
                                    <button class="action-button secondary disabled"><i class="fas fa-edit"></i> 수정</button>
                                </div>
                            </li>
                            <li class="file-item completed">
                                <div class="file-info">
                                    <i class="fas fa-check-circle"></i>
                                    <div class="file-details">
                                        <span class="file-name">${contractVO.contractType}신고서</span>
                                        <span class="file-meta">${contractVO.declDVO.declDNo == null ? 작성바람 : contractVO.declDVO.declDNo }.pdf / 최종 업데이트: 2025-05-11</span>
                                        ${contractVO.declDVO.declDNo}
                                    </div>
                                </div>
                                <div class="file-actions">
                                	<c:choose>
			                        	<c:when test="${contractVO.declDVO.declDNo != null}">
											<button class="action-button secondary" onclick="fn_decl_w('${contractVO.contractNo }')"><i class="fas fa-download"></i> 확인하기</button>
			                        	</c:when>
		                        		<c:otherwise>
		                        			<button class="action-button secondary" onclick="fn_decl_w('${contractVO.contractNo }')"><i class="fas fa-download"></i> 작성하기</button>
		                        		</c:otherwise>
		                        	</c:choose>
                                    
                                    
                                    <!-- <button class="action-button secondary"><i class="fas fa-download"></i> 다운로드</button> -->
                                    
                                </div>
                            </li>
                        </ul>

                        <div class="status-section">
                            <h4 class="status-heading">신고필증</h4>
                            <p class="status-text"><i class="fas fa-clock"></i> 대기중</p>
                        </div>
                    </div>
                </div>

                <div id="history" class="tab-content">
                    <div class="dashboard-section section">
                        <div class="progress-section">
					    <h3 class="progress-title">진행 과정</h3>
					    <div class="progress-bar">
					        <div class="progress-step">
					            <div class="step-circle-container active"></div> <div class="step-text-container">
					                <div class="step-title">관세사 계약 접수</div>
					                <div class="step-details">2025-05-10 09:00<br>의뢰 접수 완료</div>
					            </div>
					        </div>
					        <div class="progress-step">
					            <div class="step-circle-container active"></div>
					            <div class="step-text-container">
					                <div class="step-title">관세사 계약 완료</div>
					                <div class="step-details">2025-05-10 11:30<br>계약 체결 완료</div>
					            </div>
					        </div>
					        <div class="progress-step">
					            <div class="step-circle-container"></div> <div class="step-text-container">
					                <div class="step-title">수출입신고서 작성</div>
					                <div class="step-details">2025-05-11 14:20<br>수출입신고서 작성 중</div>
					            </div>
					        </div>
					        </div>
					</div>
                    </div>
                </div>
            </div>
            <div class="action-buttons-custom bottom-fixed">
                <button class="action-button secondary" onclick="fn_contract_list()"><i class="fas fa-arrow-left"></i> 목록 가기</button>
                <div class="btn-group-custom">
                	<button class="action-button primary"><i class="fas fa-envelope"></i> 수락</button>
                	<button class="action-button danger"><i class="fas fa-envelope"></i> 거절</button>
                    <button class="action-button primary"><i class="fas fa-envelope"></i> 관세사에게 메시지</button>
                </div>
            </div>
	</main>
</div>

    <script>
	    document.addEventListener('DOMContentLoaded', function() {
	        const tabButtons = document.querySelectorAll('.tab-button');
	        const tabContents = document.querySelectorAll('.tab-content');
	
	        tabButtons.forEach(button => {
	            button.addEventListener('click', function() {
	                // 모든 탭 버튼에서 active 클래스 제거
	                tabButtons.forEach(btn => btn.classList.remove('active'));
	                // 클릭된 버튼에 active 클래스 추가
	                this.classList.add('active');
	
	                // 모든 탭 콘텐츠 숨기기
	                tabContents.forEach(content => content.classList.remove('active'));
	                // 클릭된 버튼에 해당하는 콘텐츠 보이기
	                const targetTabId = this.dataset.tab;
	                document.getElementById(targetTabId).classList.add('active');
	            });
	        });
	    });
	    
        // Add some interactive effects
        document.querySelectorAll('.btn').forEach(btn => {
            btn.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-1px)';
            });
            
            btn.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
        
        function fn_contract_list(){
        	location.href = "/contract/list.do";
        }
        
        function fn_decl_w(no){
        	let declpath = "";
        	console.log(no);
        	//수입 수출 분기
			let port = no.substring(0, 3);
        	console.log(port);
        	location.href = "/contract/declform.do?contractNo="+no;
        }
        
    </script>
</body>
</html>