package com.mopot.service;

import com.mopot.domain.Content;
import com.mopot.repository.ContentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ContentService {

    @Autowired
    ContentRepository contentRepository;

    /* 폼 입력하기 페이지 */
    public Content insert(Content content) {
        return contentRepository.save(content);
    }

    /* 1. 공지사항 출력 */
    public Page<Content> contentNoticeList(String conCategory, Pageable pageable) {
        return contentRepository.findByConCategory(conCategory, pageable);
    }

    /* 2. 베스트 글 출력 (상위3개만 출력) */
    public List<Content> findTop3ContentsByConCount() {
        return contentRepository.findTop3ByOrderByConCountDesc();
    }


    /* 3. 리스트 출력 부분 */
    public Page<Content> contentList(Pageable pageable) {
        return contentRepository.findAll(pageable);
    }

    /* 리스트 "검색" 보기 페이지 - (1)제목검색(타이틀)  */
    public Page<Content> conTitleSearchList(String searchKeyword, Pageable pageable) {
        return contentRepository.findByConTitleContaining(searchKeyword, pageable);
    }

    /* 리스트 "검색" 보기 페이지 - (2)내용검색(내용)  */
    public Page<Content> conDetailSearchList(String searchKeyword, Pageable pageable) {
        return contentRepository.findByconDetailContaining(searchKeyword, pageable);
    }

    /* 리스트 "검색" 보기 페이지 - (3)글쓴이검색(작성자)  */
    public Page<Content> conWriterSearchList(String searchKeyword, Pageable pageable) {
        return contentRepository.findByConWriterContaining(searchKeyword, pageable);
    }

    /* 리스트 "검색" 보기 페이지 - (4)태그검색(태그) */
    public Page<Content> conTagSearchList(String searchKeyword, Pageable pageable) {
        return contentRepository.findByConTagContaining(searchKeyword, pageable);
    }

    /* 자세히 보기 페이지 */

    /* 글 작성 관련 */
    /* 글 수정하기 */
    public Content update(Content content) {
        Content rcontent = contentRepository.findById(content.getConNo()).orElse(null);
        rcontent.setConTitle(content.getConTitle());
        rcontent.setConCategory(content.getConCategory());
        rcontent.setConDetail(content.getConDetail());
        rcontent.setConTag(content.getConTag());
        return contentRepository.save(rcontent);
    }

    /* 글 삭제하기 */
    public void contentDelete(long conNo) throws Exception {
        contentRepository.deleteById((long) conNo);
    }

    /* 조회수 */
    public Optional<Content> selectDetail(@NonNull Long conNo) {
        return contentRepository.findById(conNo).map(content -> {
            content.setConCount(content.getConCount() + 1);
            return contentRepository.save(content);
        });
    }

    /* 댓글 작성 관련 */
    /* 댓글수 리스트 반영 업데이트 함수  (+1) */
    public void updateReplyCntPlus(Long conNo) {
        contentRepository.findById(conNo).ifPresent(content -> {
            content.setConReCnt(content.getConReCnt() + 1);
            contentRepository.save(content);
        });
    }

    public void updateReplyCntMinus(Long conNo) {
        contentRepository.findById(conNo).ifPresent(content -> {
            content.setConReCnt(content.getConReCnt() - 1);
            contentRepository.save(content);
        });
    }

    /* 이전, 다음 페이지 이동 */
    /* 이동하는 페이지 conNo가 존재하는지 확인하는 용도 */
    public boolean existsByConNo(Long conNo) {
        return contentRepository.existsByConNo(conNo);
    }

    /* 다음글이 DB에 있는 Content의 ConNo Max 값과 비교 */
    public Content findFirstByOrderByConNoDesc() {
        return contentRepository.findFirstByOrderByConNoDesc();
    }

    /* 이전글이 DB에 있는 Content의 ConNo min 값과 비교  */
    public Content findFirstByOrderByConNoAsc() {
        return contentRepository.findFirstByOrderByConNoAsc();
    }

}