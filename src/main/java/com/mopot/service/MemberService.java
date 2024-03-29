package com.mopot.service;

import com.mopot.domain.Member;
import com.mopot.repository.MemberRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MemberService {

    @Autowired
    MemberRepository memberRepository;


    public Member InsertMember(Member member) {
        return memberRepository.save(member);
    }


    public boolean idCheck(String id) {
        return memberRepository.existsByUserId(id);
    }


    public Member loginMember(Member member) {
        Optional<Member> loginUser = memberRepository.findByUserId(member.getUserId());

        if (loginUser.isPresent()) {
            return loginUser.get();
        } else {
            return loginUser.orElse(null);
        }
    }


    @Transactional
    public Member updateMyPage(Member member) {
        Optional<Member> LoginUser = memberRepository.findByUserId(member.getUserId());

        if (LoginUser.isPresent()) {
            Member loginUser = LoginUser.get();
            loginUser.setUserNick(member.getUserNick());
            loginUser.setUserBirthday(member.getUserBirthday());
            loginUser.setUserGender(member.getUserGender());

            return memberRepository.save(loginUser);
        } else {
            throw new RuntimeException("로그인된 사용자를 찾을 수 없습니다. ID: " + member.getUserId());
        }
    }


    public boolean nickCheck(String nick) {
        return memberRepository.existsByUserNick(nick);
    }


    public List<Member> loginUserInfo(String userId) {
        return memberRepository.findAll();
    }


    public void mDelete() {
        memberRepository.deleteAll();
    }

}
