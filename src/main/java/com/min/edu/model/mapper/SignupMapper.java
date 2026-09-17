package com.min.edu.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.min.edu.dto.ProfileDto;
import com.min.edu.dto.UsersDto;

@Mapper
public interface SignupMapper {

    int insertUser(UsersDto dto);

    int insertProfile(ProfileDto dto);

}