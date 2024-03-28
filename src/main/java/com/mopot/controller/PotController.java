package com.mopot.controller;

import com.mopot.domain.Content;
import com.mopot.domain.PotContent;
import com.mopot.service.PotService;

import jakarta.servlet.http.HttpSession;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PotController {
	//	
    @Autowired
    PotService potService;
    
    // 팟
    @RequestMapping("/pot")
    public String potContent() {
        return "Pot/pot";
    }
    // 작성 폼 불러오기 
    @RequestMapping("/potWrite")
    public String potWrite() {
    	return "Pot/potWrite";
    }
    
    /* 폼 입력하기 페이지 */
    @RequestMapping("/insertPotForm")
    public String insertPotForm(@ModelAttribute PotContent potContent, Model model) {
    	PotContent savedPot = potService.insert(potContent);
        model.addAttribute("savedPot", savedPot);
        return "redirect:/pot";
    }
    
    /* 폼 수정하기 */
    @PostMapping("/potUpdate")
    public String potUpdate(PotContent potContent) {
    	potService.update(potContent);
        return "redirect:/list";
    }

    /* 폼 삭제하기 */
    @RequestMapping("/potContentDelete/{potNo}")
    public String potContentDelete(@PathVariable(name = "potNo") long potNo) throws Exception {
    	potService.potContentDelete(potNo);
        return "redirect:/list";
    }
    
    /* 폼 출력하기 (전체) */
    @GetMapping("/pot")
    public String list(PotContent pot, Model model, HttpSession session, // 현재 페이지에서 사용
            @RequestParam(value = "nowPage", defaultValue = "0") int nowPage,
            @PageableDefault(page = 0, size = 10, sort = "potCreate", direction = Sort.Direction.DESC) Pageable pageable,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            @RequestParam(value = "searchType", required = false) String searchType
    		)
    {	
    	/* 전체 팟 보여주기 */
    	model.addAttribute("potPage", potService.potList(pageable));
    	model.addAttribute("nowPage", nowPage);
    	
    	/* "운동" 카테고리 누르면 보여주는 페이지 */
    	if("potCategory".equals(searchType)) {
    	model.addAttribute("potPage", potService.potCategoryList(searchType,pageable));
        model.addAttribute("nowPage", nowPage);
    	}
    	   	
    	
    	return "/Pot/pot";
    }
    
    /* 폼 부분 출력 하기 (상단 카테고리 옵션 바꾸면 리스트 바꾸는 것) */
    @GetMapping("/pot/list")
    public String listPotsByCategory(@RequestParam("category") String category, Model model) {
        // 카테고리에 맞는 데이터 조회 로직
        List<PotContent> PotContents = potService.findPotsByCategory(category);
        model.addAttribute("PotContents", PotContents);
        
        // 조회된 데이터를 바탕으로 한 HTML 뷰의 이름 반환
        return "/Pot/pot"; // 
        
       
    }
    
    
    /* 참가 관련 */

    /* 팟 참가 현재 인원 반영 업데이트 함수  (+1) */
    @PostMapping("/updateNowHeadcountPlus.bo")
    public String updateNowHeadcountPlus(@RequestParam("potNo") Long potNo, Model model) {
        model.addAttribute("content", potService.updateNowHeadcountPlus(potNo).get());
        return "redirect:/pot"; 
    }

    /* 팟 참가 현재 인원 반영 업데이트 함수  (-1) */
    @PostMapping("/updateNowHeadcountMinus.bo")
    public String updateNowHeadcountMinus(@RequestParam("potNo") Long potNo, Model model) {
        model.addAttribute("content", potService.updateNowHeadcountMinus(potNo).get());
        return "redirect:/pot"; 
    }
    
    
    
}

