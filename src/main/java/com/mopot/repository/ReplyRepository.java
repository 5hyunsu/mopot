package com.mopot.repository;

import com.mopot.domain.Reply;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ReplyRepository extends JpaRepository<Reply, Long> {
    /*List<Reply> findAllByRefCnoOrderByRefDescReStepAsc(Long conNo);*/

    List<Reply> findAllByRefCnoOrderByRefDescReStepAsc(Long conNo);


    Optional<Reply> findFirstByRefCnoOrderByRefDesc(Long conNo);

    // 특정 글(detailForm) 에 대한 최대 ref 값을 찾는 메소드 - reply 대댓글 순위 적용
    @Query("SELECT MAX(r.ref) FROM Reply r")
    Long findMaxRef();
}
