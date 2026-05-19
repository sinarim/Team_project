package com.min.edu.ctrl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.min.edu.dto.ProblemDto;
import com.min.edu.model.mapper.ProblemMapper;

@Controller
public class ProblemController {

    @Autowired
    private ProblemMapper problemMapper;

    @GetMapping("/problem")
    public String showProblemList(@RequestParam(value = "id", required = false) String problemId, Model model) {
        
        List<ProblemDto> problemList = problemMapper.selectAllProblems();
        model.addAttribute("problemList", problemList); // 사이드바용 리스트 추가

        if (problemId == null) {
            // ID가 없으면 첫 번째 문제 보여주기
            model.addAttribute("problem", problemList.get(0));
        } else {
            // ID가 있으면 해당 ID와 일치하는 문제 찾기
            ProblemDto selectedProblem = problemList.stream()
                .filter(p -> p.getProblemId().toString().equals(problemId)) // UUID는 String으로 비교
                .findFirst()
                .orElse(problemList.get(0));
            model.addAttribute("problem", selectedProblem);
        }
        
        return "problemView";
    }
}