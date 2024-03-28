<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="${path}/resources/css/member/rePwdPage.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <title>rePwdPage</title>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/Common/header.jsp" />

    <div id="mypage_menu">
        <a href="myPage">내 정보</a>
        <a href="rePwdPage">비밀번호 변경</a>
        <a href="conList">작성/신청한 글</a>
    </div>

    <form action="rePwd" method="post" class="rePwdForm">
        <div class="pwdInput">
            <label>변경 전 비밀번호</label>
            <input type="password" name="userPw" id="userPw">
        </div>
        <div class="pwdInput">
            <label>변경 후 비밀번호</label>
            <input type="password" name="userRePw" id="userRePw">
        </div>
        <div class="rePwd_btn">
            <input type="submit" class="pw_edit" value="수정하기">
        </div>
    </form>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/Common/footer.jsp" />
</body>
</html>
