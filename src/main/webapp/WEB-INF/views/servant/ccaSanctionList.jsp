<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="<%= request.getContextPath() %>/lib/jQuery/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" href="/css/main.css">
	<style type="text/css">
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
	.container{
		margin-top: 100px;
		margin-left: 300px;
	}
	</style>
</head>
<body>
	<%@ include file="../modules/sidebar.jsp" %>
	<div class="header">
		<%@ include file="../modules/header.jsp" %>
	</div>
<div class="app-container">
	<main class="main-content-area">
		<div class="container">
			제재이력(관세사별) 조회 화면
		</div>
		<br/>
		
		<select>
			<option value="관세사식별번호">관세사식별번호</option>
			<option value="관세사ID">관세사ID</option>
			<option value="관세사명">관세사명</option>
		</select>
		<input type="text" placeholder="검색 키워드"><br/>
		행 클릭 시 sanctionList/{해당관세사식별번호} 검색 조건 반영된 화면으로 이동되게 구현 예정<br/>
		<table>
			<tr>
				<th>관세사식별번호</th>
				<th>관세사ID</th>
				<th>관세사명</th>
				<th>총업무건수</th>
				<th>총제재발생건수</th>
				<th>누적오류점수</th>
				<th>제재비율</th>
				<th>최근제재발생일시</th>
			</tr>
			<tr>
				<td>1</td>
				<td>cca001</td>
				<td>보더관세사</td>
				<td>187건</td>
				<td>5건</td>
				<td>60점</td>
				<td>5.0%</td>
				<td>2025.06.02</td>
			</tr>
			<tr>
				<td>2</td>
				<td>cca002</td>
				<td>대덕관세사</td>
				<td>90건</td>
				<td>0건</td>
				<td>0점</td>
				<td>0.0%</td>
				<td></td>
			</tr>
			<tr>
				<td>3</td>
				<td>cca003</td>
				<td>우정관세사</td>
				<td>5건</td>
				<td>5건</td>
				<td>50점</td>
				<td>100.0%</td>
				<td>2025.06.03</td>
			</tr>
		</table>
		이전 1 2 3 4 5 다음
	</main>
</div>

			
</body>
</html>