<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="../../../resources/css/content/form.css" rel="stylesheet" />
    <script src="/webjars/jquery/3.7.1/jquery.min.js"></script>
    <!-- 알림창 alert 꾸미기 (아래 1줄) -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.all.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.min.css" rel="stylesheet">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글쓰기</title>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/Common/header.jsp" />

    <div id="writeForm">
        <form action="insertForm" method="post" class="contentForm">
            <div class="writeFormHead">
                <div class="writeFormHeadLeft">
                    <h4>말머리</h4>
                    <select id="conCategory" class=conCategory name="conCategory">
                        <option disabled selected>선택해주세요</option>
                        <optgroup label="공지">
                            <option value="공지사항">공지사항</option>
                        </optgroup>
                        <optgroup label="운동">
                            <option value="야구">야구</option>
                            <option value="농구">농구</option>
                            <option value="축구">축구</option>
                        </optgroup>
                        <optgroup label="스터디">
                            <option value="코딩">코딩</option>
                            <option value="영어회화">영어회화</option>
                        </optgroup>
                    </select>
                </div>
                <div class="writeFormHeadRight">
                    <h4>제목</h4>
                    <textarea id="conTitle" class="conTitle" name="conTitle" placeholder="내용을 입력해 주세요"></textarea>
                </div>
            </div>
            <div class="writeFormBody">
                <br>
                <hr>
                <h4>내용</h4>
                <textarea id="conDetail" class="conDetail" name="conDetail" rows="10" cols="30" placeholder="글 내용 입력해주세요"></textarea>
            </div>
            <div class="writeFormTag">
                <h4>태그</h4>
                <textarea class="conTag" name="conTag" cols="30" placeholder="#응원구단"></textarea>
            </div>
            <!-- 임시 -->
            <div class="conWriter">
                <h4>작성자</h4>
                <input id="conWriter" type="text" name="conWriter" placeholder="작성자" />
            </div>
            <!-- 임시 -->
            <br>
            <div class="writeFromFoot">
            	 
                <button type="submit" id="writeButton" class="write-btn" >작성</button>
                <button type="reset" class="reset-btn">초기화</button>
                <button type="button" onclick="location.href='list' " class="list-btn">취소</button>
            </div>
            <br>
        </form>
    </div>
    
    <!-- 폼 입력칸 모두 채워야지 넘어가게끔  -->
	<script type="text/javascript">
	    document.getElementById("writeButton").addEventListener("click", function() {
	        var conTitle = document.getElementById("conTitle").value;
	        var conDetail = document.getElementById("conDetail").value;
	        var conWriter = document.getElementById("conWriter").value;
	        var conCategory = document.getElementById("conCategory").value;
	        
	        if (!conTitle || !conDetail || !conWriter || !conCategory) {
	        	Swal.fire({
	               /*  icon: 'question',
	                title: '폼 모두 입력',
	                text: '말머리, 제목, 내용, 작성자를 빠짐없이 입력해주세요',
	                timer: 1500 */
	                
	                title: "글이 비었음",
                    text: "말머리/제목/내용 등을 입력해주세요.",
                    icon: "question"
	            });
	            event.preventDefault();
	        } else {
	           form.submit();
	        }
	    });
	</script>
    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/Common/footer.jsp" />
</body>
</html>
