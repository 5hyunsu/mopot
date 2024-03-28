<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="${path}/resources/css/content/list.css" rel="stylesheet">
    <!-- 알림창 alert 꾸미기 (아래줄) -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.all.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.min.css" rel="stylesheet">

    <script src="/webjars/jquery/3.7.1/jquery.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>

</head>
<body>
<!-- Header -->
<jsp:include page="/WEB-INF/views/Common/header.jsp" />

<!-- 페이지 전체 적용 -->
<section class="content">
    <div class="content-title"><!-- Title : 자유게시판 -->
        <div class="container">
            <h2 class="title"><a href="http://localhost:8080/list">자유게시판</a></h2>
        </div>
    </div>
    <div class="content-count"><!-- 총 게시물 수 :  -->
        <div class="container">
            <c:out value="총 게시글의 수 : ${contentPage.totalElements}" />
        </div>
    </div>
    <br>
    <!-- 테이블 시작 -->
    <div id="content-body">
        <div class="container">
            <table class="content-table">
                <!-- 테이블 상단 (헤드) -->
                <thead class="content-table-head">
                <tr>
                    <th class=conNo>번호</th>
                    <th class=conTitle>제목</th>
                    <th class=conWriter>작성자</th>
                    <th class=conCreate>작성날짜</th>
                    <th class=conCount>조회수</th>
                </tr>
                </thead>
                <!-- 테이블 내용 출력 -->
                <!-- 1. 공지사항 출력(if문으로 공지사항 일치여부 확인)-->
                <tbody class="content-table-body-Notice">
                <!--  테이블 상단 (0) 공지 -->
                <c:forEach items="${contentPageNotice.content}" var="content"  varStatus="state" >
                    <c:if test="${'공지사항' eq content.conCategory}">
                        <tr>
                                <%-- (1)번호 --%>
                            <td class="conNo">공지</td>
                                <%-- (2) 타이틀 + [댓글 수] --%>
                            <td class=conTitle>
                                <a href="<c:url value='/detailForm'><c:param name='conNo' value='${content.conNo}'/></c:url>"><c:out value="${content.conTitle}" />
                                    <c:if test="${content.conReCnt != 0 }">
                                        <small><b>[&nbsp;<c:out value="${content.conReCnt}"/>&nbsp;]</b></small>
                                    </c:if>
                                    <c:if test="${content.conReCnt == 0 }">
                                        <small><b>[&nbsp;0&nbsp;]</b></small>
                                    </c:if>
                                </a>
                            </td>
                                <%-- (3) 작성자 --%>
                            <td class=conWriter><c:out value="${content.conWriter}"/></td>
                                <%-- (4) 작성 날짜  (형태 변환 과정 1번 거침) --%>
                            <c:set var="formattedDate" value="${content.conCreate.format(DateTimeFormatter.ofPattern('yyyy-MM-dd HH:mm'))}" />
                            <td class=conCreate>
                                <c:out value="${formattedDate}" />
                            </td>
                                <%-- (5) 조회수  --%>
                            <td class=conCount><c:out value="${content.conCount}"/></td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>

                <!-- 2. 베스트 글 출력 (상위3개만 출력)-->
                <tbody class="content-table-body-Notice">
                <!--  테이블 상단 (0) 베스트 -->
                <c:forEach items="${contentPageBest3}" var="content"  varStatus="state" >
                    <tr>
                        <!-- (1)번호 -->
                        <td class="conNo">베스트</td>
                        <!-- (2) 타이틀 + [댓글 수]	 -->
                        <td class=conTitle>
                            <a href="<c:url value='/detailForm'><c:param name='conNo' value='${content.conNo}'/></c:url>"><c:out value="${content.conTitle}" />
                                <c:if test="${content.conReCnt != 0 }">
                                    <small><b>[&nbsp;<c:out value="${content.conReCnt}"/>&nbsp;]</b></small>
                                </c:if>
                                <c:if test="${content.conReCnt == 0 }">
                                    <small><b>[&nbsp;0&nbsp;]</b></small>
                                </c:if>
                            </a>
                        </td>
                        <!-- (3) 작성자 -->
                        <td class=conWriter><c:out value="${content.conWriter}"/></td>
                        <!-- (4) 작성 날짜  (형태 변환 과정 1번 거침) -->
                        <c:set var="formattedDate" value="${content.conCreate.format(DateTimeFormatter.ofPattern('yyyy-MM-dd HH:mm'))}" />
                        <td class=conCreate>
                            <c:out value="${formattedDate}" />
                        </td>
                        <!-- (5) 조회수  -->
                        <td class=conCount><c:out value="${content.conCount}"/></td>
                    </tr>
                </c:forEach>
                </tbody>
                <!-- 3. 리스트 출력 부분 -->
                <tbody class="content-table-body">
                <c:forEach items="${contentPage.content}" var="content"  varStatus="state" >
                    <tr>
                            <%-- (1)번호 --%>
                            <%--오름차순 (ex. 성적순 이런거)--%>
                            <%-- <td class=conNo><c:out value="${state.index + 1 + contentPage.number * contentPage.size}" /></td> --%>
                            <%--번호 내림차순 --%>
                        <td class="conNo"><c:out value="${contentPage.totalElements - state.index - contentPage.number * contentPage.size}" /></td>
                            <%-- (2) 타이틀 [댓글 수] --%>
                        <td class=conTitle>
                            <a href="<c:url value='/detailForm'><c:param name='conNo' value='${content.conNo}'/></c:url>">
                                <c:out value="${content.conTitle}" />
                                <c:if test="${content.conReCnt != 0 }">
                                    <small><b>[&nbsp;<c:out value="${content.conReCnt}"/>&nbsp;]</b></small>
                                </c:if>
                                <c:if test="${content.conReCnt == 0 }">
                                    <small><b>[&nbsp;0&nbsp;]</b></small>
                                </c:if>
                            </a>
                        </td>
                            <%-- (3) 작성자 --%>
                        <td class=conWriter>
                            <a href='/list?searchType=conWriter&searchKeyword=${content.conWriter}'/>
                            <c:out value="${content.conWriter}"/></td>
                        </a>
                            <%-- (4) 작성 날짜  (형태 변환 과정 1번 거침) --%>
                        <c:set var="formattedDate" value="${content.conCreate.format(DateTimeFormatter.ofPattern('yyyy-MM-dd HH:mm'))}" />
                        <td class=conCreate>
                            <c:out value="${formattedDate}" />
                        </td>
                            <%-- (5) 조회수  --%>
                        <td class=conCount><c:out value="${content.conCount}"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 하단 전체  -->
    <div id="content-foot">
        <div class="container">
            <!-- 1. 검색파트 -->
            <div class="content-foot-head">
                <form action="list" method="get">
                    <div class="search-wrap">
                        <!-- (1) 제목, 검색 select option-->
                        <select name="searchType" id="search-select"><%-- searchType을 각각 3개로 나누어서 검색 --%>
                            <!-- 0. 검색할때 옵션 선택하면  검색 후에도 옵션값 selected되게 searchType 을 저장시키고 비교해서 selected처리 -->
                            <option value="conTitle" ${searchType=='conTitle' ? 'selected': ''}>제목</option>
                            <option value="conDetail" ${searchType=='conDetail' ? 'selected': ''}>내용</option>
                            <option value="conWriter" ${searchType=='conWriter' ? 'selected': ''}>작성자</option>
                            <option value="conTag" ${searchType=='conTag' ? 'selected': ''}>태그</option>
                        </select>
                        <input name="searchKeyword"   placeholder="검색할 검색어 입력">
                        <!-- (2) 하단 검색 버튼 -->
                        <button type="submit" class="search-btn">검색</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="container">
            <!-- 2. 전체목록보기, 글 작성하기 -->
            <div class="content-foot-body">
                <!-- 목록보기 + 글작성하기 버튼  -->
                <div class="write-wrap">
                    <button type="button" onclick="location.href='list'" class="list-btn" >목록보기</button>
                    <button type="button" onclick="location.href='form'" class="write-btn" >글작성하기</button>
                </div>
            </div>
        </div>
        <div class="container">
            <!-- 3. 페이징 번호 처리 -->
            <div class="content-foot-foot" style="text-align:center">
           		 <c:if test="${contentPage.totalPages == 0}">
		         	<script type="text/javascript">
						Swal.fire({
						        icon: 'info',                         
						        title: '감사합니다',         
						        text: '첫글의 주인공이 되어주세요.',  
						    });
					</script> 		
				 </c:if>
            	<c:if test="${contentPage.totalPages != 0}">
	                <c:if test="${contentPage.hasPrevious()}">
	                    <a href="<c:url value='/list'><c:param name='page' value='${contentPage.previousPageable().pageNumber}'/></c:url>">[이전]...</a>
	                </c:if>
	                <c:forEach begin="0" end="${contentPage.totalPages-1}" var="pageNumber">
	                    <c:choose>
	                        <c:when test="${pageNumber == contentPage.number}">
	                            <strong>${pageNumber+1}</strong>
	                        </c:when>
	                        <c:otherwise>
	                            <a href="<c:url value='/list'><c:param name='page' value='${pageNumber}'/></c:url>">${pageNumber+1}</a>
	                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	                <c:if test="${contentPage.hasNext()}">
	                    <a href="<c:url value='/list'><c:param name='page' value='${contentPage.nextPageable().pageNumber}'/></c:url>">...[다음]</a>
	                </c:if>
	        	</c:if>
            </div>
        </div>
    </div>
</section>
	
<!-- Footer -->
<jsp:include page="/WEB-INF/views/Common/footer.jsp" />

</body>
</html>