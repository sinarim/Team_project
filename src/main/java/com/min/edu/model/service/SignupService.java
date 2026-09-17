package com.min.edu.model.service;

import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.min.edu.dto.ProfileDto;
import com.min.edu.dto.UsersDto;
import com.min.edu.model.mapper.SignupMapper;

@Service
public class SignupService {

    private final SignupMapper signupMapper;

    public SignupService(SignupMapper signupMapper) {
        this.signupMapper = signupMapper;
    }


    @Transactional
    public void signup(String email, String password,
                       String role, String username) {

        // users와 profile에서 사용할 userId 생성
        String userId = UUID.randomUUID().toString();

        // users 정보
        UsersDto usersDto = new UsersDto();

        usersDto.setUserId(userId);
        usersDto.setEmail(email);
        usersDto.setPassword(password);
        usersDto.setRole(role);

        // users 저장
        signupMapper.insertUser(usersDto);


        // profile 정보
        String profileId = UUID.randomUUID().toString();

        ProfileDto profileDto = new ProfileDto();

        profileDto.setProfileId(profileId);
        profileDto.setUserId(userId);
        profileDto.setUsername(username);

        // profile 저장
        signupMapper.insertProfile(profileDto);
    }
}