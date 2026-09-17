package com.min.edu.ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.min.edu.model.service.SignupService;

@Controller
public class SignupController {

    private final SignupService signupService;

    public SignupController(SignupService signupService) {
        this.signupService = signupService;
    }


    // 회원가입 화면
    @GetMapping("/signup")
    public String signupPage() {

        return "signup";
    }


    // 회원가입 처리
    @PostMapping("/signup")
    public String signup(
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String role,
            @RequestParam String username) {

        signupService.signup(
                email,
                password,
                role,
                username
        );

        return "redirect:/login";
    }
}