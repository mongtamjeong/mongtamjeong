from flask import Blueprint, request, jsonify,Flask
from openai import OpenAI
import os

app = Flask(__name__)

keyword_bp = Blueprint("keyword", __name__)
app.register_blueprint(keyword_bp)         

api_key = os.environ["OPENAI_API_KEY"]
client = OpenAI(api_key=api_key)  # 키 그대로 넣어도 됨

@keyword_bp.route("/keywords", methods=["POST"])
def extract_keywords():
    text = request.json.get("text", "")
    if not text:
        return jsonify({"error": "No text provided"}), 400
    
    with open("keyword_prompt.txt", "r", encoding="utf-8") as f:
        base_prompt = f.read()
        
    prompt = base_prompt.replace("{text}", text)

    response = client.chat.completions.create(
        model="gpt-4o",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3
    )
    return jsonify({"result": response.choices[0].message.content})

if __name__ == "__main__":
    import os
    port = int(os.environ.get("PORT", 5000))  # ← 꼭 이렇게
    app.run(host="0.0.0.0", port=port)