package com.min.edu.model.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.min.edu.dto.ProblemDto;

@Mapper
public interface ProblemMapper {
    // 전체 문제 리스트 가져오기
    public List<ProblemDto> selectAllProblems();
}