<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코드 분석 리포트</title>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">
<style>
    body { 
        font-family: 'Nanum Gothic', sans-serif; 
        background-color: #f0f2f5; 
        display: flex; 
        justify-content: center; 
        align-items: center; 
        min-height: 100vh;
        margin: 0;
    }
    .card { 
        background: white; 
        width: 700px; 
        padding: 40px; 
        border-radius: 20px; 
        box-shadow: 0 15px 35px rgba(0,0,0,0.1); 
        border-top: 8px solid #005088; /* 아림님의 메인 컬러 */
    }
    h2 { color: #005088; text-align: center; margin-bottom: 30px; }
    
    /* 결과 요약 그리드 */
    .summary-grid {
        display: grid;
        grid-template-columns: 1fr 1fr 1fr;
        gap: 15px;
        margin-bottom: 30px;
    }
    .summary-item {
        background: #f8f9fa;
        padding: 15px;
        border-radius: 12px;
        text-align: center;
        border: 1px solid #e9ecef;
    }
    .summary-item label { font-size: 13px; color: #6c757d; display: block; margin-bottom: 5px; }
    .summary-item span { font-size: 20px; font-weight: bold; color: #005088; }

    /* 데이터 박스 디자인 */
    .data-title { font-weight: bold; margin-bottom: 10px; color: #333; display: flex; align-items: center; }
    .data-box { 
        background: #2d3436; 
        color: #00cec9; 
        padding: 20px; 
        border-radius: 10px; 
        font-family: 'Consolas', monospace; 
        font-size: 14px;
        overflow-x: auto; 
        white-space: pre-wrap;
        margin-bottom: 25px;
    }
    
    .btn-area { text-align: center; }
    .btn-re { 
        background: #005088; 
        color: white; 
        border: none; 
        padding: 12px 30px; 
        border-radius: 8px; 
        cursor: pointer; 
        font-size: 16px;
        transition: 0.3s;
    }
    .btn-re:hover { background: #003d66; }
</style>
</head>
<body>
    <div class="card">
        <h2>📊 실시간 코드 분석 리포트</h2>
        
        <div class="summary-grid">
            <div class="summary-item">
                <label>복잡도 등급</label>
                <span id="rank-val">-</span>
            </div>
            <div class="summary-item">
                <label>유지보수 지수</label>
                <span id="mi-val">-</span>
            </div>
            <div class="summary-item">
                <label>최대 중첩 깊이</label>
                <span id="nesting-val">-</span>
            </div>
        </div>

        <div class="data-title">✅ 원본 분석 JSON 데이터</div>
        <div class="data-box" id="raw-json">${flaskData}</div>
        
        <div class="btn-area">
            <button class="btn-re" onclick="location.href='/analyze-test'">새로고침 분석</button>
        </div>
    </div>

    <script>
        try {
            // Controller에서 보낸 JSON 문자열을 객체로 변환
            const resultStr = document.getElementById('raw-json').innerText;
            const data = JSON.parse(resultStr);
            
            // 항목별 데이터 매핑
            // complexity 배열의 첫 번째 요소에서 rank 추출
            if(data.complexity && data.complexity.length > 0) {
                document.getElementById('rank-val').innerText = "Rank " + data.complexity[0].rank;
            }
            
            // 유지보수 지수 및 중첩 깊이 매핑
            document.getElementById('mi-val').innerText = data.mi_score.toFixed(1) + " / 100";
            document.getElementById('nesting-val').innerText = data.max_nesting + " Level";
            
        } catch (e) {
            console.error("데이터 파싱 에러:", e);
        }
    </script>
</body>
</html>