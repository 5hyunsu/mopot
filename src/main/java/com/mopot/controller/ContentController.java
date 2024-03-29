package com.mopot.controller;

import com.mopot.domain.Content;
import com.mopot.domain.Member;
import com.mopot.service.ContentService;
import com.mopot.service.ReplyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
/*import net.bytebuddy.matcher.ModifierMatcher.Mode;*/

@Controller
public class ContentController {

    @Autowired
    ContentService contentService;

    /
    @Autowired
    ReplyService replyService;

    private Member loginUser;

    @RequestMapping("/form")
    public String form() {
        return "Content/form";
    }

    @RequestMapping("/insertForm")
    public String insertForm(@ModelAttribute Content content, Model model) {
        Content savedContent = contentService.insert(content);
        model.addAttribute("savedContent", savedContent);
        return "redirect:/list";
    }

    @RequestMapping("/list")
    public String List() {
        return "Content/list";
    }

    @GetMapping("/list")
    public String list(Content content, Model model, HttpSession session,
                       @RequestParam(value = "nowPage", defaultValue = "0") int nowPage,
                       @PageableDefault(page = 0, size = 10, sort = "conCreate", direction = Sort.Direction.DESC) Pageable pageable,
                       @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                       @RequestParam(value = "searchType", required = false) String searchType
    ) {

        model.addAttribute("contentPageNotice", contentService.contentNoticeList("공지사항", pageable));


        model.addAttribute("contentPageBest3", contentService.findTop3ContentsByConCount());


        if (searchKeyword == null) {

            model.addAttribute("contentPage", contentService.contentList(pageable));
            model.addAttribute("nowPage", nowPage);
        } else if ("conTitle".equals(searchType)) {
            model.addAttribute("contentPage", contentService.conTitleSearchList(searchKeyword, pageable));
            model.addAttribute("nowPage", nowPage);
        } else if ("conDetail".equals(searchType)) {
            model.addAttribute("contentPage", contentService.conDetailSearchList(searchKeyword, pageable));
            model.addAttribute("nowPage", nowPage);
        } else if ("conWriter".equals(searchType)) {
            model.addAttribute("contentPage", contentService.conWriterSearchList(searchKeyword, pageable));
            model.addAttribute("nowPage", nowPage);
        } else if ("conTag".equals(searchType)) {
            model.addAttribute("contentPage", contentService.conTagSearchList(searchKeyword, pageable));
            model.addAttribute("nowPage", nowPage);
        }

        return "/Content/list";
    }


    @GetMapping("/detailForm")
    public String detailForm(@RequestParam("conNo") Long conNo, Model model) {

        if (loginUser == null) {
            model.addAttribute("content", contentService.selectDetail(conNo).get());
            model.addAttribute("rlist", replyService.findAllByRefCnoOrderByRefDescReStepAsc(conNo));
        } else {
            return "redirect:/error";
        }

        return "Content/detailForm";
    }

    @PostMapping("/update")
    public String update(Content content) {
        contentService.update(content);
        return "redirect:/list";
    }

    @RequestMapping("/contentDelete/{conNo}")
    public String contentDelete(@PathVariable(name = "conNo") long conNo) throws Exception {
        contentService.contentDelete(conNo);
        return "redirect:/list";
    }

    @PostMapping("/updateReplyCntPlus")
    public String updateReplyCntPlus(@RequestParam("conNo") Long conNo) {
        contentService.updateReplyCntPlus(conNo);
        return "redirect:/detailForm?conNo=" + conNo;
    }

    @PostMapping("/updateReplyCntMinus")
    public String updateReplyCntMinus(@RequestParam("conNo") Long conNo) {
        contentService.updateReplyCntMinus(conNo);
        return "redirect:/detailForm?conNo=" + conNo;
    }


    @GetMapping("/checkPrevPage.bo")
    public ResponseEntity<?> checkPrevPage(@RequestParam("conNo") Long conNo) {
        Long prevPageNo = conNo - 1;
        Content minConContent = contentService.findFirstByOrderByConNoAsc();

        if (minConContent == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("콘텐츠가 없습니다.");
        }


        while (prevPageNo >= 1) {
            if (contentService.existsByConNo(prevPageNo)) {
                String redirectUrl = "/detailForm?conNo=" + prevPageNo;
                return ResponseEntity.ok().body(new RedirectDTO(redirectUrl));
            } else if (prevPageNo < minConContent.getConNo()) {
                break;
            } else {
                prevPageNo--;
            }
        }
        RedirectDTO response = new RedirectDTO(null, "첫 글입니다."); /
        return ResponseEntity.ok().body(response); // 이전 페이지가 없는 경우 목록으로 리다이렉트

    }

    @GetMapping("/checkNextPage.bo")
    public ResponseEntity<?> checkNextPage(@RequestParam("conNo") Long conNo) {
        Long nextPageNo = conNo + 1;
        Content maxConContent = contentService.findFirstByOrderByConNoDesc();
        while (nextPageNo >= 1) {
            if (contentService.existsByConNo(nextPageNo)) {
                String redirectUrl = "/detailForm?conNo=" + nextPageNo;
                return ResponseEntity.ok().body(new RedirectDTO(redirectUrl));
            } else if (nextPageNo > maxConContent.getConNo()) {
                break;
            } else {
                nextPageNo++;
            }
        }
        RedirectDTO response = new RedirectDTO(null, "가장 최신 글입니다.");
        return ResponseEntity.ok().body(response);

    }

    /* 이전 페이지 다음페이지 리다이렉트용 클래스 */
    private static class RedirectDTO {
        private String redirectUrl; //리다이렉트용 URL
        private String message; // alert 메시지 용도 추가

        public RedirectDTO(String redirectUrl) {
            this.redirectUrl = redirectUrl;
        }

        public RedirectDTO(String redirectUrl, String message) {
            this.redirectUrl = redirectUrl;
            this.message = message;
        }

        // getter
        public String getRedirectUrl() {
            return redirectUrl;
        }

        // setter
        public void setRedirectUrl(String redirectUrl) {
            this.redirectUrl = redirectUrl;
        }

        //getter
        public String getMessage() {
            return message;
        }

        // setter
        public void setMessage(String message) {
            this.message = message;
        }

    }
}