package com.mopot.controller;

import com.mopot.domain.Content;
import com.mopot.domain.Member;
import com.mopot.service.ContentService;
import com.mopot.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;

@Controller
@SessionAttributes({"loginUser"})
public class MemberController {

    @Autowired
    MemberService memberService;

    @Autowired
    ContentService contentService;

    @Autowired
    PasswordEncoder pEncoder;

	/*
	// 메인 페이지
	@RequestMapping("/")
	public String root() throws Exception {
		return "index";
	}
	*/

    // 회원가입 페이지
    @RequestMapping("/joinPage")
    public String joinPage() {
        return "Member/joinPage";
    }

    // 회원가입 - 회원 등록
    @PostMapping("/joinMember")
    public String InsertMember(Member member) {
        member.setUserPw(pEncoder.encode(member.getUserPw()));

        memberService.InsertMember(member);

        return "Member/joinSuccess";
    }


    // 회원가입 - 가입 시 ID 중복 체크
    @GetMapping("/idCheck")
    @ResponseBody
    public boolean idCheck(@RequestParam("id") String id) {
        return memberService.idCheck(id);
    }

    // 로그인 페이지
    @RequestMapping("/loginPage")
    public String loginPage() {
        return "Member/loginPage";
    }

/*
	@GetMapping("/loginMember")
	public String login() {
		return "Member/loginPage";
	}
*/

    // 로그인
    @PostMapping("/loginMember")
    public String loginMember(Member member, Model model, HttpSession session) {
        Member loginUser = memberService.loginMember(member);


        if (loginUser != null && pEncoder.matches(member.getUserPw(), loginUser.getUserPw())) {
            model.addAttribute("loginUser", loginUser);
            // session.setAttribute("loginUser", loginUser);

            return "redirect:/";
        } else {
            System.out.println(loginUser);

            return "Member/loginPage";
        }
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logoutMember(SessionStatus status) {
        if (!status.isComplete()) {
            status.setComplete();
        }

        return "redirect:/";
    }

    // 마이 페이지
    @RequestMapping("/myPage")
    public String myPage() {
        return "Member/myPage";
    }

    // 마이 페이지 - 회원 정보 조회
    @GetMapping("/myPage/myPageInfo")
    public String viewMyPage(Member member, Model model) {
        Member loginUser = memberService.loginMember(member);

        if (loginUser != null) {
            model.addAttribute("loginUser", loginUser);

            return "Member/myPage";
        } else {
            return "redirect:/";
        }
    }

    // 마이 페이지 - 회원 정보 수정
    @PostMapping("/myPage/myPageInfo")
    public String updateMyPage(Member member, Model model) {
        Member loginUser = memberService.loginMember(member);

        member.setUserId(loginUser.getUserId());

        Member updatedMember = memberService.updateMyPage(member);

        if (updatedMember != null) {
            model.addAttribute("loginUser", updatedMember);

            return "Member/myPage";
        } else {
            return "redirect:/";
        }
    }

    // 마이 페이지 - 정보 수정 시 닉네임 중복 체크
    @GetMapping("/nickCheck")
    @ResponseBody
    public boolean nickCheck(@RequestParam("nick") String nick) {
        return memberService.nickCheck(nick);
    }

    // 마이 페이지 - 비밀번호 변경
    @RequestMapping("/rePwdPage")
    public String rePwdPage() {
        return "Member/rePwdPage";
    }

    // 마이 페이지 - 작성한 글, 신청 조회
    @RequestMapping("/conList")
    public String myPageContent() {
        return "Member/conList";
    }

    @GetMapping("/myPageConList")
    public String myPageCreateContent(Pageable pageable, Model model) {
        Page<Content> contentList = contentService.contentList(pageable);

        return "Member/conList";
    }

    // 마이 페이지 - 회원 탈퇴
    @PostMapping("/mDelete")
    @ResponseBody
    public void mDelete() {
        memberService.mDelete();
    }
}