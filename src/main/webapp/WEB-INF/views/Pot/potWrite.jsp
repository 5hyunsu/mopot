<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="/src/main/webapp/resources/js/tag.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script src="/src/main/webapp/resources/js/comentBytes.js"></script>
    <!-- css 적용 -->
	<link rel="stylesheet" href="../../../resources/css/pot/potWrite.css">
    <!-- 알림창 alert 꾸미기 (아래 3줄) -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.all.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.min.css" rel="stylesheet">
    
    
    <title>모집 글 작성</title>
    <style>
        textarea {
            resize: none;
        }
    </style>
</head>
<body>
    <!-- 헤더 부분 -->
    <jsp:include page="/WEB-INF/views/Common/header.jsp" />

    <%-- <form action="potWrite" method="post" class="potcontentForm">
        <!-- 닉네임(지정값 불러오기) -->
        <label for="nickname">작성자 : ${ loginUser.username }</label>
        <br><br> --%>

       <!-- 본문 -->
       <div id="writeForm">
       <form action="insertPotForm" method="post" class="potContentForm">
           <div class="potWriteFormHead">
               <div class="potWriteFormHeadLeft">
                   <h4>말머리</h4>
                   <select id="potCategory" class=potCategory name="potCategory">
                       <option disabled selected>선택해주세요</option>
                       <optgroup label="공지">
                           <option value="공지사항">공지사항</option>
                       </optgroup>
                       <optgroup label="운동">
                           <option value="야구">야구</option>
                           <option value="농구">농구</option>
                           <option value="축구">축구</option>
                           <option value="당구">축구</option>
                           <option value="배드민턴">배드민턴</option>
                           <option value="테니스">테니스</option>
                           <option value="수영">수영</option>
                           <option value="헬스">헬스</option>
                       </optgroup>
                       <optgroup label="IT">
                           <option value="자바">자바</option>
                           <option value="SQL">SQL</option>
                           <option value="html/css">html/css</option>
                           <option value="자바스크립트">자바스크립트</option>
                           <option value="JSP">JSP</option>
                           <option value="DB">DB</option>
                           <option value="스프링">스프링</option>
                           <option value="리액트">리액트</option>
                           <option value="엘라스틱서치">영어회화</option>
                           <option value="빅데이터">빅데이터</option>
                       </optgroup>
                       <optgroup label="스터디">
                           <option value="독서">독서</option>
                           <option value="영어회화">영어회화</option>
                       </optgroup>
                       <optgroup label="기타">
                           <option value="기타">기타</option>
                       </optgroup>
                   </select>
               </div>
               <div class="potWriteFormHeadRight">
               <!-- 제목 -->
                   <h4>제목</h4>
                   <textarea id="potTitle" class="potTitle" name="potTitle" placeholder="내용을 입력해 주세요"></textarea>
               </div>
           </div>
           <div class="potWriteFormBody">
           	
               <h4>내용</h4>
               <textarea id="potDetail" class="potDetail" name="potDetail" rows="10" cols="30" placeholder="폼 내용 입력해주세요"></textarea>
           </div>
           <div class="writeFormTag">
               <h4>태그</h4>
               <textarea class="potTag" name="potTag" cols="30" placeholder="#태그"></textarea>
           </div>
           <!-- 임시 -->
           <div class="potWriter">
               <h4>작성자</h4>
               <input id="potWriter" type="text" name="potWriter" placeholder="작성자" />
           </div>
           <!-- 임시 -->
           <div class="potTotalHeadcount">
           	<!-- 총인원수 기본값: 1명  최대값 100명 최소값 1명-->
               <h4>총인원수</h4>
               <input id="potTotalHeadcount"  type="number" name="potTotalHeadcount" value="1" min="1" max="100" />
           </div>
           <div class="potNowHeadcount">
          	<!-- 현재인원수 기본값: 1명  최대값 100명 최소값 1명-->
               <h4>현재인원수</h4>
               <input id="potNowHeadcount" type="number" name="potNowHeadcount" value="1" min="1" max="{#potTotalHeadcount}"/>
           </div>
           <div class="potEndTime">
          	<!-- 마감시간 최소 : 현재이후  최대 : ? -->
               <h4>마감시간</h4>
               <input id="potEndTime" type="datetime-local" name="potEndTime"  value="now" min="" max=""/>
           </div>
           <div class="potStartTime">
          	<!-- 시작시간 최소 : 지금부터 ~ 최대 : 마감시간 전까지 -->
               <h4>시작시간</h4>
               <input id="potStartTime" type="datetime-local" name="potStartTime"  value="now" min="" max=""/>
           </div>
            <div class="potPlace">
          	<!-- 모임장소 place 표현 -->
               <h4>모임장소</h4>
               <input id="potPlace" type="input" name="potPlace"  placeholder="장소를 입력해주세요" min="" max=""/>
           </div>
           <div class="potWriteFromFoot">
           	   <button type="submit" id="potWriteButton" class="write-btn" >작성</button>
               <button type="reset" class="reset-btn">초기화</button>
               <button type="button" onclick="location.href='pot' " class="list-btn">취소</button>
           </div>
           <br>
       </form>
   	</div>
  
        </input>
        
        
        
        
        
        
    <!-- 총인원수를 조정해서  현재인원수 max값으로 변경함   -->  
   	<script> 
    // 총인원수 입력 필드를 선택
    var totalHeadcount = document.getElementById('potTotalHeadcount');
    
    // 현재인원수 입력 필드를 선택
    var nowHeadcount = document.getElementById('potNowHeadcount');

    // 총인원수 입력 필드에 이벤트 리스너를 추가하여 변경사항을 감지
    totalHeadcount.addEventListener('input', function() {
        // 현재인원수 입력 필드의 max 속성을 총인원수 입력 필드의 값으로 설정
        nowHeadcount.max = totalHeadcount.value;
    });
	</script>
	
	<!-- 시작시간, 마감시간을 현재로 설정  -->
	<script>
  		document.getElementById('potStartTime').value= new Date().toISOString().slice(0, 16);
  		document.getElementById('potEndTime').value= new Date().toISOString().slice(0, 16);
	</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
       <!-- 푸터 부분 -->
    <jsp:include page="/WEB-INF/views/Common/footer.jsp" />
</body>
</html>
