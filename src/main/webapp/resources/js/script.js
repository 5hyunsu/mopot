// 댓글 등록 함수
function insertReply() {
    Swal.fire({
        title: '댓글 등록하시겠습니까?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '네, 등록합니다.!'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: "insertReplyForm.bo",
                data: JSON.stringify({
                    "refCno": contentConNo,
                    "rname": contentConWriter,
                    "reDetail": $("#reDetail").val(),
                    "ref": 0, //최상위  ref 0
                    "reStep": 0,
                    "reLevel": 0,
                }),
                type: "post",
                contentType: "application/json",
                success: function (data) {
                    swal.fire('등록되었습니다!', '', 'success').then(() => location.reload());
                    updateReplyCntPlus();
                },
                error: function () {
                    console.log("댓글 등록 실패");
                }
            });
        }
    });
}

// 댓글 삭제
function deleteReply(reNo, conNo) {
    Swal.fire({
        title: '정말 삭제하시겠습니까?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '네, 삭제할게요!'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: `/replyDelete/${reNo}/${conNo}`, // 수정된 URL
                type: "DELETE", // DELETE 메서드 사용
                success: function(response) {
                    Swal.fire('삭제되었습니다!', '', 'success').then(() => location.reload());
                    updateReplyCntMinus();
                },
                error: function(error) {
                    Swal.fire('삭제 실패!', '', 'error');
                }
            });
        }
    });
}


// 댓글 수정
function replyUpdate(reNo, conNo) {
    var reDetailId = `#reDetail${reNo}`;
    var reDetail = $(reDetailId).val();

    Swal.fire({
        title: '댓글을 수정하시겠습니까?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '수정하기'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: `/replyUpdate/${reNo}/${conNo}`,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ reDetail: reDetail }),
                success: function(response) {
                    Swal.fire('수정되었습니다!', '', 'success').then(() => location.reload());
                },
                error: function(error) {
                    Swal.fire('수정 실패!', '', 'error');
                }
            });
        }
    });
}


// 대 댓글 등록 함수
function insertReplyReply(reNo, reStep, reLevel, ref) {
    //var reDetail = document.getElementById("reReDetail-" + ref).value; // 대댓글 내용
    var reDetailId = `reReReDetail` + reNo ; // 수정된 부분: 변수명을 정확히 참조
    var reDetail = document.getElementById(reDetailId).value; // jQuery 대신 순수 JavaScript 사용
    
    $.ajax({
        url: "/insertReplyReply", // 대댓글 등록 URL
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            "refCno": contentConNo,  // 현재 글 번호
            "rname": contentConWriter,
            "reDetail": reDetail, // 대댓글 내용
            "ref": ref,  // 대댓글이 달릴 댓글의 ID
            "reStep": reStep + 1, // 대댓글의 단계
            "reLevel": reLevel + 1, // 대댓글의 레벨
        }),
        success: function(response) {
            Swal.fire('대댓글 등록 성공!', '', 'success').then(() => location.reload());
        },
        error: function(xhr, status, error) {
            Swal.fire('대댓글 등록 실패!', '', 'error');
        }
    });
}

// 댓글수 리스트 반영 업데이트 함수 (+1)
function updateReplyCntPlus(conNo) {
    $.ajax({
        url: "/updateReplyCntPlus",  // ContentController로 이동
        data: JSON.stringify({
            "conNo": contentConNo, // 같이 불러와야 업데이트 된다.
            "conReCnt": contentConReCnt
            }),
        contentType: "application/json",
        type: "post",
        success: function(data) {
            console.log("댓글 숫자 업데이트 성공");
        },
        error: function() {
            console.log("댓글 숫자 업데이트 실패");
        }
    });
}

// 댓글수 리스트 반영 업데이트 함수 (-1)
function updateReplyCntMinus(conNo) {
    $.ajax({
        url: "/updateReplyCntMinus",  // ContentController로 이동
        data: JSON.stringify({
            "conNo": contentConNo, // 같이 불러와야 업데이트 된다.
            "conReCnt": contentConReCnt
        }),
        contentType: "application/json",
        type: "post",
        success: function(data) {
            console.log("댓글 숫자 업데이트 성공");
        },
        error: function() {
            console.log("댓글 숫자 업데이트 실패");
        }
    });
}

// 이전글 보기 함수
function moveToPrevPage(conNo) {
    $.ajax({
        url: "/checkPrevPage", // 이전글 컨트롤러 이동
        data: {
            "conNo": conNo
        },
        type: 'get',
        dataType: 'json',  // json으로 값을 받고 swal로 꾸미기
        success: function(data) {
            if (data.message) {
                Swal.fire({
                    title: '첫번째 글 입니다',
                    icon: "info",
                });
            }
            if (data.redirectUrl) {
                window.location.href = data.redirectUrl; // 서버로부터 받은 URL로 리다이렉션
            } else {
                console.log("이전 페이지가 존재하지 않습니다.");
            }
        },
        error: function() {
            console.log("이전 페이지 조회에 실패했습니다.");
        }
    });
}

// 다음글 보기 함수
function moveToNextPage(conNo) {
    $.ajax({
        url: "/checkNextPage", // 다음글 컨트롤러 이동
        data: {
            "conNo": conNo
        },
        type: 'get',
        dataType: 'json', // json으로 값을 받고 swal로 꾸미기
        success: function(data) {
            if (data.message) {
                Swal.fire({
                    title: "마지막 글 입니다",
                    icon: "info",
                });
            }
            if (data.redirectUrl) {
                window.location.href = data.redirectUrl; // 서버로부터 받은 URL로 리다이렉션
            } else {
                console.log("다음 페이지가 존재하지 않습니다.");
            }
        },
        error: function() {
            console.log("다음 페이지 조회에 실패했습니다.");
        }
    });
}

// 대댓글 입력창 열고 닫기 함수
function toggleReplyTextarea(textareaId) {
    var textarea = document.getElementById(textareaId);
    textarea.style.display = (textarea.style.display === 'none' || textarea.style.display === '') ? 'block' : 'none';
}

// 대댓글 취소 버튼 함수
function cancelReplyReply(ref) {
    var textareaId = "reReDetail-" + ref;
    toggleReplyTextarea(textareaId); // 취소 시 텍스트 영역을 숨김
}

