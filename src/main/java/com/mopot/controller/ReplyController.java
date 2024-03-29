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

    @PostMapping("/insertReplyForm.bo")
    public ResponseEntity<String> insertReplyForm(@RequestBody Reply reply) {
        try {
            replyService.insertReplyForm(reply);
            return new ResponseEntity<>("댓글이 추가되었습니다.", HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/replyUpdate/{reNo}/{conNo}")
    public ResponseEntity<?> replyUpdate(@PathVariable long reNo,
                                         @PathVariable long conNo,
                                         @RequestBody Reply reply) {
        try {
            replyService.replyUpdate(reNo, conNo, reply);
            return new ResponseEntity<>("댓글이 수정되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }


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


    @PostMapping("insertReplyReply")
    public ResponseEntity<String> insertReplyReply(@RequestBody Reply reply) {
        try {
            replyService.insertReplyReply(reply);
            return new ResponseEntity<>("대댓글이 추가되었습니다.", HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

    }


}
