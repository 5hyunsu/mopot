package com.mopot.controller;

import com.mopot.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class TagController {

    @Autowired
    TagService tagService;
}
