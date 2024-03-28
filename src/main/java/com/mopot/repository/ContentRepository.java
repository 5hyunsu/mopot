package com.mopot.repository;

import com.mopot.domain.Content;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContentRepository extends JpaRepository<Content, Long> {


    /* 전체 리스트 */
    Page<Content> findAll(Pageable pageable);

    /* 공지 사항 보기 페이지 */
    Page<Content> findByConCategory(String conCategory, Pageable pageable);

    /* 조회수 베스트글3 보기 페이지 - 내림차순 하고 상위 3개만 갖고 온다  */
    List<Content> findTop3ByOrderByConCountDesc();

    /* 리스트 "검색" 보기 페이지 - (1)제목검색(타이틀)  */
    Page<Content> findByConTitleContaining(String searchKeyword, Pageable pageable);

    /* 리스트 "검색" 보기 페이지 - (2)내용검색(내용)  */
    Page<Content> findByconDetailContaining(String searchKeyword, Pageable pageable);

    /* 리스트 "검색" 보기 페이지 - (3)글쓴이검색(작성자)  */
    Page<Content> findByConWriterContaining(String searchKeyword, Pageable pageable);

    /* 리스트 "검색" 보기 페이지 - (4)태그검색(태그) */
    Page<Content> findByConTagContaining(String searchKeyword, Pageable pageable);

    /* 이전글 다음글 존재하는지 여부 확인 */
    boolean existsByConNo(Long conNo);

    /* 다음글이 DB에 있는 Content의 ConNo Max 값과 비교 */
    Content findFirstByOrderByConNoDesc();

    /* 이전글이 DB에 있는 Content의 ConNo min 값과 비교 */
    Content findFirstByOrderByConNoAsc();

}