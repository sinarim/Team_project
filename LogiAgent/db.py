"""Supabase PostgreSQL 연결 관리"""
import os
import psycopg2
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv

load_dotenv()  # .env 파일 로드

def get_connection():
    """Supabase에 새 연결 생성"""
    return psycopg2.connect(
        host=os.getenv("SUPABASE_HOST"),
        port=int(os.getenv("SUPABASE_PORT", 6543)),
        dbname=os.getenv("SUPABASE_DB"),
        user=os.getenv("SUPABASE_USER"),
        password=os.getenv("SUPABASE_PASSWORD"),
        sslmode="require",
        cursor_factory=RealDictCursor   # 결과를 dict로 받기
    )


# 연결 테스트용 함수
def test_connection():
    """DB 접속 확인"""
    try:
        with get_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT NOW() as time, COUNT(*) as cnt FROM problems")
                result = cur.fetchone()
                print(f"✅ Supabase 연결 성공!")
                print(f"   서버 시간: {result['time']}")
                print(f"   문제 개수: {result['cnt']}개")
                return True
    except Exception as e:
        print(f"❌ 연결 실패: {e}")
        return False


if __name__ == "__main__":
    test_connection()