<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>LogiBuddy 로그인</title>

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


/* 전체 로그인 박스 */
.login-wrapper {
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


/* 로그인 영역 */
.login-content {
    padding: 55px 48px 45px;
}

.login-title {
    text-align: center;

    font-size: 36px;
    font-weight: 700;

    margin-bottom: 42px;

    color: #222;
    letter-spacing: -2px;
}


/* 입력창 */
.input-box {
    position: relative;
    margin-bottom: 16px;
}

.input-box .icon {
    position: absolute;

    left: 16px;
    top: 50%;

    transform: translateY(-50%);

    font-size: 19px;
    color: #777;
}

.input-box input {
    width: 100%;
    height: 56px;

    padding: 0 16px 0 48px;

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


/* 로그인 버튼 */
.login-button {
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

.login-button:hover {
    background: #444;
}


/* 하단 */
.bottom-area {
    margin-top: 38px;
}

.divider {
    width: 100%;
    height: 1px;

    background: #ddd;

    margin-bottom: 25px;
}

.signup {
    text-align: center;
}

.signup a {
    text-decoration: none;

    font-size: 15px;
    font-weight: 600;

    color: #444;

    transition: 0.2s;
}

.signup a:hover {
    color: #111;
}


/* 모바일 */
@media (max-width: 500px) {

    .login-wrapper {
        width: calc(100% - 30px);
    }

    .login-content {
        padding: 45px 30px 38px;
    }

    .login-title {
        font-size: 32px;
    }
}

</style>
</head>


<body>

<div class="login-wrapper">

    <!-- 로고 -->
    <header class="header">
        <div class="logo">
            LogiBuddy
        </div>
    </header>


    <!-- 로그인 -->
    <main class="login-content">

        <h1 class="login-title">
            로그인
        </h1>


        <form action="/login" method="post">

            <!-- 아이디 -->
            <div class="input-box">

                <span class="icon">♙</span>

                <input
                    type="text"
                    name="loginId"
                    placeholder="아이디"
                    autocomplete="username"
                    required>

            </div>


            <!-- 비밀번호 -->
            <div class="input-box">

                <span class="icon">⚿</span>

                <input
                    type="password"
                    name="password"
                    placeholder="비밀번호"
                    autocomplete="current-password"
                    required>

            </div>


            <!-- 로그인 -->
            <button type="submit" class="login-button">
                로그인
            </button>

        </form>


        <!-- 회원가입 -->
        <div class="bottom-area">

            <div class="divider"></div>

            <div class="signup">
                <a href="/signup">
                    회원가입
                </a>
            </div>

        </div>

    </main>

</div>

</body>
</html>