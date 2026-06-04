"""Logi의 실제 도구 구현 — Supabase + Claude API 연동"""
import ast
import json
import anthropic
from radon.complexity import cc_visit, cc_rank
from radon.metrics import mi_visit
from db import get_connection

client = anthropic.Anthropic()


# ═════════════════════════════════════════════════
# 도구 1: 코드 분석 (radon/ast) — 이미 진짜로 작동
# ═════════════════════════════════════════════════
def analyze_code(code: str) -> dict:
    """학생 코드 정적 분석"""
    try:
        tree = ast.parse(code)
        
        def max_nesting(node, depth=0):
            if isinstance(node, (ast.For, ast.While, ast.If)):
                depth += 1
            children = [max_nesting(c, depth) for c in ast.iter_child_nodes(node)]
            return max(children, default=depth)
        
        funcs = [n.name for n in ast.walk(tree) if isinstance(n, ast.FunctionDef)]
        cc_results = cc_visit(code)
        complexity = [
            {"name": r.name, "score": r.complexity, "grade": cc_rank(r.complexity)}
            for r in cc_results
        ]
        mi = round(mi_visit(code, multi=True), 1)
        
        return {
            "nesting_depth": max_nesting(tree),
            "functions": funcs,
            "complexity": complexity,
            "mi_score": mi,
            "status": "success"
        }
    except SyntaxError as e:
        return {"status": "syntax_error", "message": str(e)}


# ═════════════════════════════════════════════════
# 도구 2: 약점 조회 — Supabase 진짜 연결
# ═════════════════════════════════════════════════
def get_weak_topics(user_id: str) -> dict:
    """learning_context 테이블에서 학생 취약점 조회"""
    try:
        with get_connection() as conn:
            with conn.cursor() as cur:
                # 학생 이름(username)으로 user_id 먼저 찾기
                cur.execute("""
                    SELECT u.user_id, lc.weak_topics, lc.error_patterns, lc.strategy_type
                    FROM users u
                    LEFT JOIN user_profile up ON u.user_id = up.user_id
                    LEFT JOIN learning_context lc ON u.user_id = lc.user_id
                    WHERE up.username = %s
                    LIMIT 1
                """, (user_id,))
                row = cur.fetchone()
                
                if not row:
                    # 학생 정보 자체가 없을 경우
                    return {
                        "user_id": user_id,
                        "weak_topics": [],
                        "message": f"'{user_id}' 학생의 학습 기록이 아직 없어요. 새 학생이라 분석할 데이터가 부족합니다.",
                        "status": "no_data"
                    }
                
                weak = row['weak_topics'] or []
                return {
                    "user_id": user_id,
                    "weak_topics": weak,
                    "error_patterns": row['error_patterns'] or {},
                    "strategy_type": row['strategy_type'],
                    "status": "success"
                }
    except Exception as e:
        return {"status": "error", "message": str(e)}


# ═════════════════════════════════════════════════
# 도구 3: 문제 생성 — Claude API로 진짜 생성
# ═════════════════════════════════════════════════
def generate_problem(category: str, difficulty: int) -> dict:
    """Claude API로 PCCE 스타일 문제 자동 생성"""
    
    prompt = f"""당신은 PCCE(파이썬 코딩 자격시험) 출제 전문가입니다.
초등학교 5~6학년, 중학교 1~2학년 수준의 파이썬 문제를 만들어주세요.

조건:
- 카테고리: {category}
- 난이도: {difficulty}단계 (1=매우 쉬움, 5=어려움)
- 유형: 빈칸 채우기 (코드의 ____ 부분을 채우는 문제)

반드시 아래 JSON 형식으로만 응답하세요. 다른 설명, 마크다운 코드 블록 절대 금지:
{{
  "title": "문제 제목",
  "content": "문제 설명. 코드 포함, 빈칸은 ____로 표시",
  "answer": "정답",
  "hint": "한 줄 힌트"
}}"""
    
    try:
        response = client.messages.create(
            model="claude-haiku-4-5-20251001",   # 문제 생성은 Haiku로 충분
            max_tokens=600,
            messages=[{"role": "user", "content": prompt}]
        )
        
        raw = response.content[0].text.strip()
        # 혹시 코드 블록으로 감싸서 오면 제거
        if raw.startswith("```"):
            raw = raw.split("```")[1]
            if raw.startswith("json"):
                raw = raw[4:]
        
        problem = json.loads(raw.strip())
        
        return {
            "category": category,
            "difficulty": difficulty,
            **problem,
            "status": "success"
        }
    except json.JSONDecodeError:
        return {"status": "parse_error", "message": "문제 생성 실패. 다시 시도해주세요."}
    except Exception as e:
        return {"status": "error", "message": str(e)}


# ═════════════════════════════════════════════════
# 도구 4: 대화 저장 — Supabase chat_history 진짜 INSERT
# ═════════════════════════════════════════════════
def save_to_history(user_id: str, message: str, role: str = "assistant") -> dict:
    """chat_history 테이블에 대화 저장"""
    try:
        with get_connection() as conn:
            with conn.cursor() as cur:
                # username으로 user_id 조회
                cur.execute("SELECT u.user_id FROM users u JOIN user_profile up ON u.user_id = up.user_id WHERE up.username = %s LIMIT 1", (user_id,))
                row = cur.fetchone()
                
                if not row:
                    return {"status": "no_user", "message": f"'{user_id}' 학생이 DB에 없어 저장 못함"}
                
                actual_user_id = row['user_id']
                
                cur.execute("""
                    INSERT INTO chat_history (user_id, role, message)
                    VALUES (%s, %s, %s)
                """, (actual_user_id, role, message))
                conn.commit()
                
                return {"status": "success", "saved": True}
    except Exception as e:
        return {"status": "error", "message": str(e)}


# ═════════════════════════════════════════════════
# Claude에게 알려줄 도구 명세 (스키마)
# ═════════════════════════════════════════════════
TOOLS = [
    {
        "name": "analyze_code",
        "description": "학생이 작성한 파이썬 코드를 정적 분석합니다. 중첩 깊이, 함수 목록, 순환 복잡도, 유지보수성 지수를 반환합니다. 학생이 자기 코드를 분석해달라고 요청할 때 사용하세요.",
        "input_schema": {
            "type": "object",
            "properties": {
                "code": {"type": "string", "description": "분석할 파이썬 코드"}
            },
            "required": ["code"]
        }
    },
    {
        "name": "get_weak_topics",
        "description": "학생의 취약한 학습 영역(개념)을 Supabase에서 조회합니다. 학생이 자기가 뭘 못하는지 물어볼 때, 또는 맞춤 문제를 추천하기 전에 사용하세요.",
        "input_schema": {
            "type": "object",
            "properties": {
                "user_id": {"type": "string", "description": "학생 이름 (username)"}
            },
            "required": ["user_id"]
        }
    },
    {
        "name": "generate_problem",
        "description": "PCCE 스타일의 파이썬 문제를 Claude API로 즉석에서 생성합니다. 학생이 '문제 내줘', '연습 문제 풀고 싶어' 라고 할 때 사용하세요.",
        "input_schema": {
            "type": "object",
            "properties": {
                "category": {"type": "string", "description": "문제 카테고리 (예: 반복문, 리스트, 함수, 조건문, 변수)"},
                "difficulty": {"type": "integer", "description": "난이도 1~5"}
            },
            "required": ["category", "difficulty"]
        }
    },
    {
        "name": "save_to_history",
        "description": "현재 대화의 중요한 내용을 Supabase chat_history에 저장합니다. 학생이 새 개념을 배웠거나 의미 있는 대화가 일어났을 때 사용하세요.",
        "input_schema": {
            "type": "object",
            "properties": {
                "user_id": {"type": "string"},
                "message": {"type": "string"},
                "role": {"type": "string", "description": "'user' 또는 'assistant'"}
            },
            "required": ["user_id", "message"]
        }
    },
]

TOOL_FUNCTIONS = {
    "analyze_code": analyze_code,
    "get_weak_topics": get_weak_topics,
    "generate_problem": generate_problem,
    "save_to_history": save_to_history,
}