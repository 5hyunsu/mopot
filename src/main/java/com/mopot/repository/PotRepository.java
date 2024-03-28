package com.mopot.repository;

import com.mopot.domain.PotContent;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PotRepository extends JpaRepository<PotContent, Long> {

	Page<PotContent> findAll(Pageable pageable);

	List<PotContent> findByPotCategory(String potCategory);
	/* "운동" 카테고리 누르면 보여주는 페이지 */
	Page<PotContent> findByPotCategory(String searchType, Pageable pageable);

	
}
