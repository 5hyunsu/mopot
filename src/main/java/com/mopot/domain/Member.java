package com.mopot.domain;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@Entity
@EntityListeners(AuditingEntityListener.class)
public class Member {
    @Id
    @SequenceGenerator(
            name="MemberSEQ",
            sequenceName="Member_SEQ",
            allocationSize = 1
    )
    @GeneratedValue(generator="MemberSEQ")
    @Column(name="user_no")
    private Long userNo;

    @NonNull
    @Column(name="user_id")
    private String userId;

    @NonNull
    @Column(name="user_pw")
    private String userPw;

    @NonNull
    @Column(name="user_name")
    private String userName;

    @NonNull
    @Column(name="user_email")
    private String userEmail;

    @Column(name="user_nick")
    private String userNick;

    @Column(name="user_gender")
    private String userGender;

    @Column(name="user_birthday")
    private String userBirthday;

    @CreatedDate
    @Column(name="user_createdate")
    private LocalDate userCreate;

    @LastModifiedDate
    @Column(name="user_modifydate")
    private LocalDate userModify;

/*

	// 생성, 수정 시간 형식 변경
	@PrePersist
	public void onPrePersist() {
		String customLocalDateTimeFormat = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		LocalDateTime parsedCreateDate = LocalDateTime.parse(customLocalDateTimeFormat, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		this.userCreate = parsedCreateDate;
		this.userModify = parsedCreateDate;
	}
*/


    public Member(@NonNull String userId, @NonNull String userPw, @NonNull String userName, String userNick,
                  String userGender, String userBirthday) {
        this.userId = userId;
        this.userPw = userPw;
        this.userName = userName;
        this.userNick = userNick;
        this.userGender = userGender;
        this.userBirthday = userBirthday;
    }

    public Member(@NonNull String userEmail, String userNick, String userGender, String userBirthday) {
        this.userEmail = userEmail;
        this.userNick = userNick;
        this.userGender = userGender;
        this.userBirthday = userBirthday;
    }
}