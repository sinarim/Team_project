package com.min.edu.ctrl;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.client.RestTemplate;

@Controller
public class AnalysisController {

    @Autowired
    private RestTemplate restTemplate;

    @GetMapping("/analyze-test")
    public ModelAndView testFlask() {
        // 이동할 JSP 파일명 (WEB-INF/views/analysisResult.jsp)
        ModelAndView mav = new ModelAndView("analysisResult"); 
        
        // VS Code에서 실행 중인 Flask API 주소
        String flaskUrl = "http://localhost:5000/analyze"; 

        // [바이브 포인트] 분석할 "복잡한 파이썬 코드"를 작성합니다.
        // 이 코드는 for-if-for-if 구조로 되어 있어 중첩 깊이가 4단계로 나옵니다.
        StringBuilder complexCode = new StringBuilder();
        complexCode.append("def find_numbers(data):\n");
        complexCode.append("    result = []\n");
        complexCode.append("    for i in range(len(data)):\n");      // 1단계 (for)
        complexCode.append("        if data[i] > 0:\n");               // 2단계 (if)
        complexCode.append("            for j in range(data[i]):\n");  // 3단계 (for)
        complexCode.append("                if j % 2 == 0:\n");        // 4단계 (if)
        complexCode.append("                    result.append(j)\n");
        complexCode.append("    return result");

        Map<String, String> request = new HashMap<>();
        request.put("code", complexCode.toString());

        try {
            // Flask 서버에 POST 요청을 보내고 JSON 응답을 String으로 받음
            String response = restTemplate.postForObject(flaskUrl, request, String.class);
            
            // JSP 화면으로 데이터 전달
            mav.addObject("flaskData", response); 
            mav.addObject("msg", "🔥 복잡도 테스트 모드 (4단계 중첩)");
            
            // 콘솔에서도 결과를 확인할 수 있게 출력
            System.out.println("Flask Response: " + response);
            
        } catch (Exception e) {
            mav.addObject("msg", "❌ Flask 통신 실패!");
            mav.addObject("flaskData", "에러 사유: " + e.getMessage());
        }
        
        return mav;
    }
}