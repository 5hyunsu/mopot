package com.mopot.service;

import com.mopot.domain.Reply;
import com.mopot.repository.ContentRepository;
import com.mopot.repository.ReplyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.List;

@Service
public class ReplyService {

    @Autowired
    ReplyRepository replyRepository;

    @Autowired
    ContentRepository contentRepository;

    public List<Reply> findAllByRefCnoOrderByRefDescReStepAsc(Long conNo){
        return replyRepository.findAllByRefCnoOrderByRefDescReStepAsc(conNo);
    }

    /*public List<Reply> findRepliesByConNoWithOrder(Long conNo) {
        return replyRepository.findRepliesByConNoWithOrder(conNo);
    }*/


    /* 댓글 입력하기 */
    @Transactional
    public Reply insertReplyForm(Reply reply) throws Exception {
        Long maxRef = replyRepository.findMaxRef();
        if (maxRef == null) {
            maxRef = 0L; // 만약 댓글이 하나도 없다면, maxRef를 0으로 설정
        }
        reply.setRef(maxRef + 1); // 최대 ref 값에 1을 더해 새 댓글의 ref로 설정
        reply.setReStep(0l);
        reply.setReLevel(0l);
        return replyRepository.save(reply);

    }

    /* 댓글 수정하기 - 값을 한번에 댓글번호, 글번호, 댓글모델 3개를 받아 갖고 온다 */
    @Transactional
    public Reply replyUpdate(long reNo, long conNo, Reply reply) {
        Reply existingReply = replyRepository.findById(reNo)
                .orElseThrow(() -> new IllegalArgumentException("해당 댓글을 찾을 수 없습니다. reNo: " + reNo));
        existingReply.setReDetail(reply.getReDetail());
        return replyRepository.save(existingReply);
    }

    /* 댓글 삭제하기 - 값을 한번에 글번호, 댓글번호 2개를 받아 갖고 온다  */
    @Transactional
    public void deleteReply(long reNo, long conNo) {
        replyRepository.deleteById(reNo);

    }

    /* 대댓글 입력하기 */
    @Transactional
    public Reply insertReplyReply(Reply reply) {
         return replyRepository.save(reply);
    }

}


