<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="/webjars/jquery/3.7.1/jquery.min.js"></script>
	<title>팟 구하기 리스트</title>
	<!-- css 적용 -->
	<link rel="stylesheet" href="../../../resources/css/pot/pot.css">
	<!-- 알림창 alert 꾸미기 (아래줄) -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.all.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.min.css" rel="stylesheet">
	
</head>
<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/Common/header.jsp" />

	<!-- 페이지 전체 적용 -->
	<section class="pot">
	
	<!-- Title : 팟 리스트(모음) -->
	<div class="pot-title">
        <h2 class="title"><a href="http://localhost:8080/pot">팟 모음 </a></h2>
   	</div>
    <!-- 총 게시물 수 :  -->
	<div class="pot-count">
        <c:out value="현재 진행 되는 팟 : ${potPage.totalElements}" />
    </div>
    
    <!-- 상단 검색파트 -->
    <div class="content-foot-head">
        <form action="list" method="get">
            <div class="search-wrap">
                <!-- (1) 운동 select option-->
                <select name="searchType" id="selectCategorySport"  class="search-select" onchange="changeCategory()">
                    <option disabled selected>운 동</option>
                    <optgroup label="운동">
	                    <option value="baseball" ${searchType=='conTitle' ? 'selected': ''}>야구</option>
	                    <option value="basketball" ${searchType=='conTitle' ? 'selected': ''}>농구</option>
	                    <option value="soccer" ${searchType=='conTitle' ? 'selected': ''}>축구</option>
	                    <option value="Billiards" ${searchType=='conTitle' ? 'selected': ''}>당구</option>
	                    <option value="badminton" ${searchType=='conTitle' ? 'selected': ''}>배드민턴</option>
	                    <option value="tennis" ${searchType=='conTitle' ? 'selected': ''}>테니스</option>
	                    <option value="swimming" ${searchType=='conTitle' ? 'selected': ''}>수영</option>
	                    <option value="health" ${searchType=='conTitle' ? 'selected': ''}>헬스</option>
	                </optgroup>
                </select>
                <!-- (2) IT  select option-->
                <select name="searchType" id="selectCategoryIT"  class="search-select" onchange="changeCategory()">
                    <option disabled selected>IT공부</option>
                    <optgroup label="IT">
	                    <option value="자바" ${searchType=='conTitle' ? 'selected': ''}>자바</option>
	                    <option value="SQL" ${searchType=='conTitle' ? 'selected': ''}>SQL</option>
	                    <option value="html/css" ${searchType=='conTitle' ? 'selected': ''}>html/css</option>
	                    <option value="자바스크립트" ${searchType=='conTitle' ? 'selected': ''}>자바스크립트</option>
	                    <option value="JSP" ${searchType=='conTitle' ? 'selected': ''}>JSP</option>
	                    <option value="DB" ${searchType=='conTitle' ? 'selected': ''}>DB</option>
	                    <option value="스프링" ${searchType=='conTitle' ? 'selected': ''}>스프링</option>
	                    <option value="리액트" ${searchType=='conTitle' ? 'selected': ''}>리액트</option>
	                    <option value="엘라스틱서치" ${searchType=='conTitle' ? 'selected': ''}>엘라스틱서치</option>
	                    <option value="빅데이터" ${searchType=='conTitle' ? 'selected': ''}>빅데이터</option>
	                </optgroup>
                </select>
                <!-- (2) IT  select option-->
                <select name="searchType" id="selectCategoryStudy"  class="search-select" onchange="changeCategory()">
                    <option disabled selected>스터디구하기</option>
                    <optgroup label="스터디">
	                    <option value="독서" ${searchType=='conTitle' ? 'selected': ''}>독서</option>
	                    <option value="영어회화" ${searchType=='conTitle' ? 'selected': ''}>영어회화</option>
	                </optgroup>
                </select>
                <button type="reset">목록초기화</button>
                
           </div> 
        </form>
    </div>
   
   	<!-- 폼 리스트 시작 -->
    <div id="pot-body">
        <nav class="navbar">
        	<main class="maincontent_main">
            	<div class="potContent_List">
               		<!-- 리스트 출력 부분 -->
                	<c:forEach items="${potPage.content}" var="pot"  varStatus="state" >
	                   <div class="item">
                   			<!-- (1)(2) 팟 헤드 (번호, 카테고리) -->
	                   		<div class="potHead">
		                        <!-- (1) 번호 -->
		                        <div class="potNo"><c:out value="${potPage.totalElements - state.index - potPage.number * potPage.size}" /></div>
		                        
		                        <c:if test="${pot.potNowHeadcount eq pot.potTotalHeadcount}">
		                        	---마감된 팟 입니다---
		                        </c:if>
		                       
		                        <!-- (2) 카테고리 -->
		                        <div class="potCategory"><c:out value="${pot.potCategory}"/></div>
		                    </div>
		                    <!-- (3)(4) 팟 내용 (제목, 내용) --> 
		                    <div class="potTitleDetail">  
		                        <!-- (3) 제목	 -->
		                        <div class=potTitle>
		                            <a href="<c:url value='/detailForm'><c:param name='potNo' value='${pot.potNo}'/></c:url>">
		                            <c:out value="${pot.potTitle}" />
		                            </a>
		                        </div>
		                        <!-- (4) 내용	 -->
		                        <div class="potDetail"><c:out value="${pot.potDetail}"/></div>
		                    </div>
		                    <!-- (5) 작성자 + @ --> 
		                    	<!-- (5) 작성자 -->
		                        <div class=potWriter><c:out value="${pot.potWriter}"/></div>
		                    
		                    <!-- (6)() 팟 작성 날짜, 수정 날짜 -->     
		                        <!-- (6) 작성 날짜 -->
		                        <c:set var="formattedDate" value="작성일:${pot.potCreate.format(DateTimeFormatter.ofPattern('yy-MM-dd HH:mm'))}" />
		                        <div class=potCreate>
		                            <c:out value="${formattedDate}" />
		                        </div>
		                        <!-- () 수정 날짜  -->
								<%-- <c:set var="formattedDate" value="${pot.potModify.format(DateTimeFormatter.ofPattern('yyyy-MM-dd HH:mm'))}" />
		                        <div class=potModify>
		                            <c:out value="${formattedDate}" /> 
		                        </div>  --%>
		                    <!-- (7)(8) 팟 인원수 ( 신청자수 / 총인원수) -->     
		                    <div class="potCount">
		                    	<!-- (7) 현재 인원수 -->
		                        <div class="potNowHeadcount">
		                        <c:out value="현재 ${pot.potNowHeadcount}명 - "/>
		                        <!-- </div> -->
		                        <!-- (8) 총 인원수 -->
		                        <!-- <div class="pot"> </div> -->
		                        <!-- <div class="potTotalHeadcount"> -->
		                        <c:out value="총 ${pot.potTotalHeadcount}명"/></div>
		                    </div>
		                    <!-- (9)(10)팟 시간 (시작시간 / 마감시간) -->
		                    <div class="potStartEndTime">    
		                        <!-- (9) 시작시간 -->
		                        <div class=potStartTime>
		                             시작:<fmt:formatDate value="${pot.potStartTime}" pattern="yy-MM-dd HH:mm" />
		                        </div> 
		                        <div class="pot">  </div>   
		                        <!-- (10) 마감시간 -->
		                        <div class=potEndTime>
		                             마감:<fmt:formatDate value="${pot.potEndTime}" pattern="yy-MM-dd HH:mm" />
		                        </div>
		                    </div>
		                    <!-- (11)(@) 모임장소 + 기타  -->
		                        <!-- (11) 모임장소 -->
		                        <div class="potPlace"><c:out value="장소 : ${pot.potPlace}"/></div>
		                   
		                   		<div class="potJoin">
		                   			<button onclick="updateHeadcount('plus', ${pot.potNo})">참가</button>
	                   			<!-- </div>
	                   			
		                   		<div class="potCut"> -->
		                   			<button onclick="updateHeadcount('minus', ${pot.potNo})">취소</button>
	                   			</div>
	                	</div>   	
                	</c:forEach>
           		</div>
			</main> 
   		</section>
     <script>
    	function changeCategory(){
    		var selectElementSport = document.getElementById("selectCategorySport");
    	    var selectedValueSport = selectElementSport.options[selectElementSport.selectedIndex].value;
    	    var selectElementIT = document.getElementById("selectCategoryIT");
    	    var selectedValueIT = selectElementIT.options[selectElementIT.selectedIndex].value;
    	    var selectElementStudy = document.getElementById("selectCategoryStudy");
    	    var selectedValueStudy = selectElementStudy.options[selectElementStudy.selectedIndex].value;

    	    var selectedValue = selectedValueSport || selectedValueIT || selectedValueStudy; // 가장 마지막으로 선택된 값을 사용
			
    	    $.ajax({
    	        url: '/pot', // 요청을 보낼 서버의 URL
    	        type: 'GET', // HTTP 요청 방식
    	        data: { 'catogory': selectedValue }, // 서버로 보낼 데이터
    	        success: function(response) {}
    	            // 서버로부터 응답을 받고; // 응답으로 받은 HTML을 화면에 출력
    	        	$('#pot-body').html(response);
    	        },
    	        error: function(xhr, status, error) {
    	            // 요청이 실패했을 때 실행될 콜백 함수
    	            alert("Error: " + error);
    	        }
    	    });
    	}
    	}
    </script>

	<!-- 팟 참가하기 취소하기  -->
    <script>
		function updateHeadcount(action, potNo) {
		    //  팟 참가 현재 인원 반영 업데이트 함수 +1 , -1 를  한줄로 표현 
		    var url = '/updateNowHeadcount' + (action === 'plus' ? 'Plus' : 'Minus') + '.bo';
		    
		    $.ajax({
		        type: 'POST',
		        url: url,
		        data: { potNo: potNo },
		        success: function(response) {
		            // 성공 시 페이지 새로고침 또는 사용자에게 알림
		            alert('참여 여부가 변경되었습니다');
		            window.location.reload(); // 페이지 새로고침
		        },
		        error: function(xhr, status, error) {
		            // 실패 시 오류 메시지 출력
		            alert('업데이트 실패: ' + error);
		        }
		    });
		}  
		 /* function updateHeadcount(action, potNo) {
		    var url = '/updateNowHeadcountPlus.bo'; // 이 예제에서는 "plus" 액션만 고려

		    $.ajax({
		        type: 'POST',
		        url: url,
		        data: { potNo: potNo },
		        success: function(response) {
		            if (response.potCompleted) {
		                alert('팟 완성');
		            } else {
		                alert('업데이트 성공');
		            }
		            window.location.reload();
		        },
		        error: function(xhr, status, error) {
		            alert('업데이트 실패: ' + error);
		        }
		    });
		} */
		
		/* function updateHeadcount(action, potNo) {
		    var url = '/updateNowHeadcountMinus.bo'; // 이 예제에서는 "plus" 액션만 고려

		    $.ajax({
		        type: 'POST',
		        url: url,
		        data: { potNo: potNo },
		        success: function(response) {
		            if (response.potCompleted) {
		                alert('팟 완성');
		            } else {
		                alert('업데이트 성공');
		            }
		            window.location.reload();
		        },
		        error: function(xhr, status, error) {
		            alert('업데이트 실패: ' + error);
		        }
		    });
		}
 */
		
		</script>
    
   
	<!-- 하단 목록보기, 모두팟 작성하기 버튼  -->
	<div class="write-wrap">
        <button type="button" onclick="location.href='pot'" class="list-btn" >목록보기</button>
        <button type="button" onclick="location.href='potWrite'" class="write-btn" >모두팟작성하기</button>
    </div> 

 <!-- 푸터 부분 -->
    <jsp:include page="/WEB-INF/views/Common/footer.jsp" />
 
</body>
</html>
