"""Logi — AI 코딩 튜터 에이전트"""
import json
import anthropic
from tools import TOOLS, TOOL_FUNCTIONS

client = anthropic.Anthropic()

LOGI_PERSONA = """당신은 '로지(Logi)'입니다. 초등학생과 중학생에게 파이썬 코딩을 가르치는 친절한 AI 튜터예요.

원칙:
- 어려운 용어 대신 쉬운 말로 설명합니다
- 학생을 격려하고 칭찬합니다
- 정답을 바로 알려주지 않고 힌트로 유도합니다
- 한국어로 친근하게 대답합니다
- 답변은 3~5문장 이내로 짧게 합니다

도구 사용 원칙:
- 학생이 코드를 보여주며 분석/평가를 원하면 analyze_code를 사용하세요
- 학생이 약점을 묻거나 맞춤 추천이 필요하면 get_weak_topics를 사용하세요
- 학생이 문제를 원하면 generate_problem을 사용하세요
- 도구를 사용한 후, 결과를 학생에게 친근하게 풀어서 설명하세요
"""


class LogiAgent:
    """ReAct 방식으로 동작하는 AI 튜터 에이전트"""
    
    def __init__(self, student_name: str):
        self.student_name = student_name
        self.conversation_history = []
        self.system_prompt = LOGI_PERSONA + f"\n\n현재 대화 중인 학생의 이름(user_id)은 '{student_name}'입니다."
    
    def chat(self, user_message: str, tool_logs: list = None) -> str:
        """학생 메시지 → ReAct 루프 → 최종 답변
        
        tool_logs: 외부 리스트를 전달하면 도구 호출 기록이 채워짐 (웹 UI용)
        """
        if tool_logs is None:
            tool_logs = []   # 로그 안 쓰는 경우 빈 리스트
        
        # 학생 메시지를 history에 추가
        self.conversation_history.append({
            "role": "user",
            "content": user_message
        })
        
        # ReAct 루프
        while True:
            response = client.messages.create(
                model="claude-haiku-4-5-20251001",
                max_tokens=1000,
                system=self.system_prompt,
                tools=TOOLS,
                messages=self.conversation_history
            )
            
            self.conversation_history.append({
                "role": "assistant",
                "content": response.content
            })
            
            # 도구 호출이 없으면 종료
            if response.stop_reason != "tool_use":
                final_text = ""
                for block in response.content:
                    if block.type == "text":
                        final_text += block.text
                return final_text
            
            # 도구 실행
            tool_results = []
            for block in response.content:
                if block.type == "tool_use":
                    func = TOOL_FUNCTIONS[block.name]
                    result = func(**block.input)
                    
                    # 로그 기록
                    tool_logs.append({
                        "tool": block.name,
                        "input": block.input,
                        "result": result
                    })
                    
                    # 콘솔에도 출력 (디버깅용)
                    print(f"   🔧 {block.name}({json.dumps(block.input, ensure_ascii=False)[:60]}...)")
                    
                    tool_results.append({
                        "type": "tool_result",
                        "tool_use_id": block.id,
                        "content": json.dumps(result, ensure_ascii=False)
                    })
            
            self.conversation_history.append({
                "role": "user",
                "content": tool_results
            })
    
    def reset(self):
        """대화 기록 초기화"""
        self.conversation_history = []


# 콘솔에서 직접 테스트하고 싶을 때
if __name__ == "__main__":
    name = input("👤 너의 이름이 뭐야? ").strip() or "친구"
    logi = LogiAgent(student_name=name)
    
    print(f"\n🤖 Logi 시작! (종료: /quit)\n")
    
    while True:
        user_input = input("👤 너: ").strip()
        if user_input.lower() in ("/quit", "quit", "exit"):
            break
        if not user_input:
            continue
        
        answer = logi.chat(user_input)
        print(f"\n🤖 Logi: {answer}\n")