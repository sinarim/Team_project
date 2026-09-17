<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>PCCE 기출문제 풀기</title>

<style>

/* 전체 테마 */
body {
    font-family: 'Pretendard', 'Malgun Gothic', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #1e1e24;
    color: #e0e0e0;
}

.container {
    display: flex;
    height: 100vh;
    overflow: hidden; 
}

/* 패널 설정 */
.left-panel {
    width: 45%;
    min-width: 20%; 
    max-width: 80%; 
    padding: 20px;
    overflow-y: auto;
    overflow-x: hidden; /* 💡 패널 전체 가로 스크롤 차단 */
    background-color: #1e1e24;
    box-sizing: border-box;
}

/* 마우스로 드래그하는 구분선(Resizer) 스타일 */
.resizer {
    width: 5px;
    background-color: #333;
    cursor: col-resize;
    transition: background-color 0.2s;
    flex-shrink: 0;
}

.resizer:hover, .resizer.active {
    background-color: #00e676;
}

.right-panel {
    flex-grow: 1;
    padding: 20px;
    display: flex;
    flex-direction: column;
    background-color: #16161a;
    box-sizing: border-box;
    overflow: hidden;
}

/* 사이드바 */
.sidebar-list {
    list-style: none;
    padding: 0;
    margin-top: 10px;
}

.sidebar-list li {
    margin: 6px 0;
}

.sidebar-list a {
    color: #888;
    text-decoration: none;
    font-size: 14px;
}

.sidebar-list a.active {
    color: #00e676;
    font-weight: bold;
    border-left: 3px solid #00e676;
    padding-left: 10px;
}

/* 뱃지 및 제목 */
.badge {
    background-color: #333;
    padding: 3px 7px;
    border-radius: 4px;
    font-size: 11px;
    color: #ccc;
    margin-right: 5px;
}

h2 {
    color: #ffffff;
    margin-top: 10px;
}

/* 문제 내용 */
.content-box {
    background-color: #2b2b36;
    padding: 15px;
    border-radius: 8px;
    line-height: 1.4;
    margin-top: 10px;
    font-size: 14px;
    color: #d1d1d1;
}

.section-title {
    font-size: 16px;
    font-weight: bold;
    color: #00e676;
    margin: 10px 0 5px 0;
    border-bottom: 1px solid #444;
    padding-bottom: 3px;
}

/* 이미지 */
.img-container {
    margin: 10px 0;
    text-align: center;
}

/* 제한사항 */
.limit-list {
    list-style: disc;
    padding-left: 20px;
    color: #ccc;
    margin: 5px 0 0 0;
}

/* 문제별 영역 간격 */
.problem-section {
    margin-top: 24px;
}

/* 입출력 예 */
.io-title {
    font-size: 14px;
    color: #bfc5d0;
    margin: 18px 0 8px 0;
}

.io-box {
    background-color: #202b3f;
    padding: 20px 24px;
    border-radius: 4px;
    color: #d1d1d1;
    font-family: Consolas, monospace;
    line-height: 1.6;
    white-space: pre-wrap;
    margin-bottom: 12px;
}

/* 입출력 예 설명 */
.example-description {
    line-height: 1.6;
    margin-bottom: 25px;
}

.example-item {
    margin-bottom: 15px;
}

.example-item-title {
    margin-bottom: 5px;
}

/* 코드 에디터 */
textarea {
    flex-grow: 1;
    background-color: #0d0d11;
    color: #7cfc00;
    font-family: 'Consolas', monospace;
    font-size: 14px;
    padding: 20px;
    border: 1px solid #555;
    border-radius: 8px;
    resize: none;
}

/* 버튼 */
.btn-container {
    margin-top: 15px;
    text-align: right;
}

button {
    background-color: #2563eb;
    color: white;
    border: none;
    padding: 10px 25px;
    font-size: 14px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}

button:hover {
    background-color: #3b82f6;
}

.description-list {
    margin: 0 0 12px 0;
    padding-left: 25px;
}

/* 💡 표만 따로 감싸서 가로 스크롤을 부여하는 컨테이너 */
.saving-table-container {
    width: 100%;
    overflow-x: auto;
    margin-top: 10px;
    padding-bottom: 5px;
}

.saving-table {
    border-collapse: collapse;
    text-align: center;
    font-size: 14px;
}

.saving-table td {
    background-color: #202b3f;
    border: 1px solid #2b3548;
    padding: 8px 12px;
    min-width: 42px;
    white-space: nowrap; /* 셀 내부 글자 줄바꿈 방지 */
}

.content-box code {
    background-color: #202b3f;
    padding: 2px 5px;
    border-radius: 3px;
    color: #d1d1d1;
    font-family: Consolas, monospace;
}
</style>

</head>


<body>

<div class="container">

    <!-- 왼쪽 문제 영역 -->
    <div class="left-panel" id="left-panel">

        <!-- 문제 목록 -->
        <details open>

            <summary
                style="cursor: pointer;
                       font-size: 18px;
                       font-weight: bold;
                       color: #00e676;">

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


        <hr style="border: 0;
                   border-top: 1px solid #333;
                   margin: 25px 0;">


        <!-- 문제 정보 -->
        <div>

            <span class="badge">
                ${problem.source != null ? problem.source.toUpperCase() : 'PCCE'}
            </span>

            <span class="badge">
                난이도 ${problem.difficulty}
            </span>

        </div>


        <h2 style="margin-top: 10px;">
            ${problem.title}
        </h2>


        <!-- ================================================== -->
        <!-- 문제 내용 시작 -->
        <!-- ================================================== -->

        <div class="content-box">

            <!-- 문제 설명 -->
            <div class="section-title" style="margin-top: 0;">
                문제 설명
            </div>

            <div style="margin-bottom: 10px; white-space: pre-wrap;">
                ${problem.content}
            </div>

<!-- ================================================== -->
            <!-- PCCE 1번 -->
            <!-- ================================================== -->
            <c:if test="${problem.problemNumber == 1}">

                <div class="problem-section">
                    <div class="section-title">
                        출력 예시
                    </div>
                    <div class="io-box">Spring is beginning
13
310</div>
                </div>

            </c:if>
            <!-- ================================================== -->
            <!-- PCCE 2번 -->
            <!-- ================================================== -->
            <c:if test="${problem.problemNumber == 2}">

                <div class="img-container">
                    <img src="/images/twoproblem.png"
                         alt="피타고라스"
                         style="max-width: 60%; border-radius: 4px;">
                </div>

                <div class="section-title">
                    제한사항
                </div>

                <ul class="limit-list">
                    <li>1 ≤ a &lt; c ≤ 100</li>
                </ul>

            </c:if>


            <!-- ================================================== -->
            <!-- PCCE 3번 -->
            <!-- ================================================== -->
            <c:if test="${problem.problemNumber == 3}">

                <div class="problem-section">
                    <div class="section-title">
                        제한사항
                    </div>
                    <ul class="limit-list">
                        <li>1950 ≤ year ≤ 2030</li>
                        <li>age_type은 "Korea" 또는 "Year"만 주어집니다.</li>
                    </ul>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예
                    </div>
                    <div class="io-title">입력 #1</div>
                    <div class="io-box">2000\nKorea</div>
                    <div class="io-title">출력 #1</div>
                    <div class="io-box">31</div>
                    <div class="io-title">입력 #2</div>
                    <div class="io-box">1999\nYear</div>
                    <div class="io-title">출력 #2</div>
                    <div class="io-box">31</div>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예 설명
                    </div>
                    <div class="example-description">
                        <div class="example-item">
                            <div class="example-item-title">입출력 예 #1</div>
                            <ul style="margin: 0; padding-left: 25px;">
                                <li>2030년에 2000년생의 한국식 나이는 2030 - 2000 + 1 = 31살입니다.</li>
                            </ul>
                        </div>
                        <div class="example-item">
                            <div class="example-item-title">입출력 예 #2</div>
                            <ul style="margin: 0; padding-left: 25px;">
                                <li>2030년에 1999년생의 연 나이는 2030 - 1999 = 31살입니다.</li>
                            </ul>
                        </div>
                    </div>
                </div>

            </c:if>
            
            <!-- ================================================== -->
            <!-- PCCE 4번 -->
            <!-- ================================================== -->
            <c:if test="${problem.problemNumber == 4}">

                <div class="problem-section">
                    <div class="section-title">
                        제한사항
                    </div>
                    <ul class="limit-list">
                        <li>0 ≤ start ≤ 99</li>
                        <li>1 ≤ before ≤ after ≤ 25</li>
                    </ul>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예
                    </div>
                    <div class="io-title">입력 #1</div>
                    <div class="io-box">28\n6\n8</div>
                    <div class="io-title">출력 #1</div>
                    <div class="io-box">12</div>
                    <div class="io-title">입력 #2</div>
                    <div class="io-box">75\n8\n25</div>
                    <div class="io-title">출력 #2</div>
                    <div class="io-box">2</div>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예 설명
                    </div>
                    <div class="example-description">
                        <div class="io-title">입출력 예 #1</div>
                        <ul class="description-list">
                            <li>매월 저축된 금액은 아래 표와 같습니다. 따라서 12를 출력합니다.</li>
                        </ul>
                        <div class="saving-table-container">
                            <table class="saving-table">
                                <tr>
                                    <td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td>
                                </tr>
                                <tr>
                                    <td>28</td><td>34</td><td>40</td><td>46</td><td>52</td><td>58</td><td>64</td><td>70</td><td>78</td><td>86</td><td>94</td><td>102</td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="example-description">
                        <div class="io-title">입출력 예 #2</div>
                        <ul class="description-list">
                            <li>첫 달 저축된 금액이 70이 넘으므로 두 번째 달부터 바로 <code>after</code> = 25 만큼 저축합니다. 따라서 2를 출력합니다.</li>
                        </ul>
                        <div class="saving-table-container">
                            <table class="saving-table">
                                <tr>
                                    <td>1</td><td>2</td>
                                </tr>
                                <tr>
                                    <td>75</td><td>100</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

            </c:if>

            <!-- ================================================== -->
            <!-- PCCE 5번 -->
            <!-- ================================================== -->
            <c:if test="${problem.problemNumber == 5}">

                <div class="problem-section">
                    <div class="section-title">
                        제한사항
                    </div>
                    <ul class="limit-list">
                        <li>1 ≤ route의 길이 ≤ 20</li>
                        <li>route는 "N", "S", "E", "W"로만 이루어져 있습니다.</li>
                    </ul>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예
                    </div>
                    <div class="saving-table-container">
                        <table class="saving-table" style="width: 100%;">
                            <tr>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">route</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">result</th>
                            </tr>
                            <tr>
                                <td style="text-align: left;">"NSSNEWWN"</td>
                                <td style="text-align: left;">[-1, 1]</td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">"EESEEWNWSNWWNS"</td>
                                <td style="text-align: left;">[0, 0]</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예 설명
                    </div>
                    <div class="example-description">
                        <div class="io-title">입출력 예 #1</div>
                        <ul class="description-list">
                            <li><code>"NSSNEWWN"</code> 순서대로 움직이면 서쪽으로 1, 북쪽으로 1만큼 떨어진 곳에 도착하게 되므로 <code>[-1, 1]</code>을 return합니다.</li>
                        </ul>
                    </div>
                    <div class="example-description">
                        <div class="io-title">입출력 예 #2</div>
                        <ul class="description-list">
                            <li><code>"EESEEWNWSNWWNS"</code> 순서대로 움직이면 출발지와 같은 곳으로 돌아오므로 <code>[0, 0]</code>을 return합니다.</li>
                        </ul>
                    </div>
                </div>

                <div class="problem-section" style="font-size: 14px; color: #ccc; line-height: 1.6; margin-top: 25px;">
                    <ul style="list-style: disc; padding-left: 20px; margin: 0;">
                        <li style="margin-bottom: 10px;">
                            cpp를 응시하는 경우 리스트는 배열과 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) 번호가 담긴 정수 <code>리스트</code> <code>numbers</code>가 주어집니다. => 번호가 담긴 정수 <code>배열</code> <code>numbers</code>가 주어집니다.</li>
                            </ul>
                        </li>
                        <li>
                            java를 응시하는 경우 리스트는 배열, 함수는 메소드와 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) solution <code>함수</code>가 올바르게 작동하도록 한 줄을 수정해 주세요. => solution <code>메소드</code>가 올바르게 작동하도록 한 줄을 수정해 주세요.</li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </c:if>
          
            <!-- ================================================== -->
            <!-- PCCE 6번 -->
            <!-- ================================================== -->
            <c:if test="${problem.problemNumber == 6}">

                <div class="problem-section">
                    <div class="section-title">
                        제한사항
                    </div>
                    <ul class="limit-list">
                        <li>1 ≤ numbers의 길이 = our_score의 길이 ≤ 10</li>
                        <li>1 ≤ numbers의 원소 ≤ 31</li>
                        <li>0 ≤ our_score의 원소 ≤ 100</li>
                        <li>our_score[i]는 numbers[i]번 학생이 가채점한 점수입니다.</li>
                        <li>numbers는 중복된 원소를 가지지 않습니다.</li>
                        <li>2 ≤ score_list의 길이 ≤ 31</li>
                        <li>0 ≤ score_list의 원소 ≤ 100</li>
                        <li>score_list에는 실제 성적이 [1번 학생 성적, 2번 학생 성적, 3번 학생 성적 …] 순서로 들어있습니다.</li>
                    </ul>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예
                    </div>
                    <div class="saving-table-container">
                        <table class="saving-table" style="width: 100%;">
                            <tr>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">numbers</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">our_score</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">score_list</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">result</th>
                            </tr>
                            <tr>
                                <td style="text-align: left;">[1]</td>
                                <td style="text-align: left;">[100]</td>
                                <td style="text-align: left;">[100, 80, 90, 84, 20]</td>
                                <td style="text-align: left;">["Same"]</td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">[3, 4]</td>
                                <td style="text-align: left;">[85, 93]</td>
                                <td style="text-align: left;">[85, 92, 38, 93, 48, 85, 92, 56]</td>
                                <td style="text-align: left;">["Different", "Same"]</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예 설명
                    </div>
                    <div class="example-description">
                        <div class="io-title">입출력 예 #1</div>
                        <ul class="description-list">
                            <li>1번 학생이 가채점한 성적은 100점으로 실제 성적과 같기 때문에 <code>"Same"</code>을 담아 return합니다.</li>
                        </ul>
                    </div>
                    <div class="example-description">
                        <div class="io-title">입출력 예 #2</div>
                        <ul class="description-list">
                            <li>3번 학생이 가채점한 성적은 85점으로 실제 성적 38점과 다르기 때문에 <code>"Different"</code>를, 4번 학생이 채점한 성적은 93점으로 실제 성적과 같기 때문에 <code>"Same"</code>을 담아 return합니다.</li>
                        </ul>
                    </div>
                </div>

                <div class="problem-section" style="font-size: 14px; color: #ccc; line-height: 1.6; margin-top: 25px;">
                    <ul style="list-style: disc; padding-left: 20px; margin: 0;">
                        <li style="margin-bottom: 10px;">
                            cpp를 응시하는 경우 리스트는 배열과 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) 번호가 담긴 정수 <code>리스트</code> <code>numbers</code>가 주어집니다. => 번호가 담긴 정수 <code>배열</code> <code>numbers</code>가 주어집니다.</li>
                            </ul>
                        </li>
                        <li>
                            java를 응시하는 경우 리스트는 배열, 함수는 메소드와 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) solution <code>함수</code>가 올바르게 작동하도록 한 줄을 수정해 주세요. => solution <code>메소드</code>가 올바르게 작동하도록 한 줄을 수정해 주세요.</li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </c:if>
	
            <!-- ================================================== -->
            <!-- PCCE 7번 -->
            <!-- ================================================== -->
            <c:if test="${problem.problemNumber == 7}">

                <div class="problem-section">
                    <div class="section-title">
                        제한사항
                    </div>
                    <ul class="limit-list">
                        <li>mode_type은 "auto", "target", "minimum" 세 가지 중 하나의 값을 갖습니다.</li>
                        <li>0 ≤ humidity, val_set ≤ 100</li>
                    </ul>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예
                    </div>
                    <div class="saving-table-container">
                        <table class="saving-table" style="width: 100%;">
                            <tr>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">mode_type</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">humidity</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">val_set</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">result</th>
                            </tr>
                            <tr>
                                <td style="text-align: left;">"auto"</td>
                                <td style="text-align: left;">23</td>
                                <td style="text-align: left;">45</td>
                                <td style="text-align: left;">3</td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">"target"</td>
                                <td style="text-align: left;">41</td>
                                <td style="text-align: left;">40</td>
                                <td style="text-align: left;">1</td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">"minimum"</td>
                                <td style="text-align: left;">10</td>
                                <td style="text-align: left;">34</td>
                                <td style="text-align: left;">1</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예 설명
                    </div>
                    <div class="example-description">
                        <div class="io-title">입출력 예 #1</div>
                        <ul class="description-list">
                            <li><code>"auto"</code>모드이므로 습도에 따라 가습량이 조절됩니다. 현재 습도가 20 이상 30 미만이므로 <code>3</code>을 return합니다.</li>
                        </ul>
                    </div>
                    <div class="example-description">
                        <div class="io-title">입출력 예 #2</div>
                        <ul class="description-list">
                            <li><code>"target"</code>모드이고, 설정값보다 습도가 높으므로 <code>1</code>을 return합니다.</li>
                        </ul>
                    </div>
                    <div class="example-description">
                        <div class="io-title">입출력 예 #3</div>
                        <ul class="description-list">
                            <li><code>"minimum"</code>모드이고, 설정값보다 습도가 낮으므로 <code>1</code>을 return합니다.</li>
                        </ul>
                    </div>
                </div>

                <div class="problem-section" style="font-size: 14px; color: #ccc; line-height: 1.6; margin-top: 25px;">
                    <ul style="list-style: disc; padding-left: 20px; margin: 0;">
                        <li style="margin-bottom: 10px;">
                            cpp를 응시하는 경우 리스트는 배열과 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) 번호가 담긴 정수 <code>리스트</code> <code>numbers</code>가 주어집니다. => 번호가 담긴 정수 <code>배열</code> <code>numbers</code>가 주어집니다.</li>
                            </ul>
                        </li>
                        <li>
                            java를 응시하는 경우 리스트는 배열, 함수는 메소드와 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) solution <code>함수</code>가 올바르게 작동하도록 한 줄을 수정해 주세요. => solution <code>메소드</code>가 올바르게 작동하도록 한 줄을 수정해 주세요.</li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </c:if>
          
            <!-- ================================================== -->
            <!-- PCCE 8번 (문제 설명 중복 제거 및 이미지 8-1, 8-2, 8-3 정확한 위치 반영) -->
            <!-- ================================================== -->
            <c:if test="${problem.problemNumber == 8}">

                <!-- 💡 8-1 이미지만 문제 설명 영역 중간에 삽입 -->
                <div class="img-container" style="margin: 15px 0;">
                    <img src="${pageContext.request.contextPath}/images/8-1.png" alt="창고 정리 예시 1" style="max-width: 100%; height: auto; border-radius: 4px;">
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        제한사항
                    </div>
                    <ul class="limit-list">
                        <li>1 ≤ storage의 길이 = num의 길이 ≤ 30</li>
                        <li>storage[i]는 영어 대소문자로 이루어져 있습니다.</li>
                        <li>물건은 대소문자를 구분합니다. 즉, "Book"과 "book"은 서로 다른 물건입니다.</li>
                        <li>1 ≤ storage[i]의 길이 ≤ 30</li>
                        <li>1 ≤ num[i] ≤ 20</li>
                        <li>num[i]에는 storage[i]에 해당하는 물건의 개수가 담겨있습니다.</li>
                        <li>가장 개수가 많은 물건이 두 가지 이상인 경우는 없습니다.</li>
                        <li>한 칸에는 한 종류의 물건만 들어갈 수 있습니다.</li>
                    </ul>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예
                    </div>
                    <div class="saving-table-container">
                        <table class="saving-table" style="width: 100%;">
                            <tr>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">storage</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">num</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">result</th>
                            </tr>
                            <tr>
                                <td style="text-align: left;">["pencil", "pencil", "pencil", "book"]</td>
                                <td style="text-align: left;">[2, 4, 3, 1]</td>
                                <td style="text-align: left;">"pencil"</td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">["doll", "doll", "doll", "doll"]</td>
                                <td style="text-align: left;">[1, 1, 1, 1]</td>
                                <td style="text-align: left;">"doll"</td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">["apple", "steel", "leaf", "apple", "leaf"]</td>
                                <td style="text-align: left;">[5, 3, 5, 3, 7]</td>
                                <td style="text-align: left;">"leaf"</td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">["mirror", "net", "mirror", "net", "bottle"]</td>
                                <td style="text-align: left;">[4, 1, 4, 1, 5]</td>
                                <td style="text-align: left;">"mirror"</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예 설명
                    </div>

                    <div class="example-description">
                        <div class="io-title">입출력 예 #1</div>
                        <ul class="description-list">
                            <li>본문에 설명된 대로 창고를 정리하면 <code>clean_storage = ["pencil", "book"]</code>, <code>clean_num = [9, 1]</code>이 됩니다. 따라서 가장 개수가 많은 물건인 <code>"pencil"</code>을 return합니다.</li>
                        </ul>
                    </div>

                    <div class="example-description">
                        <div class="io-title">입출력 예 #2</div>
                        <ul class="description-list">
                            <li>창고를 정리하면 <code>clean_storage = ["doll"]</code>, <code>clean_num = [4]</code>가 됩니다. 따라서 가장 개수가 많은 물건인 <code>"doll"</code>을 return합니다.</li>
                        </ul>
                        <!-- 💡 8-2 이미지 삽입 -->
                        <div class="img-container" style="margin: 15px 0;">
                            <img src="${pageContext.request.contextPath}/images/8-2.png" alt="창고 정리 예시 2" style="max-width: 100%; height: auto; border-radius: 4px;">
                        </div>
                    </div>

                    <div class="example-description">
                        <div class="io-title">입출력 예 #3</div>
                        <ul class="description-list">
                            <li>창고를 정리하면 <code>clean_storage = ["apple", "steel", "leaf"]</code>, <code>clean_num = [8, 3, 12]</code>가 됩니다. 따라서 가장 개수가 많은 물건인 <code>"leaf"</code>를 return합니다.</li>
                        </ul>
                        <!-- 💡 8-3 이미지 삽입 -->
                        <div class="img-container" style="margin: 15px 0;">
                            <img src="${pageContext.request.contextPath}/images/8-3.png" alt="창고 정리 예시 3" style="max-width: 100%; height: auto; border-radius: 4px;">
                        </div>
                    </div>

                    <div class="example-description">
                        <div class="io-title">입출력 예 #4</div>
                        <ul class="description-list">
                            <li>창고를 정리하면 <code>clean_storage = ["mirror", "net", "bottle"]</code>, <code>clean_num = [8, 2, 5]</code>가 됩니다. 따라서 가장 개수가 많은 물건인 <code>"mirror"</code>를 return합니다.</li>
                        </ul>
                    </div>
                </div>

                <div class="problem-section" style="font-size: 14px; color: #ccc; line-height: 1.6; margin-top: 25px;">
                    <ul style="list-style: disc; padding-left: 20px; margin: 0;">
                        <li style="margin-bottom: 10px;">
                            cpp를 응시하는 경우 리스트는 배열과 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) 번호가 담긴 정수 <code>리스트</code> <code>numbers</code>가 주어집니다. => 번호가 담긴 정수 <code>배열</code> <code>numbers</code>가 주어집니다.</li>
                            </ul>
                        </li>
                        <li>
                            java를 응시하는 경우 리스트는 배열, 함수는 메소드와 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) solution <code>함수</code>가 올바르게 작동하도록 한 줄을 수정해 주세요. => solution <code>메소드</code>가 올바르게 작동하도록 한 줄을 수정해 주세요.</li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </c:if>
            
           <!-- ================================================== -->
            <!-- PCCE 9번 (이웃한 칸) -->
            <!-- ================================================== -->
            <c:if test="${problem.problemNumber == 9}">

                <div class="problem-section">
                    <div class="section-title">
                        제한사항
                    </div>
                    <ul class="limit-list">
                        <li>1 ≤ board의 길이 ≤ 7</li>
                        <li>board의 길이와 board[n]의 길이는 동일합니다.</li>
                        <li>0 ≤ h, w &lt; board의 길이</li>
                        <li>1 ≤ board[h][w]의 길이 ≤ 10</li>
                        <li>board[h][w]는 영어 소문자로만 이루어져 있습니다.</li>
                    </ul>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예
                    </div>
                    <div class="saving-table-container">
                        <table class="saving-table" style="width: 100%; table-layout: fixed;">
                            <colgroup>
                                <col style="width: 70%;">
                                <col style="width: 10%;">
                                <col style="width: 10%;">
                                <col style="width: 10%;">
                            </colgroup>
                            <tr>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">board</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">h</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">w</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">result</th>
                            </tr>
                            <tr>
                                <td style="text-align: left; white-space: pre-wrap; word-break: break-all; line-height: 1.5;">[["blue", "red", "orange", "red"], ["red", "red", "blue", "orange"], ["blue", "orange", "red", "red"], ["orange", "orange", "red", "blue"]]</td>
                                <td style="text-align: left; vertical-align: middle;">1</td>
                                <td style="text-align: left; vertical-align: middle;">1</td>
                                <td style="text-align: left; vertical-align: middle;">2</td>
                            </tr>
                            <tr>
                                <td style="text-align: left; white-space: pre-wrap; word-break: break-all; line-height: 1.5;">[["yellow", "green", "blue"], ["blue", "green", "yellow"], ["yellow", "blue", "blue"]]</td>
                                <td style="text-align: left; vertical-align: middle;">0</td>
                                <td style="text-align: left; vertical-align: middle;">1</td>
                                <td style="text-align: left; vertical-align: middle;">1</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예 설명
                    </div>

                    <div class="example-description">
                        <div class="io-title">입출력 예 #1</div>
                        <ul class="description-list">
                            <li>주어진 보드를 나타내면 아래 그림과 같고, <code>board[1][1]</code>의 인접한 칸들은 화살표가 가리키는 칸들입니다. 따라서 <code>board[1][1]</code> 주변의 <code>"red"</code> 칸은 총 2개입니다.</li>
                        </ul>
                        <!-- 💡 9-1 이미지 삽입 -->
                        <div class="img-container" style="margin: 15px 0;">
                            <img src="${pageContext.request.contextPath}/images/9-1.png" alt="이웃한 칸 예시 1" style="max-width: 100%; height: auto; border-radius: 4px;">
                        </div>
                    </div>

                    <div class="example-description">
                        <div class="io-title">입출력 예 #2</div>
                        <ul class="description-list">
                            <li>주어진 보드를 나타내면 아래 그림과 같고, <code>board[0][1]</code>의 인접한 칸들은 화살표가 가리키는 칸들입니다. 따라서 <code>board[0][1]</code> 주변의 <code>"green"</code> 칸은 총 1개입니다.</li>
                        </ul>
                        <!-- 💡 9-2 이미지 삽입 -->
                        <div class="img-container" style="margin: 15px 0;">
                            <img src="${pageContext.request.contextPath}/images/9-2.png" alt="이웃한 칸 예시 2" style="max-width: 100%; height: auto; border-radius: 4px;">
                        </div>
                    </div>
                </div>

                <div class="problem-section" style="font-size: 14px; color: #ccc; line-height: 1.6; margin-top: 25px;">
                    <ul style="list-style: disc; padding-left: 20px; margin: 0;">
                        <li style="margin-bottom: 10px;">
                            cpp를 응시하는 경우 리스트는 배열과 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) 번호가 담긴 정수 <code>리스트</code> <code>numbers</code>가 주어집니다. => 번호가 담긴 정수 <code>배열</code> <code>numbers</code>가 주어집니다.</li>
                            </ul>
                        </li>
                        <li>
                            java를 응시하는 경우 리스트는 배열, 함수는 메소드와 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) solution <code>함수</code>가 올바르게 작동하도록 한 줄을 수정해 주세요. => solution <code>메소드</code>가 올바르게 작동하도록 한 줄을 수정해 주세요.</li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </c:if>
            
            <!-- ================================================== -->
            <!-- PCCE 10번 (데이터 분석) -->
            <!-- ================================================== -->
            <c:if test="${problem.problemNumber == 10}">

                <div class="problem-section">
                    <div class="section-title">
                        제한사항
                    </div>
                    <ul class="limit-list">
                        <li>1 ≤ data의 길이 ≤ 500</li>
                        <li>data[i]의 원소는 [코드 번호(code), 제조일(date), 최대 수량(maximum), 현재 수량(remain)] 형태입니다.</li>
                        <li>1 ≤ 코드 번호 ≤ 100,000</li>
                        <li>20000101 ≤ 제조일 ≤ 29991231</li>
                        <li>data[i][1]은 yyyymmdd 형태의 값을 가지며, 올바른 날짜만 주어집니다. (yyyy : 연도, mm : 월, dd : 일)</li>
                        <li>1 ≤ 최대 수량 ≤ 10,000</li>
                        <li>1 ≤ 현재 수량 ≤ 최대 수량</li>
                        <li>ext와 sort_by의 값은 다음 중 한 가지를 가집니다: <code>"code"</code>, <code>"date"</code>, <code>"maximum"</code>, <code>"remain"</code>
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>순서대로 코드 번호, 제조일, 최대 수량, 현재 수량을 의미합니다.</li>
                            </ul>
                        </li>
                        <li>val_ext는 ext에 따라 올바른 범위의 숫자로 주어집니다.</li>
                        <li>정렬 기준에 해당하는 값이 서로 같은 경우는 없습니다.</li>
                    </ul>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예
                    </div>
                    <div class="saving-table-container">
                        <table class="saving-table" style="width: 100%; table-layout: fixed;">
                            <colgroup>
                                <col style="width: 50%;">
                                <col style="width: 15%;">
                                <col style="width: 10%;">
                                <col style="width: 10%;">
                                <col style="width: 15%;">
                            </colgroup>
                            <tr>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">data</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">ext</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">val_ext</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">sort_by</th>
                                <th style="background-color: #202b3f; border: 1px solid #2b3548; padding: 8px 12px; font-weight: bold; color: #d1d1d1; text-align: left;">result</th>
                            </tr>
                            <tr>
                                <td style="text-align: left; white-space: pre-wrap; word-break: break-all; line-height: 1.5;">[[1, 20300104, 100, 80], [2, 20300804, 847, 37], [3, 20300401, 10, 8]]</td>
                                <td style="text-align: left; vertical-align: middle;">"date"</td>
                                <td style="text-align: left; vertical-align: middle;">20300501</td>
                                <td style="text-align: left; vertical-align: middle;">"remain"</td>
                                <td style="text-align: left; white-space: pre-wrap; word-break: break-all; vertical-align: middle; line-height: 1.5;">[[3,20300401,10,8],[1,20300104,100,80]]</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="problem-section">
                    <div class="section-title">
                        입출력 예 설명
                    </div>
                    <div class="example-description">
                        <div class="io-title">입출력 예 #1</div>
                        <ul class="description-list">
                            <li>본문의 내용과 동일합니다.</li>
                        </ul>
                    </div>
                </div>

                <div class="problem-section" style="font-size: 14px; color: #ccc; line-height: 1.6; margin-top: 25px;">
                    <ul style="list-style: disc; padding-left: 20px; margin: 0;">
                        <li style="margin-bottom: 10px;">
                            cpp를 응시하는 경우 리스트는 배열과 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) 번호가 담긴 정수 <code>리스트</code> <code>numbers</code>가 주어집니다. => 번호가 담긴 정수 <code>배열</code> <code>numbers</code>가 주어집니다.</li>
                            </ul>
                        </li>
                        <li>
                            java를 응시하는 경우 리스트는 배열, 함수는 메소드와 동일한 의미이니 풀이에 참고해주세요.
                            <ul style="list-style: circle; padding-left: 20px; margin-top: 4px;">
                                <li>ex) solution <code>함수</code>가 올바르게 작동하도록 한 줄을 수정해 주세요. => solution <code>메소드</code>가 올바르게 작동하도록 한 줄을 수정해 주세요.</li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </c:if>
        </div>

    </div>

    <div class="resizer" id="resizer"></div>

    <!-- 오른쪽 코드 에디터 영역 -->
    <div class="right-panel" id="right-panel">
        <form action="/problem/submit" method="post" style="display: flex; flex-direction: column; height: 100%;">
            <input type="hidden" name="problemId" value="${problem.problemId}">
            <textarea name="code">${userCode != null ? userCode : problem.initialCode}</textarea>
            <div class="btn-container">
                <button type="submit">제출하기</button>
            </div>
        </form>
    </div>

</div>

<script>
    // 레이아웃 조절용 스크립트
    const resizer = document.getElementById('resizer');
    const leftPanel = document.getElementById('left-panel');
    const rightPanel = document.getElementById('right-panel');

    let isResizing = false;

    resizer.addEventListener('mousedown', function (e) {
        isResizing = true;
        resizer.classList.add('active');
        document.addEventListener('mousemove', resize);
        document.addEventListener('mouseup', stopResize);
    });

    function resize(e) {
        if (!isResizing) return;
        const containerWidth = document.querySelector('.container').offsetWidth;
        const newLeftWidth = (e.clientX / containerWidth) * 100;
        if (newLeftWidth > 20 && newLeftWidth < 80) {
            leftPanel.style.width = newLeftWidth + '%';
        }
    }

    function stopResize() {
        isResizing = false;
        resizer.classList.remove('active');
        document.removeEventListener('mousemove', resize);
        document.removeEventListener('mouseup', stopResize);
    }
</script>

</body>
</html>