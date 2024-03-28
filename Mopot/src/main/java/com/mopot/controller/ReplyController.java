package com.mopot.controller;

import com.mopot.domain.Reply;
import com.mopot.service.ContentService;
import com.mopot.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping
public class ReplyController {

    @Autowired
    ReplyService replyService;

    @Autowired
    ContentService contentService;

    /* 댓글 입력하기 ("/insertReplyForm.bo")*/
    @PostMapping("/insertReplyForm.bo")
    public ResponseEntity<String> insertReplyForm(@RequestBody Reply reply) {
        try {
            replyService.insertReplyForm(reply);
            return new ResponseEntity<>("댓글이 추가되었습니다.",HttpStatus.CREATED);
        } catch (Exception e){
            return new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
        }
    }
    /* 댓글 수정하기 */
    @PostMapping("/replyUpdate/{reNo}/{conNo}")
    public ResponseEntity<?> replyUpdate(@PathVariable long reNo,
                                         @PathVariable long conNo,
                                         @RequestBody Reply reply) {
        try {
            replyService.replyUpdate(reNo, conNo, reply);
            return new ResponseEntity<>("댓글이 수정되었습니다.",HttpStatus.OK);
        } catch (Exception e){
            return new ResponseEntity<>(e.getMessage(),HttpStatus.NOT_FOUND);
        }
    }

    // 댓글 삭제
    @DeleteMapping("/replyDelete/{reNo}/{conNo}")
    public ResponseEntity<?> deleteReply(@PathVariable Long reNo,
                                         @PathVariable Long conNo) {
        try {
            replyService.deleteReply(reNo, conNo);
            return ResponseEntity.ok().body("댓글이 삭제되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("댓글 삭제에 실패했습니다.");
        }
    }

    /* 대댓글 입력하기 */
    @PostMapping("insertReplyReply")
    public ResponseEntity<String> insertReplyReply(@RequestBody Reply reply) {
        try{
            replyService.insertReplyReply(reply);
            return new ResponseEntity<>("대댓글이 추가되었습니다.", HttpStatus.CREATED);
            /*
            (1)return new ResponseEntity.ok("대댓글이 추가되었습니다.");
            이 방식은 ResponseEntity의 OK 정적메소드를 사용하여 객체를 생성한다. 이 메소드는
            성공적인 요청을 나타내는 ResponseEntity객체를 반환한다.
            이 경우 본문에 문자열을 직접 전달할 수 있지만 , 상태코드는 항상 '200 ok'다.
            'ok 메소드는 코드를 간결하게 만들고 , 자주 사용되는 '200 ok'상태코드를 빠르게 설정할 때
            유용하다.

            (2) return new ResponseEntity<>("대댓글이 추가되었습니다.", HttpStatus.CREATED)
            ResponseEntity 새로 생성하여 반환 한다. 여기서는 생성자를 사용하여 응답 본문에 전달될
            문자열과 HTTP 상태코드를 직접 지정한다. HttpStatus.CREATED는  '201 Created'HTTP
            상태코드를 나타내며, 이는 요청이 성공적으로 이루어 졌고 새로운 리소스가 생성되었다는 것을 의미 한다

            차이점
            (1) 일반적인 성공을 나타내는 200 반환
            (2) 생성되었을 때 사용하는 코드인 201 created 반환

            ;*/
        } catch (Exception e){
            return new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
        }

    }


}
