from flask import Flask, render_template, request, jsonify
from logi_agent import LogiAgent

app = Flask(__name__)
agents = {}   # 세션별 에이전트 저장


@app.route("/")
def index():
    return render_template("chat.html")


@app.route("/api/chat", methods=["POST"])
def chat():
    data = request.get_json()
    user_id = data.get("user_id", "친구")
    message = data.get("message", "")
    
    if not message.strip():
        return jsonify({"error": "메시지가 비어있어요"}), 400
    
    # 학생별 에이전트 생성/재사용
    if user_id not in agents:
        agents[user_id] = LogiAgent(student_name=user_id)
    
    agent = agents[user_id]
    
    # 도구 호출 로그를 수집할 리스트
    tool_logs = []
    answer = agent.chat(message, tool_logs=tool_logs)
    
    return jsonify({
        "answer": answer,
        "tool_logs": tool_logs
    })


@app.route("/api/reset", methods=["POST"])
def reset():
    data = request.get_json()
    user_id = data.get("user_id", "친구")
    if user_id in agents:
        agents[user_id].reset()
    return jsonify({"status": "reset"})


if __name__ == "__main__":
    app.run(debug=True, port=5001)