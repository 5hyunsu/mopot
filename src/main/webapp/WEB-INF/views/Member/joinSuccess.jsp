<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="${path}/resources/css/member/joinSuccess.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<title>Welcome MoPot</title>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/Common/header.jsp" />

	<!-- 회원 가입 성공 시 -->
	<form action="joinSuccess">
		<div id="success_text">
			<h3>ooo님 환영합니다!</h3>
		</div>
		<div>
			<img id="success_img">
		</div>
		<div id="success_btn">
			<button class="sbtn" type="button" onclick="location.href='/'">홈으로</button>
		</div>
	</form>

	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/Common/footer.jsp" />
</body>
</html>