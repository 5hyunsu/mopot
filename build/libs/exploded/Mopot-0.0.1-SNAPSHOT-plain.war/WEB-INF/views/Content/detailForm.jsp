<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="${path}/resources/css/content/detailForm.css" rel="stylesheet" />
    <script src="/webjars/jquery/3.7.1/jquery.min.js"></script>
    <!-- 알림창 alert 꾸미기 (아래 1줄) -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.all.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.min.css" rel="stylesheet">

    <script src="../../../resources/js/script.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>디테일 글 폼 보기 </title>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/Common/header.jsp" />

    <!-- 페이지 전체 적용 -->
    <section class="content-detail">
        <div class="content-detail-title"><!-- Title : 상 세 보 기-->
            <div class="container">
                <h2>상세보기</h2>
            </div>
        </div>
        <div class="content-detail-prevnext"><!-- 이전글, 다음글 버튼 -->
            <div class="container">
                <button type="button" onclick="moveToPrevPage(${content.conNo})" class="list-btn">이전글</button>&emsp;
                <button type="button" onclick="moveToNextPage(${content.conNo})" class="list-btn">다음글</button>&emsp;

            </div>
        </div>


        <%--    jsp파일에서 javascript에서 서버로부터 데이터 사용하게끔--%>
        <script>
            var contentConNo = ${content.conNo}; // JSP 변수를 JavaScript 변수에 할당
            var contentConWriter = "${content.conWriter}"; // 따옴표 주의
            var contentConReCnt = ${content.conReCnt};
        </script>



        <!-- 테이블 시작 -->
        <div class="content-detail-body">
            <div class="container">
                <form action="/update" method="post">
                    <table class="content-Detail-table">
                        <tr class="ConNoConCategory">
                            <!-- 1-(1) 번호(No)+ 번호 입력칸 (읽기만가능 readonly)-->
                            <td><div class="conNo">No</div></td>
                            <td><input id="conNoInput" name="conNo" value="${content.conNo}" readonly></td>
                            <!-- 1-(2) 분류(Category) + 분류 입력칸  -->
                            <td><div class="conCategory">분류</div></td>
                            <td>
                                <!-- 기존에 설정한 카테고리를 상단에 표시에서 selected로 보여줌 -->
                                <select class=conCategoryInput name="conCategory">
                                    <c:choose>
                                        <c:when test="${content.conCategory eq '공지사항'}">
                                            <option value="공지사항" selected>공지사항</option>
                                        </c:when>
                                        <c:when test="${content.conCategory eq '야구'}">
                                            <option value="야구" selected>야구</option>
                                        </c:when>
                                        <c:when test="${content.conCategory eq '농구'}">
                                            <option value="농구" selected>농구</option>
                                        </c:when>
                                        <c:when test="${content.conCategory eq '축구'}">
                                            <option value="축구" selected>축구</option>
                                        </c:when>
                                        <c:when test="${content.conCategory eq '코딩'}">
                                            <option value="코딩" selected>코딩</option>
                                        </c:when>
                                        <c:when test="${content.conCategory eq '영어회화'}">
                                            <option value="영어회화" selected>영어회화</option>
                                        </c:when>
                                    </c:choose>
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
                            </td>
                        </tr>
                        <tr>

                            <!-- 2 제목(Title) + 입력칸 -->
                            <td colspan="1"><div class="conTitle">제목</div></td>
                            <td colspan="3"><input id="conTitleInput" name="conTitle" value="${content.conTitle}"></td>
                        <tr>
                        <tr>
                            <!-- 3-(1) 작성자(Writer) + 입력칸  -->
                            <td class="conWriter">작성자</td>
                            <td><input id="conWriterInput" name="conWriter" value="${content.conWriter}" readonly></td>
                            <!-- 3-(2) 조회수(Count) + 입력칸 (읽기만가능 readonly) -->
                            <td class="conCount">조회수</td>
                            <td><input id="conCountInput" name="conCount" value="${content.conCount}" readonly></td>
                        </tr>
                        <tr>
                            <!-- 4-(1) 작성일(Create) + 입력칸 (읽기만가능 readonly) -->
                            <td class="conCreate">작성일</td>
                            <td><input id="conCreateInput"
                                       value="${content.conCreate.format(DateTimeFormatter.ofPattern('yyyy-MM-dd HH:mm'))}"
                                       type="datetime-local"
                                       readonly></td>
                            <!-- 4-(2) 수정일(Modify) + 입력칸 (읽기만가능 readonly) -->
                            <td class="conModify">수정일</td>
                            <td><input id="conModifyInput"
                                       value="${content.conModify.format(DateTimeFormatter.ofPattern('yyyy-MM-dd HH:mm'))}"
                                       type="datetime-local"
                                       name="conModify"
                                       readonly/></td>
                        </tr>
                        <tr>
                            <!-- 5 내용(Detail) + 입력칸 -->
                            <!-- <td colspan="2"><div class="conDetail">내용</div></td> -->
                            <td colspan="4"><textarea id="conDetailInput"
                                                      name="conDetail"
                                                      rows="10"
                                                      cols="50">${content.conDetail}
                            </textarea>
                            </td>
                        </tr>
                        <tr>
                            <!-- 6 태그(Tag) + 입력칸 -->
                            <td><div class="conTag">태그</div></td>
                            <td colspan="3"><input id="conTagInput"
                                                   name="conTag"
                                                   value="${content.conTag}">
                            </td>
                        </tr>
                        <tr>
                            <td>

                            </td>
                        </tr>
                        <tr>
                            <!-- 7 버튼 (수정, 목록, 글쓰기, 삭제) -->
                            <td colspan="4">
                                <div id="button">
                                    <button type="submit" class="modify-btn">수정</button>&emsp;
                                    <button type="button" onclick="location.href='list' " class="list-btn">목록</button>&emsp;
                                    <button type="button" onclick="location.href='form' " class="write-btn">글쓰기</button>&emsp;
                                    <button type="button" onclick="location.href='/contentDelete/${content.conNo}'" class="delete-btn">삭제</button>&emsp;
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <!-- 8 버튼 (작성자 게시글 더보기 ) -->
                            <td colspan="4">
                                <div id="conWriterMore">
                                    <div class="container">
                                        <button type="button" onclick="location.href='/list?searchType=conWriter&searchKeyword=${content.conWriter}'" class="conWriterMore-btn"><b>${content.conWriter}</b>님의 게시글 더보기</button>&emsp;
                                    </div>
                                </div>
                        </tr>
                    </table>
                </form>
            </div>
        </div>


        <!--  좋아요 하트 버튼  -->
        <div class="heart-btn" onclick="likeUp();">
            <div class="content">
                <span class="heart"></span>
                <span class="text">Like </span>
                <span class="numb">0</span>
            </div>
        </div>

        <script>
            $(document).ready(function (){
                $(".content").click(function (){
                    $(".content").toggleClass("heart-active")
                    $('.text').toggleClass("heart-active")
                    $(".numb").toggleClass("heart-active")
                    $(".heart").toggleClass("heart-active")
                });
            });
        </script>

        <script>
            var count = 0;

            function likeUp() {
                count=count+1;
                document.querySelector(".numb").innerText=count;
            }
        </script>





        <!-- 댓글 부분 -->
        <div class="reply">
            <!-- 댓글 작성 -->
            <table class="reply-write">
                <th>
                    <div class="reply-head">
                        <div class="container">
                            <textarea id="reDetail" class="reply-content" rows="2" ></textarea>
                            <!-- 댓글 입력 + 댓글수(+1) -->
                            <button onclick="insertReply()"
                                    id="reply-btn"
                                    class="reply-btn">댓글달기
                            </button>
                        </div>
                    </div>
                </th>
            </table>
        </div>

        <!-- 댓글 리스트 출력 -->
        <div class="reply-list">
            <c:forEach var="r" items="${rlist}">
                <form action="/replyUpdate/${reNo}/${conNo}" method="post">
                    <!-- 댓글 박스처리 -->
                    <table class="reply-box">
                        <div class="container">

                            <!-- 들여쓰기 1칸 -->
                            <c:if test="${r.reLevel == 1}">
                            <tr>
                                <td rowspan="4" class=reply1>
                                    <img src="../../../resources/img/SHO/img_2.png" width="20" height="20" class=arrow/>
                                </td>
                            </tr>
                            </c:if>

                            <!-- 들여쓰기 2칸 -->
                            <c:if test="${r.reLevel == 2}">
                            <tr>

                                <td rowspan="4">
                                   <span class="invisible-space">
                                   <c:out value="&nbsp;"/>
                                   </span>
                                </td>
                                    <td rowspan="4" class=reply1>
                                    <img src="../../../resources/img/SHO/arrow.png" width="20" height="20" class=arrow/>
                                </td>
                            </tr>
                            </c:if>

                            <!-- 들여쓰기 3칸 -->
                            <c:if test="${r.reLevel == 3}">
                            <tr>
                                <td rowspan="4">
                                   <span class="invisible-space">
                                   <c:out value="&nbsp;"/>
                                   </span>
                                </td>
                                <td rowspan="4">
                                   <span class="invisible-space">
                                   <c:out value="&nbsp;"/>
                                   </span>
                                </td>
                                <td rowspan="4" class=reply1>
                                    <img src="../../../resources/img/SHO/arrow.png" width="20" height="20" class=arrow/>
                                </td>
                                </c:if>

                                <!-- 들여쓰기 4칸 -->
                                <c:if test="${r.reLevel == 4}">
                            <tr>
                                <td rowspan="4">
                                   <span class="invisible-space">
                                   <c:out value="&nbsp;"/>
                                   </span>
                                </td>
                                <td rowspan="4">
                                   <span class="invisible-space">
                                   <c:out value="&nbsp;"/>
                                   </span>
                                </td>
                                <td rowspan="4">
                                       <span class="invisible-space">
                                       <c:out value="&nbsp;"/>
                                       </span>
                                </td>
                                <td rowspan="4" class=reply1>
                                    <img src="../../../resources/img/SHO/arrow.png" width="20" height="20" class=arrow/>
                                </td>
                                </c:if>


                            <tr class="reply-detail" align="left">
                                <td colspan="2" class="replyname">
                                    <img src="../../../resources/img/SHO/img_1.png" width="30%" class="kakaoprofile"/>
                                    <c:out value="${r.rname}" />
                                </td>
                                <td colspan="4" class="replydetail">
                                    <input id="reDetail${r.reNo}" name="reDetail" value="${r.reDetail}">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="reTime">
                                    <c:set var="reCreateformattedDate" value="${r.reCreate.format(DateTimeFormatter.ofPattern('yyyy-MM-dd HH:mm:ss'))}" />
                                    <c:out value="입력: ${reCreateformattedDate}"  />
                                    <c:set var="reModifyformattedDate" value="${r.reModify.format(DateTimeFormatter.ofPattern('yyyy-MM-dd HH:mm:ss'))}" />
                                    <c:out value=" 수정 :${reModifyformattedDate}"  />
                                </td>
                                <!-- </tr>
                                <tr> -->
                                <!-- 댓글 수정하기 -->
                                <td colspan="3" class="reply-box-button">
                                    <!-- 댓글 수정 버튼에 replyUpdate 함수 호출 추가 -->
                                    <button type="button" onclick="replyUpdate(${r.reNo}, ${content.conNo})"
                                            class="modify-btn">수정
                                    </button>
                                    <!-- 댓글 삭제 + 댓글수(-1) -->

                                    <button type="button" onclick="deleteReply(${r.reNo},${content.conNo})"
                                             class="delete-btn">삭제
                                    </button>&emsp;

                                    <!-- ----------대댓글 영역 ------- -->
                                    <!-- Ref 부분은 그대로 놔두고(댓글뭉탱이), ReStep , ReLevel을 +1 씩한다.  -->
                                    <!-- 대댓글달기 -->
                                    <button type="button" onclick="toggleReplyTextarea('replyTextarea${r.reNo}') " class="write-btn">대댓글달기</button>&emsp;

                                    <!-- 대댓글 입력창 -->
                                    <div id="replyTextarea${r.reNo}" style="display:none">
                                        <textarea id="reReReDetail${r.reNo}" class="reply-content"></textarea>
                                        <button type="button" onclick="insertReplyReply(${r.reNo}, ${r.reStep}, ${r.reLevel}, ${r.ref});">등록</button>
                                        <button type="button" onclick="toggleReplyTextarea('replyTextarea${r.reNo}');">취소</button>
                                    </div>
                                </td>
                            </tr>
                    </table>
                </form>
            </c:forEach>
        </div>

        <!-- Footer -->
        <jsp:include page="/WEB-INF/views/Common/footer.jsp" />




    </section>
</body>
</html>