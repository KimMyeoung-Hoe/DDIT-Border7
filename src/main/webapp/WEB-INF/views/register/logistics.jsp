<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>물류관리자부분</title>
</head>
<body>
	<div class="mb-3">
		<label for="logistics_name" class="form-label">등록사업자명</label><br>
		<input type="text" id="logisticsName" name="LogistMngVO.logistMngName" class="form-control" placeholder="사업자명">
	</div>
	<div class="mb-3">
		<label for="logisticsNumber" class="form-label">사업자등록번호</label>
		<div class="input-group">
			<input type="text" id="logisticsNumber" name="LogistMngVO.businessNumber" class="form-control" placeholder="사업자등록번호">
			<button type="button" id="checkLogistics" name="checkLogistics" class="btn btn-outline-secondary">사업자 등록체크</button>
			<span id="alarmLogistics" class="form-text"></span>
		</div>
	</div>
	<div class="mb-3">
		<label for="cca_tel" class="form-label">업체 전화번호</label> <br /> 
		<input type="text" name="logistMngVO.logistMngTel" id="logistMngTel" class="form-control" placeholder="관세사 사무소 전화번호">
	</div>
	
	<div class="mb-3">
		<label for="zipcode" class="form-label">우편번호</label>
		<div class="input-group">
			<input type="text" id="zipcode" name="LogistMngVO.logistMngPost" class="form-control" readonly placeholder="우편번호">
			<button type="button" id="zipbtn" class="btn btn-success btn-sm">우편번호찾기</button>
		</div>
	</div>
	<div class="mb-3">
		<label for="addr1" class="form-label">기본주소</label> <br/>
		<input type="text" name="LogistMngVO.logistMngDetAddr" id="logisticsAddr" class="form-control" placeholder="기본주소" readonly>
	</div>
	<div class="mb-3">
		<label for="addr2" class="form-label">상세주소</label> <br/>
		<input type="text" name="LogistMngVO.logistMngDetAddr" id="logisticsDetAddr" class="form-control" placeholder="상세주소">
	</div>
		<div class="mb-3">
		<label for="profileImg" class="form-label">프로필이미지</label> <br/>
		<input type="file" name="LogistMngVO.logisticspfImg" id="logisticsProfileImg" class="form-control" accept="image/*">
		<small class="form-text text-muted">권장 이미지 크기: 200x200px</small>
    	<div class="mt-2">
        	<img id="imagePreview" src="#" alt="이미지 미리보기" style="max-width: 150px; max-height: 150px; border: 1px solid #ddd; display: none;">
    	</div>
	</div>
	<script type="text/javascript">
$(function(){
//-------------------------------------------------------------------------
	// 사업자 등록정보 API 활용
	$('#checkLogistics').on('click',()=>{
		const regnum = $('#logisticsNumber').val().replaceAll('-','');
		
		const reg = {
				"b_no" : [regnum],				
		};
		$.ajax({
	 		url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=xxxx",  // serviceKey 값을 xxxxxx에 입력
		   type: "POST",
    	   data: JSON.stringify(reg), // json 을 string으로 변환하여 전송
 	   dataType: "JSON",
	contentType: "application/json",
 		 accept: "application/json",
  		success: function(result) {
				   if(result.match_cnt>0){
					   console.log(result);
					   $('#alarmLogistics').html('등록된사업자입니다').css('color', 'blue');
		            } else {
		               $('#alarmLogistics').html('미등록사업자입니다').css('color', 'red');
		               $('#logisticsNumber').focus();
		            }
				  },
			error: function(result) {
				console.log(result.responseText); //responseText의 에러메세지 확인
			}
		});
	});
//-------------------------------------------------------	
})
</script>
</body>
</html>
