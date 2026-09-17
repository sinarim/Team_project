package com.min.edu.ctrl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import jakarta.servlet.http.HttpSession;

@Controller
public class AnalysisController {

    @Autowired
    private RestTemplate restTemplate;

    @PostMapping("/submit-code")
    @ResponseBody // ◀ 데이터만 보냄
    public String analyzeCode(@RequestParam("userCode") String userCode, HttpSession session) {
        String flaskUrl = "http://localhost:5000/analyze";

        // [중요] JSON 객체로 명확하게 생성
        Map<String, Object> requestMap = new HashMap<>();
        requestMap.put("code", userCode); 
        
        // HTTP 헤더 설정 (JSON 형식임을 명시)
        org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
        headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);
        org.springframework.http.HttpEntity<Map<String, Object>> entity = new org.springframework.http.HttpEntity<>(requestMap, headers);

        try {
            String response = restTemplate.postForObject(flaskUrl, entity, String.class);
            session.setAttribute("analysisData", response); // 세션에 분석 결과 저장
            return "success";
        } catch (Exception e) {
            return "fail";
        }
    }

    @GetMapping("/analysis-result")
    public String showResult(HttpSession session, Model model) {
        String data = (String) session.getAttribute("analysisData");
        model.addAttribute("flaskData", data);
        return "analysisResult"; // analysisResult.jsp 파일로 이동
    }
}