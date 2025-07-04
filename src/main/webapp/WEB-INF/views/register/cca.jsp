<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="mb-3">
		<label for="cca_name" class="form-label">관세사 사무소명</label><br /> 
		<input type="text" id="ccaName" name="ccaVO.ccaName" class="form-control" placeholder="관세사명">
	</div>
	<div class="mb-3">
		<label for="cca_registration_number" class="form-label">관세사등록번호</label><br />
		<div class="input-group">
			<input type="text" id="ccaRegistrationNumber" name="ccaVO.ccaRegistrationNumber" class="form-control" placeholder="관세사등록번호">
			<button type="button" id="checkCCA" name="checkCCA" class="btn btn-outline-secondary">관세사 등록체크</button>
			<span id="alarmCCA" class="form-text"></span>
		</div>
	</div>
	<div class="mb-3">
		<label for="cca_tel" class="form-label">관세사 사무소 전화번호</label> <br /> 
		<input type="text" name="ccaVO.ccaTel" id="ccaTel" class="form-control" placeholder="관세사 사무소 전화번호">
	</div>

	<div class="mb-3">
		<label for="zipcode" class="form-label">우편번호</label>
		<div class="input-group">
			<input type="text" id="zipcode" name="ccaVO.ccaPost" class="form-control" readonly placeholder="우편번호">
			<button type="button" id="zipbtn" class="btn btn-success btn-sm">우편번호찾기</button>
		</div>
	</div>
	<div class="mb-3">
		<label for="addr1" class="form-label">기본주소</label> <br /> 
		<input type="text" name="ccaVO.ccaAddr" id="ccaAddr" class="form-control" placeholder="기본주소" readonly>
	</div>
	<div class="mb-3">
		<label for="addr2" class="form-label">상세주소</label> <br /> 
		<input type="text" name="ccaVO.ccaDetAddr" id="ccaDetAddr" class="form-control" placeholder="상세주소">
	</div>
	<div class="mb-3">
		<label for="profileImg" class="form-label">프로필이미지</label><br />
		<input type="file" name="ccaVO.ccapfImg" id="ccaProfileImg" class="form-control" accept="image/*">
		<small class="form-text text-muted">권장 이미지 크기: 200x200px</small>
    	<div class="mt-2">
        	<img id="imagePreview" src="#" alt="이미지 미리보기" style="max-width: 150px; max-height: 150px; border: 1px solid #ddd; display: none;">
    	</div>
	</div>
	<script type="text/javascript">
$(function(){
//---------------------------------------------------------------------]
//  관세사 등록 체크 
	$('#checkCCA').on('click',()=>{
		const regnum = $('#ccaRegistrationNumber').val().replaceAll('-','');
		const ccaName = $('#name').val().trim();
		console.log('regnum',regnum)
		if (!regnum) {
			$('#alarmCCA').html('관세사 등록번호를 입력해주세요.').css('color', 'red');
			$('#ccaRegistrationNumber').focus();
			return;
		}
		if(!ccaName) {
			$('#alarmCCA').html('관세사 이름을 입력해주세요.').css('color', 'red');
			$('#name').focus();
			return;
		}
		
		 const apiUrl = "http://localhost:8080/api/unipass/checkCustomsBroker?lcaSgn="+regnum+"&lcaNm="+ccaName;

					
		$.ajax({
			url: apiUrl,
			type: "GET",
//			contentType: "application/xml; charset=utf-8", // 프록시 서버로 보낼 데이터가 XML임을 명시
			dataType: "xml", // 프록시 서버로부터 받을 응답 데이터가 XML임을 명시 (jQuery 자동 파싱)
//			data: requestXml, // XML 문자열을 전송 데이터로 설정
			success: function(xmlDoc) {
				console.log("Unipass API로부터 받은 원본 XML 응답:", xmlDoc);
				
				const tCnt = $(xmlDoc).find('tCnt').text();
				
/* 
			    let isRegistered = false;
			    let foundName = '';

			    // 네이티브 DOM 메서드 사용 예시 (xmlDoc는 이미 DOM Document 객체)
			    const cbrcList = xmlDoc.getElementsByTagName('lcaLstInfoQryRsltVo'); // 예시 태그명
			    for (let i = 0; i < cbrcList.length; i++) {
			        const cbrcElement = cbrcList[i];
			        const apiLcaSgnElement = cbrcElement.getElementsByTagName('lcaSgn')[0];
			        const apiLcaNmElement = cbrcElement.getElementsByTagName('lcaNm')[0];

			        const apiLcaSgn = apiLcaSgnElement ? apiLcaSgnElement.textContent : '';
			        const apiLcaNm = apiLcaNmElement ? apiLcaNmElement.textContent : '';

			        if (apiLcaSgn === regnum && apiLcaNm === ccaName) {
			            isRegistered = true;
			            foundName = apiLcaNm;
			            break; // 일치하는 항목을 찾으면 루프 종료
			        }
			    } */

			    if (tCnt > 0) {
			        $('#alarmCCA').html('등록된 관세사입니다').css('color', 'blue');
			    } else {
			        $('#alarmCCA').html('미등록 관세사이거나 정보가 일치하지 않습니다.').css('color', 'red');
			    }
			},
			error: function(jqXHR, textStatus, errorThrown) {
				// 오류 발생 시 처리
				console.error("AJAX 오류:", jqXHR.status, textStatus, errorThrown);
				console.error("응답 텍스트:", jqXHR.responseText);

				$('#alarmCCA').html('관세사 등록 확인 중 오류가 발생했습니다.').css('color', 'red');

				// 스프링 부트 프록시 서버에서 에러 응답을 XML로 보냈을 때 파싱 시도
				try {
					const errorXmlDoc = $.parseXML(jqXHR.responseText);
					// 스프링 부트 컨트롤러의 에러 응답 구조에 따라 'error message' 태그를 찾음
					const proxyErrorMessage = $(errorXmlDoc).find('error message').text();
					if (proxyErrorMessage) {
						$('#alarmCCA').html(`오류: ${proxyErrorMessage} (HTTP Status: ${jqXHR.status})`).css('color', 'red');
					}
				} catch (e) {
					console.error("오류 응답 XML 파싱 실패:", e);
					$('#alarmCCA').html(`오류 발생: ${textStatus} (HTTP Status: ${jqXHR.status})`).css('color', 'red');
				}
			}
		});
	});
//-------------------------------------------------------------------------------

});
</script>
</body>
</html>