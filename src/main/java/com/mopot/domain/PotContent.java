package com.mopot.domain;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@NoArgsConstructor
@Entity
@EntityListeners(AuditingEntityListener.class)
public class PotContent {
    @Id
    @SequenceGenerator(
            name="PotContentSEQ",
            sequenceName="PotContent_SEQ",
            allocationSize = 1
    )
    @GeneratedValue(generator="PotContentSEQ")
    @Column(name="pot_no")
    private Long potNo;

    @Column(name="pot_title")
    private String potTitle;

    @Column(name="pot_detail")
    private String potDetail;

    @Column(name="pot_writer")
    private String potWriter;

    @CreatedDate
    @Column(name="pot_create_date")
    private LocalDateTime potCreate;

    @LastModifiedDate
    @Column(name="pot_modify_date")
    private LocalDateTime potModify;

    @Column(name="pot_tag")
    private String potTag;

    @Column(name="pot_category")
    private String potCategory;

    @Column(name="pot_status")
    private int potStatus;
    
    @Column(name="pot_totalheadcount")
    private Long potTotalHeadcount;
    
    @Column(name="pot_nowheadcount")
    private Long potNowHeadcount;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date potStartTime;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date potEndTime;
    
    @Column(name="pot_place")
    private String potPlace;
    
}
