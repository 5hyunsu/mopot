<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="${path}/resources/css/member/loginPage.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <title>LOGIN</title>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/Common/header.jsp" />

	<!-- 로그인 페이지 -->
    <form action="loginMember" method="post" class="loginForm">
        <h2>로그인</h2>

        <div class="login_text">
            <input name="userId" class="id" required>
            <label id="id">아이디(ID)</label>
        </div>
        <div class="login_text">
            <input name="userPw" type="password" class="pw">
            <label id="pw">비밀번호</label>
        </div>
        <div class="login_button">
            <button class="sub" type="submit">로그인</button>
        </div>
        <div class="joinPage_a">
            <a href="joinPage">회원가입</a>
            <a href="">아이디/비번 찾기</a>
        </div>
    </form>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/Common/footer.jsp" />
</body>
</html>