<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>코드 분석 리포트</title>
    <style>
        body { background-color: #1e1e24; color: white; padding: 40px; font-family: sans-serif; }
        .report-card { background: #2b2b36; padding: 30px; border-radius: 12px; }
        .metric { margin: 20px 0; padding: 10px; border-bottom: 1px solid #444; }
        .score { color: #00e676; font-size: 24px; font-weight: bold; }
    </style>
</head>
<body>
    <div class="report-card">
        <h1>📊 코드 분석 리포트</h1>
        
        <div class="metric">
            <h3>최대 중첩 깊이 (Max Nesting)</h3>
            <p class="score">${flaskData.max_nesting}</p>
        </div>
        
        <div class="metric">
            <h3>유지보수성 점수 (MI Score)</h3>
            <p class="score">${flaskData.mi_score} 점</p>
        </div>
        
        <div class="metric">
            <h3>감지된 함수들</h3>
            <ul>
                <c:forEach items="${flaskData.functions}" var="func">
                    <li>${func}</li>
                </c:forEach>
            </ul>
        </div>
        
        <button onclick="location.href='/problem'">다시 풀기</button>
    </div>
</body>
</html>