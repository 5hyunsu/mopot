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

    @RequestMapping("/joinPage")
    public String joinPage() {
        return "Member/joinPage";
    }

    @PostMapping("/joinMember")
    public String InsertMember(Member member) {
        member.setUserPw(pEncoder.encode(member.getUserPw()));

        memberService.InsertMember(member);

        return "Member/joinSuccess";
    }


    @GetMapping("/idCheck")
    @ResponseBody
    public boolean idCheck(@RequestParam("id") String id) {
        return memberService.idCheck(id);
    }

    @RequestMapping("/loginPage")
    public String loginPage() {
        return "Member/loginPage";
    }

    @PostMapping("/loginMember")
    public String loginMember(Member member, Model model, HttpSession session) {
        Member loginUser = memberService.loginMember(member);


        if (loginUser != null && pEncoder.matches(member.getUserPw(), loginUser.getUserPw())) {
            model.addAttribute("loginUser", loginUser);

            return "redirect:/";
        } else {
            System.out.println(loginUser);

            return "Member/loginPage";
        }
    }

    @GetMapping("/logout")
    public String logoutMember(SessionStatus status) {
        if (!status.isComplete()) {
            status.setComplete();
        }

        return "redirect:/";
    }

    @RequestMapping("/myPage")
    public String myPage() {
        return "Member/myPage";
    }

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

    @GetMapping("/nickCheck")
    @ResponseBody
    public boolean nickCheck(@RequestParam("nick") String nick) {
        return memberService.nickCheck(nick);
    }


    @RequestMapping("/rePwdPage")
    public String rePwdPage() {
        return "Member/rePwdPage";
    }

    @RequestMapping("/conList")
    public String myPageContent() {
        return "Member/conList";
    }

    @GetMapping("/myPageConList")
    public String myPageCreateContent(Pageable pageable, Model model) {
        Page<Content> contentList = contentService.contentList(pageable);

        return "Member/conList";
    }

    @PostMapping("/mDelete")
    @ResponseBody
    public void mDelete() {
        memberService.mDelete();
    }
}