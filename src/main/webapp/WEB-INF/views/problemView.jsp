<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PCCE 기출문제 풀기</title>
<style>
    /* 전체 테마 */
    body { font-family: 'Pretendard', 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #1e1e24; color: #e0e0e0; }
    .container { display: flex; height: 100vh; }
    
    /* 패널 설정 */
    .left-panel { width: 45%; padding: 20px; border-right: 1px solid #444; overflow-y: auto; background-color: #1e1e24; box-sizing: border-box; }
    .right-panel { width: 55%; padding: 20px; display: flex; flex-direction: column; background-color: #16161a; box-sizing: border-box; }
    
    /* 사이드바 */
    .sidebar-list { list-style: none; padding: 0; margin-top: 10px; }
    .sidebar-list li { margin: 6px 0; }
    .sidebar-list a { color: #888; text-decoration: none; font-size: 14px; }
    .sidebar-list a.active { color: #00e676; font-weight: bold; border-left: 3px solid #00e676; padding-left: 10px; }

    /* 뱃지 및 제목 */
    .badge { background-color: #333; padding: 3px 7px; border-radius: 4px; font-size: 11px; color: #ccc; margin-right: 5px; }
    h2 { color: #ffffff; margin-top: 10px; }
    
    /* 콘텐츠 박스 (밀도 높게 조정) */
    .content-box { background-color: #2b2b36; padding: 15px; border-radius: 8px; line-height: 1.4; white-space: pre-wrap; margin-top: 10px; font-size: 14px; color: #d1d1d1; }
    .section-title { font-size: 16px; font-weight: bold; color: #00e676; margin: 10px 0 5px 0; border-bottom: 1px solid #444; padding-bottom: 3px; }
    
    /* 이미지 및 제한사항 */
    .img-container { margin: 5px 0; text-align: center; }
    .limit-list { list-style: disc; padding-left: 20px; color: #ccc; margin: 5px 0 0 0; }

    /* 코드 에디터 */
    textarea { flex-grow: 1; background-color: #0d0d11; color: #7cfc00; font-family: 'Consolas', monospace; font-size: 14px; padding: 20px; border: 1px solid #555; border-radius: 8px; resize: none; }
    
    /* 버튼 */
    .btn-container { margin-top: 15px; text-align: right; }
    button { background-color: #2563eb; color: white; border: none; padding: 10px 25px; font-size: 14px; border-radius: 6px; cursor: pointer; font-weight: bold; }
    button:hover { background-color: #3b82f6; }
</style>
</head>
<body>

<div class="container">
    <div class="left-panel">
        <details open>
            <summary style="cursor: pointer; font-size: 18px; font-weight: bold; color: #00e676;">
                기출문제 목록 ▼
            </summary>
            <ul class="sidebar-list">
                <c:forEach items="${problemList}" var="p">
                    <li>
                        <a href="/problem?id=${p.problemId}" 
                           class="${p.problemId == problem.problemId ? 'active' : ''}">
                           ${p.title}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </details>

        <hr style="border: 0; border-top: 1px solid #333; margin: 25px 0;">

        <div>
            <span class="badge">${problem.source != null ? problem.source.toUpperCase() : 'PCCE'}</span>
            <span class="badge">난이도 ${problem.difficulty}</span>
        </div>
        <h2 style="margin-top: 10px;">${problem.title}</h2>
        
       <div class="content-box">
    <div class="section-title" style="margin-top: 0;">문제 설명</div>
    <div style="margin-bottom: 10px;">${problem.content}</div>

    <c:if test="${problem.problemId == '7a875293-f956-4264-a38c-478a894118b0'}">
        <div class="img-container">
            <img src="/images/twoproblem.png" alt="피타고라스" style="max-width: 60%; border-radius: 4px;">
        </div>
        
        <div class="section-title">제한사항</div>
        <ul style="list-style: disc; padding-left: 20px; color: #ccc; margin: 5px 0 0 0;">
            <li>1 ≤ a < c ≤ 100</li>
        </ul>
    </c:if>
</div>
    </div>
    
    <div class="right-panel">
        <h3 style="margin-top: 0; color: #888;">solution.cpp</h3>
        <textarea id="code-editor">${problem.initialCode}</textarea>
        <div class="btn-container">
            <input type="hidden" id="problem-id" value="${problem.problemId}">
            <button id="submit-btn" onclick="submitAnswer()">제출하고 분석하기</button>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 이미 작동이 확인된 줄바꿈 처리 로직 유지
        const contentBox = document.querySelector('.content-box');
        if(contentBox) {
            contentBox.innerHTML = contentBox.innerHTML.replaceAll('\\n', '\n').replaceAll('\\t', '\t');
        }
        document.getElementById('code-editor').value = document.getElementById('code-editor').value.replaceAll('\\n', '\n').replaceAll('\\t', '\t');
    });

    function submitAnswer() {
        const problemId = document.getElementById('problem-id').value;
        const userCode = document.getElementById('code-editor').value;
        
        fetch('/submit-code', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'problemId=' + encodeURIComponent(problemId) + '&userCode=' + encodeURIComponent(userCode)
        })
        .then(response => response.text())
        .then(data => {
            if(data === "success") location.href = "/analysis-result?problemId=" + problemId;
        });
    }
</script>
</body>
</html>
