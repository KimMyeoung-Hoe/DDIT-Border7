<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>세금 고지서 - 대한민국 관세청</title>
  <script src="<%=request.getContextPath() %>/lib/jQuery/jquery-3.7.1.min.js" ></script>
  <style>
  	#taxBtn {
	  	color: #fff;
	    background-color: #007bff;
	    border-color: #007bff;
	    box-shadow: none;
		border: none;
	    border-radius: 8px;
	    font-size: 16px !important;
	    font-weight: bold;
	    transition: background-color 0.2s, transform 0.1s;
	    width: 160px;
	    height: 48px;
  	}
  </style>
  <sec:authentication property="principal" var="princ"/>
</head>
<body style="margin: 0; padding: 0; font-family: 'Malgun Gothic','맑은 고딕',Arial,sans-serif; background-color: #f5f5f5; color: #333;">
  <div style="margin: 10px auto 0; max-width: 800px;">
    <a href="/pdf/taxDownload.do?url=doc/taxBill.do?declNo=${taxMap.DECL_NO}"
      style="display: inline-block; background-color: #007AFD; color: white; font-size: 14px; font-weight: bold; padding: 8px 16px; text-decoration: none; border-radius: 5px;">
      다운로드
    </a>
  </div>

  <div id="pdfTarget" style="max-width: 800px; background: white; box-shadow: 0 0 10px rgba(0, 0, 0, 0.08); border-radius: 6px; overflow: hidden; margin: 10px auto;">
    <div style="background: #f8fafc; padding: 12px 20px; text-align: center; border-bottom: 2px solid #1e3a8a;">
      <h2 style="font-size: 22px; color: #1e3a8a; margin: 0;">관세 납부 고지서[대납자용]</h2>
    </div>

    <div style="padding: 10px 20px; background: #f1f5f9; border-bottom: 1px solid #e2e8f0;">
      <span style="font-family: 'Courier New', monospace; font-size: 16px; font-weight: bold; color: #1e3a8a;">
        고지서 번호: ${taxMap.TX_TAX_NO}
      </span>
    </div>

    <div style="padding: 20px;">
      <div style="font-size: 15px; font-weight: bold; color: #1e3a8a; margin-bottom: 10px; border-bottom: 1px solid #e2e8f0; padding-bottom: 6px;">
        납부정보
      </div>
      <table style="width: 100%; table-layout: fixed; border-collapse: collapse;">
        <colgroup>
          <col style="width: 50%;">
          <col style="width: 50%;">
        </colgroup>
        <tr>
          <td style="vertical-align: top; padding: 8px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #64748b; margin-bottom: 4px;">납부자</label>
            <span style="display: block; font-size: 15px; color: #1e293b; background: #f8fafc; padding: 8px; border-radius: 4px; border-left: 4px solid #3b82f6;">
              ${taxMap.TX_CONSIGNOR_NAME}
            </span>
          </td>
          <td style="vertical-align: top; padding: 8px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #64748b; margin-bottom: 4px;">고지일</label>
            <span style="display: block; font-size: 15px; color: #1e293b; background: #f8fafc; padding: 8px; border-radius: 4px; border-left: 4px solid #3b82f6;">
              <fmt:formatDate value="${taxMap.TX_TAX_DEST_DATE}" pattern="yyyy년 MM월 dd일" />
            </span>
          </td>
        </tr>
        <tr>
          <td style="vertical-align: top; padding: 8px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #64748b; margin-bottom: 4px;">대납자</label>
            <span style="display: block; font-size: 15px; color: #1e293b; background: #f8fafc; padding: 8px; border-radius: 4px; border-left: 4px solid #3b82f6;">
              ${taxMap.TX_CCA_NAME}
            </span>
          </td>
          <td style="vertical-align: top; padding: 8px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #64748b; margin-bottom: 4px;">납부기한</label>
            <span style="display: block; font-size: 15px; color: #1e293b; background: #f8fafc; padding: 8px; border-radius: 4px; border-left: 4px solid #3b82f6;">
              <fmt:formatDate value="${taxMap.TX_TAX_DEADLINE_DATE}" pattern="yyyy년 MM월 dd일" />
            </span>
          </td>
        </tr>
        <tr>
          <td style="vertical-align: top; padding: 8px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #64748b; margin-bottom: 4px;">소관 세관지</label>
            <span style="display: block; font-size: 15px; color: #1e293b; background: #f8fafc; padding: 8px; border-radius: 4px; border-left: 4px solid #3b82f6;">
              ${taxMap.TX_CUSTOMS_AUTHORITY}
            </span>
          </td>
          <td style="vertical-align: top; padding: 8px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #64748b; margin-bottom: 4px;">세금 종류</label>
            <span style="display: block; font-size: 15px; color: #1e293b; background: #f8fafc; padding: 8px; border-radius: 4px; border-left: 4px solid #3b82f6;">
              <c:if test="${taxMap.TX_TAX_NO ne '' && taxMap.TX_TAX_NO ne null}">관세</c:if>
            </span>
          </td>
        </tr>
      </table>
    </div>
        <!-- 납부 금액 -->
    <div style="background: linear-gradient(135deg, #eff6ff, #dbeafe); border: 1px solid #3b82f6; border-radius: 6px; padding: 20px; text-align: center; margin: 20px 0;">
      <div style="font-size: 16px; color: #1e3a8a; margin-bottom: 10px; font-weight: bold;">
        총 납부금액
      </div>
      <div style="font-size: 28px; font-weight: bold; color: #1e3a8a; margin-bottom: 5px; font-family: 'Courier New', monospace;">
        <fmt:formatNumber value="${taxMap.TX_TAX_AMOUNT}" type="number" groupingUsed="true" /> 원
      </div>
    </div>
    <div style="background: linear-gradient(135deg, #fee2e2, #fecaca); border: 1px solid #ef4444; border-radius: 4px; padding: 16px; text-align: center; margin: 20px 0;">
	  <div style="font-size: 16px; color: #991b1b; margin-bottom: 10px; font-weight: bold;">
	    기한 초과시 가산세 합계금액
	  </div>
	  <div style="font-size: 26px; font-weight: bold; color: #991b1b; margin-bottom: 5px; font-family: 'Courier New', monospace;">
		<fmt:formatNumber value="${(taxMap.TX_TAX_AMOUNT * 103 div 100)}" type="number" groupingUsed="true" /> 원
	  </div>
	</div>

    <!-- 중요 안내사항 -->
    <div style="background: #fefce8; border: 1px solid #facc15; border-radius: 6px; padding: 16px; margin: 20px 0;">
      <div style="font-size: 14px; font-weight: bold; color: #a16207; margin-bottom: 10px;">⚠️ 중요 안내사항</div>
      <ul style="list-style: none; color: #a16207; padding-left: 0; margin: 0;">
        <li style="margin-bottom: 6px; padding-left: 16px; position: relative;">
          <span style="position: absolute; left: 0; font-weight: bold;">•</span>
          납부기한 내에 납부하지 않을 경우 가산세가 부과됩니다.
        </li>
        <li style="margin-bottom: 6px; padding-left: 16px; position: relative;">
          <span style="position: absolute; left: 0; font-weight: bold;">•</span>
          납부는 인터넷뱅킹, 은행 방문, 또는 관세청 전자통관시스템을 통해 가능합니다.
        </li>
        <li style="margin-bottom: 6px; padding-left: 16px; position: relative;">
          <span style="position: absolute; left: 0; font-weight: bold;">•</span>
          문의사항은 해당 세관으로 연락하시기 바랍니다.
        </li>
        <li style="padding-left: 16px; position: relative;">
          <span style="position: absolute; left: 0; font-weight: bold;">•</span>
          본 고지서는 관세법에 의거하여 발행되었습니다.
        </li>
      </ul>
    </div>

    <!-- 푸터 -->
    <div style="background: #f8fafc; padding: 14px; text-align: center; border-top: 1px solid #e2e8f0; font-size: 12px; color: #64748b;">
      <p style="color: black; margin: 2px 0;"><strong>대한민국 관세청</strong> | 전화: 125 (관세청 콜센터)</p>
      <p style="color: black; margin: 2px 0;">홈페이지: www.customs.go.kr</p>
      <p style="color: black; margin: 2px 0;">
        발행일시:
        <jsp:useBean id="now" class="java.util.Date" />
        <fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일 HH:mm" />
      </p>
    </div>
    <c:if test="${princ.user.authCode.equals(\"ROLE_CCA\")}">
	    <c:if test="${taxMap.TX_TAX_YN eq '0'}">
		    <div style="max-width: 800px; text-align: center;">
			    <div class="btn-container">
					<input type="button" id="taxBtn" value="결제하기"/>
				</div>
		  	</div>
	    </c:if>
    </c:if>
  </div>
</body>
<script>
	$(document).ready(function () {
		// 결제하기 버튼 클릭 시
		$("#taxBtn").on("click", function() {
			// 내일 날짜 구하기 - 납부기한 내인지 확인하기 위해
			let today = new Date();
			let tomorrow = new Date();
			tomorrow.setDate(today.getDate() +1);
			
			// 납부기한
			let taxDeadlineDate = new Date("<fmt:formatDate value="${taxMap.TX_TAX_DEADLINE_DATE}" pattern="yyyy-MM-dd" />");
	
			// 납부기한 내에 진행하는 결제면 납부후금액으로, 아니면 납기후금액으로 금액 저장
			let taxRealAmount = (taxDeadlineDate < tomorrow) ? ${taxMap.TX_TAX_AMOUNT} : ${(taxMap.TX_TAX_AMOUNT * 103 div 100)};
			
			let taxData = {
				"taxNo"			: "${taxMap.TX_TAX_NO }",
				"taxRealAmount"	: taxRealAmount,
				"declNo"		: "${taxMap.DECL_NO}",
				"contractNo"	: "${taxMap.CONTRACT_NO }"
			}
			
			// 카카오페이 결제 화면 요청
			$.ajax({
	            type: 'POST',
	            url: '/contract/taxReady',
	            data: JSON.stringify(taxData),
	            contentType: 'application/json',
	            success: function(result) {
	            	console.log(result);
	            	if (window.opener) {
                        window.opener.location.href = result.next_redirect_pc_url;
                        window.close();
                    } else {
                        window.location.href = result.next_redirect_pc_url;
                    }
	            }
	        });
		});
	
	});
</script>
</html>