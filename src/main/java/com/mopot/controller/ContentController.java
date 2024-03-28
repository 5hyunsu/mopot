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

    // 글
    @Autowired
    ContentService contentService;

    // 댓글
    @Autowired
    ReplyService replyService;

    private Member loginUser;

    // 폼 불러오기
    @RequestMapping("/form")
    public String form() {
        return "Content/form";
    }

    /* 폼 입력하기 페이지 */
    @RequestMapping("/insertForm")
    public String insertForm(@ModelAttribute Content content, Model model) {
        Content savedContent = contentService.insert(content);
        model.addAttribute("savedContent", savedContent);
        return "redirect:/list";
    }

    /* 1. 공지사항 출력(if문으로 공지사항 일치여부 확인)  */

    /* 2. 베스트 글 출력 (상위3개만 출력) */

    @RequestMapping("/list")
    public String List() {
        return "Content/list";
    }

    /* 3. 리스트 출력 부분 - (1) + (2) + 검색 보기 페이지 함께 구성 */
    @GetMapping("/list")
    public String list(Content content, Model model, HttpSession session, // 현재 페이지에서 사용
                       @RequestParam(value = "nowPage", defaultValue = "0") int nowPage,
                       @PageableDefault(page = 0, size = 10, sort = "conCreate", direction = Sort.Direction.DESC) Pageable pageable,
                       @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                       @RequestParam(value = "searchType", required = false) String searchType
    )

    {
        /* 1. 공지사항의 경우 - 카테고리가 공지사항인 것만 갖고온다  */
        model.addAttribute("contentPageNotice", contentService.contentNoticeList("공지사항",pageable));

        /* 2. 베스트 글 출력 (상위3개만 출력) - 조회수가 가장 높은 3개 갖고 온다 */
        model.addAttribute("contentPageBest3", contentService.findTop3ContentsByConCount());

        /* 전체, 검색 해서 출력  */
        if (searchKeyword == null) {
            // Page<Content> list = contentService.contentList(pageable);
            // model.addAttribute("contentPage",
            // contentService.contentList(PageRequest.of(nowPage, 10)));
            model.addAttribute("contentPage", contentService.contentList(pageable));
            model.addAttribute("nowPage", nowPage);
        }
        /* 제목 검색 */
        else if ("conTitle".equals(searchType)) {
            model.addAttribute("contentPage", contentService.conTitleSearchList(searchKeyword, pageable));
            model.addAttribute("nowPage", nowPage);
        }
        /* 내용 검색 */
        else if ("conDetail".equals(searchType)) {
            model.addAttribute("contentPage", contentService.conDetailSearchList(searchKeyword, pageable));
            model.addAttribute("nowPage", nowPage);
        }
        /* 작성자 검색 */
        else if ("conWriter".equals(searchType)) {
            model.addAttribute("contentPage", contentService.conWriterSearchList(searchKeyword, pageable));
            model.addAttribute("nowPage", nowPage);
        }
        /* 태그 검색 */
        else if ("conTag".equals(searchType)) {
            model.addAttribute("contentPage", contentService.conTagSearchList(searchKeyword, pageable));
            model.addAttribute("nowPage", nowPage);
        }

        // 로그인 시 사용
		/*if(session.getAttribute("loginUser") != null) {
			loginUser = (Member)session.getAttribute("loginUser");
			model.addAttribute("loginUser",loginUser);
		}*/

        return "/Content/list";
    }

    /* 자세히 보기 페이지 */
    @GetMapping("/detailForm")
    public String detailForm(@RequestParam("conNo") Long conNo, Model model) {

		/* 로그인 했을 때 수정
		 * if(loginUser != null) {
		model.addAttribute("loginUser",loginUser);
		}
		*/

        if (loginUser == null) {
            model.addAttribute("content", contentService.selectDetail(conNo).get());
            model.addAttribute("rlist", replyService.findAllByRefCnoOrderByRefDescReStepAsc(conNo));
        } else {
            return "redirect:/error";
        }

        return "Content/detailForm";
    }

    /* 글 수정하기 */
    @PostMapping("/update")
    public String update(Content content) {
        contentService.update(content);
        return "redirect:/list";
    }

    /* 글 삭제하기 */
    @RequestMapping("/contentDelete/{conNo}")
    public String contentDelete(@PathVariable(name = "conNo") long conNo) throws Exception {
        contentService.contentDelete(conNo);
        return "redirect:/list";
    }

    /* 조회수 */

    /* 댓글수 리스트 반영 업데이트 함수  (+1) */
    @PostMapping("/updateReplyCntPlus")
    public String updateReplyCntPlus(@RequestParam("conNo") Long conNo) {
        contentService.updateReplyCntPlus(conNo);
        return "redirect:/detailForm?conNo=" + conNo;
    }

    /* 댓글수 리스트 반영 업데이트 함수  (-1) */
    @PostMapping("/updateReplyCntMinus")
    public String updateReplyCntMinus(@RequestParam("conNo") Long conNo) {
        contentService.updateReplyCntMinus(conNo);
        return "redirect:/detailForm?conNo=" + conNo;
    }

    /* 이전글 다음글 */
    /* 이전페이지 조회시 1이상이고 페이지가 없을경우 계속 -1 해서 존재하는 페이지 까지 조회  */
    @GetMapping("/checkPrevPage.bo")
    public ResponseEntity<?> checkPrevPage(@RequestParam("conNo") Long conNo) {
        Long prevPageNo = conNo - 1;
        Content minConContent = contentService.findFirstByOrderByConNoAsc();

        //글이 없는 경우 처리 (미정 ★: 데이터 싹 밀고 테스트 해봐야 함 )
        if (minConContent == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("콘텐츠가 없습니다.");
        }

        //이전 페이지 처리 하면서 -1 씩 반복문
        while (prevPageNo >= 1) {
            if (contentService.existsByConNo(prevPageNo)) {
                String redirectUrl = "/detailForm?conNo=" + prevPageNo;
                return ResponseEntity.ok().body(new RedirectDTO(redirectUrl));
            }
            //DB저장된 Content중에 ConNo Min값 구해서 비교하기
            else if(prevPageNo < minConContent.getConNo()) {
                break;
            } else {
                prevPageNo--;
            }
        }
        RedirectDTO response = new RedirectDTO(null, "첫 글입니다."); // URL 대신 메시지 전달
        return ResponseEntity.ok().body(response); // 이전 페이지가 없는 경우 목록으로 리다이렉트
        //한줄로 return ResponseEntity.ok().body(new RedirectDTO(null, "첫 글입니다."));
    }
    /* 다음페이지 조회시 1이상이고 페이지가 없을경우 계속 +1 해서 존재하는 페이지 까지 조회  */
    @GetMapping("/checkNextPage.bo")
    public ResponseEntity<?> checkNextPage(@RequestParam("conNo") Long conNo) {
        Long nextPageNo = conNo + 1;
        Content maxConContent = contentService.findFirstByOrderByConNoDesc();
        while (nextPageNo >= 1) {
            if (contentService.existsByConNo(nextPageNo)) {
                String redirectUrl = "/detailForm?conNo=" + nextPageNo;
                return ResponseEntity.ok().body(new RedirectDTO(redirectUrl));
            }
            //DB저장된 Content중에 ConNo Max값 구해서 비교하기
            else if(nextPageNo > maxConContent.getConNo()) {
                break;
            } else {
                nextPageNo++;
            }
        }
        RedirectDTO response = new RedirectDTO(null, "가장 최신 글입니다."); // URL 대신 메시지 전달
        return ResponseEntity.ok().body(response);
        //return ResponseEntity.ok().body(new RedirectDTO("/list")); // 다음 페이지가 없는 경우 목록으로 리다이렉트
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