<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${path}/resources/css/Member/myPage.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <title>MyPage</title>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/Common/header.jsp" />

    <div id="mypage_menu">
        <a href="myPage">내 정보</a>
        <a href="rePwdPage">비밀번호 변경</a>
        <a href="conList">작성/신청한 글</a>
    </div>

    <!-- 마이페이지 정보 -->
    <form action="myPageInfo" method="post" class="myPageForm" onsubmit="return valid();">
        <div class="mypage_info">
            <img id="img">
        </div>
        <div class="mypage_info">
            <label>닉네임</label>
            <input name="userNick" id="userNick" value="${ loginUser.userNick }">
            <input type="button" value="중복확인" onclick="nickCheck();" id="nickbtn">
            <div id="checkResult" style="font-size: 0.8em; display: none; margin: 3px"></div>
        </div>
        <div class="mypage_info">
            <label>아이디(ID)</label>
            <input name="userId" id="userId" value="${ loginUser.userId }" readonly>
        </div>
<%--        <div class="mypage_info">
            <label>비밀번호</label>
            <input type="password" name="userPw" id="userPw">
        </div>
--%>
        <div class="mypage_info">
            <label>이메일(Email)</label>
            <input name="userEmail" id="userEmail" value="${ loginUser.userEmail }">
        </div>
        <div class="mypage_info">
            <label>생년월일</label>
            <input name="userBirthday" id="userBirthday" value="${ loginUser.userBirthday }">
        </div>
        <div class="mypage_info" id="user_gender">
            <label>성별</label>
            <input type="radio" name="userGender" value="1"
                <c:choose>
                    <c:when test="${loginUser.userGender eq '1'}"> checked </c:when>
                </c:choose>
            > 남
            <input type="radio" name="userGender" value="2"
                <c:choose>
                    <c:when test="${loginUser.userGender eq '2'}"> checked </c:when>
                </c:choose>
            > 여
        </div>
        <div class="mypage_btn">
            <input type="button" class="my_delete" onclick="mDelete();" value="탈퇴하기">
            <input type="submit" class="my_edit" value="수정하기">
        </div>
    </form>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/Common/footer.jsp" />
    
    <!-- 닉네임 중복 체크 -->
    <script>
	    let submitCheck = false;

        // 중복체크 여부 확인
		function valid() {
			// 중복체크가 되면 true = 회원가입 버튼 동작
		    if(submitCheck) {
		        return true;
		    } else { // 중복체크 x = 회원가입 누르면 뜸(가입 버튼 동작 x)
		        alert('닉네임 중복 확인해주세요.');
		        return false; 
		    }
		}

        // 닉네임 중복 여부 확인
        function nickCheck() {
		    $.ajax({
		    	url: "nickCheck",
		    	data: { nick: $('#userNick').val() },
		    	success: function(data) {
		    		console.log(data);
		    		
		    		if(data) {
		    			alert("사용할 수 없는 닉네임 입니다.");
		    			
		    			submitCheck = false;
		    			
		    			$("#checkResult").show();
						$("#checkResult").css("color","red").text("중복된 닉네임이 존재합니다. 다시 입력해 주세요");   
						$("#enrollForm :submit").attr("disabled", true);
		    		} else {
		    			alert("사용 가능한 닉네임 입니다.");
		    			
		    			submitCheck = true;
		    			
		    			$("#checkResult").show();
						$("#checkResult").css("color","green").text("사용할 수 있는 닉네임 입니다");   
						$("#enrollForm :submit").attr("disabled", false);
		    		}
		    	},
		    	error: function() {
		    		console.log("닉네임 중복체크용 AJAX 통신 실패");
		    	}
		    })
        }

        // 회원탈퇴
        function mDelete() {
            $.ajax({
                url: "mDelete",
                data: { id: "${loginUser.userId}" },
                type: "post",
                success: function(data) {
                    consloe.log(data);

                    alert("MoPot Site를 이용해주셔서 감사합니다.");

                    location.href="/";
                },
                error: function() {
                    alert("회원 탈퇴에 실패했습니다.");

                    location.reload();
                }
            })
        }
	</script>
</body>
</html>