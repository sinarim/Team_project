import os
import anthropic
from flask import Flask, request, jsonify

app = Flask(__name__)
client = anthropic.Anthropic(api_key=os.environ.get("ANTHROPIC_API_KEY"))

@app.route('/analyze', methods=['POST'])
def analyze_api():
    data = request.json
    target_code = data.get('code', '')
    
    if not target_code:
        return jsonify({"status": "error", "message": "코드가 없습니다."}), 400

    try:
        # Claude에게 코드 분석을 요청
        prompt = f"""
        다음 코드를 분석하여 JSON 형식으로 응답해줘. 
        필드: max_nesting(정수), functions(리스트), complexity(리스트: name, complexity, rank), mi_score(정수)
        코드:
        {target_code}
        """
        
        message = client.messages.create(
            model="claude-3-5-sonnet-20241022",
            max_tokens=1024,
            messages=[{"role": "user", "content": prompt}]
        )
        
        # AI가 보낸 응답을 그대로 전달 (응답이 JSON 문자열이라 가정)
        import json
        analysis_result = json.loads(message.content[0].text)
        
        return jsonify({"status": "success", **analysis_result})

    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)