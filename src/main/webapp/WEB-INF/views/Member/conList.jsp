<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${path}/resources/css/member/conList.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <title>MyConList</title>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/Common/header.jsp" />

    <div id="mypage_menu">
        <a href="myPage">내 정보</a>
        <a href="rePwdPage">비밀번호 변경</a>
        <a href="conList">작성/신청한 글</a>
    </div>

    <!-- 마이페이지(myPage) - 작성 / 신청한 글 -->
    <form action="myPageConList" method="post" class="contentForm">
        <div class="con_list">
            <label>내가 작성한 글</label>
            <table class="conForm">
                <thead>
                    <tr class="listTitle">
                        <th>글 번호</th>
                        <th>제목</th>
                        <th>댓글 수</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>TestTestTestTestTestTestTestTest</td>
                        <td>123</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="status_list">
            <label>내가 신청한 글</label>
            <table id="statusForm">
                <thead>
                    <tr class="listTitle">
                        <th>글 번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>신청 현황</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>22</td>
                        <td>TestTestTestTest</td>
                        <td>admin</td>
                        <td>1 / 1000</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/Common/footer.jsp" />
</body>
</html>