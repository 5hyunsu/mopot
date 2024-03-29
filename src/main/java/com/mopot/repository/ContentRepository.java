package com.mopot.repository;

import com.mopot.domain.Content;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContentRepository extends JpaRepository<Content, Long> {


    Page<Content> findAll(Pageable pageable);


    Page<Content> findByConCategory(String conCategory, Pageable pageable);


    List<Content> findTop3ByOrderByConCountDesc();


    Page<Content> findByConTitleContaining(String searchKeyword, Pageable pageable);


    Page<Content> findByconDetailContaining(String searchKeyword, Pageable pageable);


    Page<Content> findByConWriterContaining(String searchKeyword, Pageable pageable);


    Page<Content> findByConTagContaining(String searchKeyword, Pageable pageable);


    boolean existsByConNo(Long conNo);


    Content findFirstByOrderByConNoDesc();


    Content findFirstByOrderByConNoAsc();

}