<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LogiBuddy 회원가입</title>

<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: "Noto Sans KR", "Malgun Gothic", sans-serif;
    background: #f5f5f5;
    color: #333;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* 전체 회원가입 박스 */
.signup-wrapper {
    width: 430px;
    background: #fff;
    border: 1px solid #d8d8d8;
    border-radius: 18px;
    overflow: hidden;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.07);
}

/* 상단 */
.header {
    height: 72px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-bottom: 1px solid #ddd;
}

.logo {
    font-size: 25px;
    font-weight: 700;
    color: #222;
    letter-spacing: -1px;
}

/* 회원가입 영역 */
.signup-content {
    padding: 45px 48px 40px;
}

.signup-title {
    text-align: center;
    font-size: 34px;
    font-weight: 700;
    margin-bottom: 35px;
    color: #222;
    letter-spacing: -2px;
}

/* 입력창 */
.input-box {
    margin-bottom: 16px;
}

.input-box label {
    display: block;
    margin-bottom: 7px;
    font-size: 14px;
    font-weight: 600;
    color: #444;
}

.input-box input {
    width: 100%;
    height: 52px;
    padding: 0 16px;
    border: 1.5px solid #bdbdbd;
    border-radius: 12px;
    background: #fff;
    font-size: 15px;
    color: #222;
    outline: none;
    transition: 0.2s;
}

.input-box input::placeholder {
    color: #999;
}

.input-box input:focus {
    border-color: #333;
}

/* 회원가입 버튼 */
.signup-button {
    width: 100%;
    height: 58px;
    margin-top: 8px;
    border: none;
    border-radius: 12px;
    background: #222;
    color: #fff;
    font-size: 17px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.2s;
}

.signup-button:hover {
    background: #444;
}

/* 하단 */
.bottom-area {
    margin-top: 30px;
}

.divider {
    width: 100%;
    height: 1px;
    background: #ddd;
    margin-bottom: 22px;
}

.login-link {
    text-align: center;
}

.login-link a {
    text-decoration: none;
    font-size: 15px;
    font-weight: 600;
    color: #444;
    transition: 0.2s;
}

.login-link a:hover {
    color: #111;
}

/* 모바일 */
@media (max-width: 500px) {
    .signup-wrapper {
        width: calc(100% - 30px);
    }

    .signup-content {
        padding: 40px 30px 35px;
    }

    .signup-title {
        font-size: 31px;
    }
}
</style>

</head>

<body>

<div class="signup-wrapper">

```
<!-- 로고 -->
<header class="header">
    <div class="logo">
        LogiBuddy
    </div>
</header>

<!-- 회원가입 -->
<main class="signup-content">

    <h1 class="signup-title">
        회원가입
    </h1>

    <form action="/signup" method="post">

        <!-- 아이디 -->
        <div class="input-box">
            <label for="loginId">아이디</label>
            <input
                type="text"
                id="loginId"
                name="loginId"
                placeholder="아이디를 입력하세요"
                autocomplete="username"
                required>
        </div>

        <!-- 비밀번호 -->
        <div class="input-box">
            <label for="password">비밀번호</label>
            <input
                type="password"
                id="password"
                name="password"
                placeholder="비밀번호를 입력하세요"
                autocomplete="new-password"
                required>
        </div>

        <!-- 비밀번호 확인 -->
        <div class="input-box">
            <label for="passwordConfirm">비밀번호 확인</label>
            <input
                type="password"
                id="passwordConfirm"
                name="passwordConfirm"
                placeholder="비밀번호를 다시 입력하세요"
                autocomplete="new-password"
                required>
        </div>

        <!-- 이름 -->
        <div class="input-box">
            <label for="name">이름</label>
            <input
                type="text"
                id="name"
                name="name"
                placeholder="이름을 입력하세요"
                autocomplete="name"
                required>
        </div>

        <!-- 이메일 -->
        <div class="input-box">
            <label for="email">이메일</label>
            <input
                type="email"
                id="email"
                name="email"
                placeholder="이메일을 입력하세요"
                autocomplete="email"
                required>
        </div>

        <!-- 회원가입 -->
        <button type="submit" class="signup-button">
            회원가입
        </button>

    </form>

    <!-- 로그인 -->
    <div class="bottom-area">
        <div class="divider"></div>

        <div class="login-link">
            <a href="/login">
                이미 계정이 있으신가요? 로그인
            </a>
        </div>
    </div>

</main>
```

</div>

</body>
</html>
