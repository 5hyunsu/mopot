<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="${path}/resources/css/member/joinPage.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <title>JOIN</title>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/Common/header.jsp" />

	<!-- 회원 가입 페이지 -->
    <form action="joinMember" method="post" class="joinForm" onsubmit="return valid();">
        <h2>회원 가입</h2>

        <div class="join_text">
            <input name="userId" id="userId" required>
            <label>아이디(ID)</label>
            <input type="button" value="ID중복확인" onclick="idCheck();" id="idbtn">
            <div id="checkResult" style="font-size: 0.8em; display: none; margin: 3px"></div>
        </div>
        <div class="join_text">
            <input name="userPw" type="password" class="pw" id="pw">
            <label>비밀번호</label>
        </div>
        <div class="join_text">
            <input name="userRePw" type="password" class="rePw" id="rePw">
            <label>비밀번호 확인</label>
        </div>
        <div class="join_text">
            <input name="userName" class="name" id="name">
            <label>이름</label>
        </div>
        <div class="join_text">
            <input name="userEmail" class="email" id="email">
            <label>이메일(Email)</label>
        </div>
        <div class="join_button">
            <input class="re" type="reset" value="다시쓰기">
            <input class="sub" type="submit" value="가입하기">
        </div>
    </form>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/Common/footer.jsp" />
    
    <!-- ID 중복 체크 -->
    <script>
 		let submitCheck = false;
		
		function valid() {
			// 중복체크가 되면 true = 회원가입 버튼 동작
		    if(submitCheck) {
		        return true;
		    } else { // 중복체크 x = 회원가입 누르면 뜸(가입 버튼 동작 x)
		        alert('ID 중복 체크 확인해주세요.'); 
		        return false; 
		    }
		}
		
		function idCheck() {
		    $.ajax({
		    	url: "idCheck",
		    	data: { id: $('#userId').val() },
		    	success: function(data) {
		    		console.log(data);
		    		
		    		if(data) {
		    			alert("사용할 수 없는 ID 입니다.");
		    			
		    			submitCheck = false;
		    			
		    			$("#checkResult").show();
						$("#checkResult").css("color","red").text("중복된 아이디가 존재합니다. 다시 입력해 주세요");   
						$("#enrollForm :submit").attr("disabled", true);
		    		} else {
		    			alert("사용 가능한 ID 입니다.");
		    			
		    			submitCheck = true;
		    			
		    			$("#checkResult").show();
						$("#checkResult").css("color","green").text("사용할 수 있는 아이디 입니다");   
						$("#enrollForm :submit").attr("disabled", false);
		    		}
		    	},
		    	error: function() {
		    		console.log("아이디 중복체크용 AJAX 통신 실패");
		    	}
		    })
				}
	</script>
</body>
</html>