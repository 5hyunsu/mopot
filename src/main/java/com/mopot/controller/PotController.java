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

    @Autowired
    PotService potService;

    @RequestMapping("/pot")
    public String potContent() {
        return "Pot/pot";
    }

    @RequestMapping("/potWrite")
    public String potWrite() {
        return "Pot/potWrite";
    }

    @RequestMapping("/insertPotForm")
    public String insertPotForm(@ModelAttribute PotContent potContent, Model model) {
        PotContent savedPot = potService.insert(potContent);
        model.addAttribute("savedPot", savedPot);
        return "redirect:/pot";
    }


    @PostMapping("/potUpdate")
    public String potUpdate(PotContent potContent) {
        potService.update(potContent);
        return "redirect:/list";
    }


    @RequestMapping("/potContentDelete/{potNo}")
    public String potContentDelete(@PathVariable(name = "potNo") long potNo) throws Exception {
        potService.potContentDelete(potNo);
        return "redirect:/list";
    }


    @GetMapping("/pot")
    public String list(PotContent pot, Model model, HttpSession session, // 현재 페이지에서 사용
                       @RequestParam(value = "nowPage", defaultValue = "0") int nowPage,
                       @PageableDefault(page = 0, size = 10, sort = "potCreate", direction = Sort.Direction.DESC) Pageable pageable,
                       @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                       @RequestParam(value = "searchType", required = false) String searchType
    ) {

        model.addAttribute("potPage", potService.potList(pageable));
        model.addAttribute("nowPage", nowPage);


        if ("potCategory".equals(searchType)) {
            model.addAttribute("potPage", potService.potCategoryList(searchType, pageable));
            model.addAttribute("nowPage", nowPage);
        }
        return "/Pot/pot";
    }


    @GetMapping("/pot/list")
    public String listPotsByCategory(@RequestParam("category") String category, Model model) {

        List<PotContent> PotContents = potService.findPotsByCategory(category);
        model.addAttribute("PotContents", PotContents);

        return "/Pot/pot"; // 


    }

    /* 참가 관련 */

    @PostMapping("/updateNowHeadcountPlus.bo")
    public String updateNowHeadcountPlus(@RequestParam("potNo") Long potNo, Model model) {
        model.addAttribute("content", potService.updateNowHeadcountPlus(potNo).get());
        return "redirect:/pot";
    }

    @PostMapping("/updateNowHeadcountMinus.bo")
    public String updateNowHeadcountMinus(@RequestParam("potNo") Long potNo, Model model) {
        model.addAttribute("content", potService.updateNowHeadcountMinus(potNo).get());
        return "redirect:/pot";
    }
}

