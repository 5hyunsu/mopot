<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="${path}/resources/css/common/header.css">
</head>
<body>
<header>
    <nav class="headerAll">

        <a class="navbar-brand" href="<%= request.getContextPath() %>/">MoPot</a> <!-- 홈페이지 메인 링크 걸기 -->

        <!-- <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
            <span class="navbar-toggler-icon"></span>
        </button> -->

        <div class="collapse navbar-collapse" id="collapsibleNavbar">
            <div class="nav-item">
                <a class="nav-link" href="pot">팟구하기</a>
                <a class="nav-link" href="list">자유게시판</a>
            </div>
        </div>

        <!-- if문 넣어서 로그인 전/후 아이콘 변경 -->
        <c:choose>
            <c:when test="${empty loginUser}">
                <!-- 사용자가 로그인하지 않은 경우 -->
                <div id="head-icon">
                    <a class="nav-link" href="loginPage">로그인</a>
                    <a class="nav-link" href="joinPage">회원가입</a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 사용자가 로그인한 경우 -->
                <div id="head-icon">
                    <p>${loginUser.userId} 님 환영합니다. ヾ(˹ᆺ˺✿)ﾉﾞ</p>

                    <a href="logout">로그아웃</a>
                    <a href="myPage">마이페이지</a>
                </div>
            </c:otherwise>
        </c:choose>
    </nav>
</header>
</body>
</html>