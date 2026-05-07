package com.min.edu.ctrl;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping; // GetMapping 추가
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class AnalysisController {

    @Autowired
    private RestTemplate restTemplate;

    // 브라우저 주소창 테스트를 위해 GetMapping으로 변경
    @GetMapping("/analyze-test")
    public String testFlask() {
        // Flask 서버 주소 (VS Code에서 켜진 주소)
        String flaskUrl = "http://localhost:5000/analyze"; 

        // Flask로 보낼 테스트용 코드 데이터
        Map<String, String> request = new HashMap<>();
        request.put("code", "def check():\n    return 'Spring to Flask Success!'");

        try {
            // Flask 서버에 POST 요청을 보내고 결과 받기
            String response = restTemplate.postForObject(flaskUrl, request, String.class);
            return "✅ Flask 통신 성공! 분석 결과: " + response;
        } catch (Exception e) {
            return "❌ Flask 통신 실패! 사유: " + e.getMessage();
        }
    }
}