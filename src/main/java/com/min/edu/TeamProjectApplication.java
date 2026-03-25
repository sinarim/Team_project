package com.min.edu; // 본인의 실제 패키지명으로 적어주세요!

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication  // 여기에 커서를 올리고 Import가 잘 되었는지 확인하세요!
public class TeamProjectApplication {

    public static void main(String[] args) {
        // 이 한 줄이 스프링 부트를 실행하고 DB 연결을 시도합니다.
        SpringApplication.run(TeamProjectApplication.class, args);
        
        System.out.println("★ 스마트 금융 시스템 서버 시작됨! ★");
    }
}