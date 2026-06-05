# Logi — AI 코딩 튜터 에이전트

로지버디 프로젝트의 AI 에이전트 모듈입니다. Claude API와 ReAct 방식으로 동작합니다.

## 설치 방법

```bash
# 가상환경 생성
python -m venv venv
venv\Scripts\activate  # Windows
# source venv/bin/activate  # Mac/Linux

# 패키지 설치
pip install -r requirements.txt

# .env 파일 작성
cp .env.example .env
# .env 파일을 열어 본인의 값으로 채워주세요

# Anthropic API 키 환경변수 설정 (Windows)
setx ANTHROPIC_API_KEY "sk-ant-api03-..."
```

## 실행

```bash
python app.py
```

브라우저에서 `http://localhost:5001` 접속

## 구조

- `app.py` — Flask 서버
- `logi_agent.py` — Logi ReAct 에이전트
- `tools.py` — 도구 4개 정의 (analyze_code, get_weak_topics, generate_problem, save_to_history)
- `db.py` — Supabase 연결
- `templates/chat.html` — 웹 채팅 UI

## 기술 스택

- Python 3.12
- Flask 3.x
- Anthropic Claude API (Haiku 4.5)
- Supabase (PostgreSQL)
- radon, ast (코드 정적 분석)