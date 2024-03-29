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


    public Content insert(Content content) {
        return contentRepository.save(content);
    }


    public Page<Content> contentNoticeList(String conCategory, Pageable pageable) {
        return contentRepository.findByConCategory(conCategory, pageable);
    }


    public List<Content> findTop3ContentsByConCount() {
        return contentRepository.findTop3ByOrderByConCountDesc();
    }


    public Page<Content> contentList(Pageable pageable) {
        return contentRepository.findAll(pageable);
    }


    public Page<Content> conTitleSearchList(String searchKeyword, Pageable pageable) {
        return contentRepository.findByConTitleContaining(searchKeyword, pageable);
    }


    public Page<Content> conDetailSearchList(String searchKeyword, Pageable pageable) {
        return contentRepository.findByconDetailContaining(searchKeyword, pageable);
    }


    public Page<Content> conWriterSearchList(String searchKeyword, Pageable pageable) {
        return contentRepository.findByConWriterContaining(searchKeyword, pageable);
    }


    public Page<Content> conTagSearchList(String searchKeyword, Pageable pageable) {
        return contentRepository.findByConTagContaining(searchKeyword, pageable);
    }


    public Content update(Content content) {
        Content rcontent = contentRepository.findById(content.getConNo()).orElse(null);
        rcontent.setConTitle(content.getConTitle());
        rcontent.setConCategory(content.getConCategory());
        rcontent.setConDetail(content.getConDetail());
        rcontent.setConTag(content.getConTag());
        return contentRepository.save(rcontent);
    }


    public void contentDelete(long conNo) throws Exception {
        contentRepository.deleteById((long) conNo);
    }

    public Optional<Content> selectDetail(@NonNull Long conNo) {
        return contentRepository.findById(conNo).map(content -> {
            content.setConCount(content.getConCount() + 1);
            return contentRepository.save(content);
        });
    }


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