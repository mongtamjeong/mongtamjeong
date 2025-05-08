import os
import json
from google.cloud import vision
from google.oauth2 import service_account
from flask import Flask, request, jsonify

app = Flask(__name__)

# 🔹 구글 비전 API 인증
KEY_PATH = "vision-key.json"
credentials = service_account.Credentials.from_service_account_file(KEY_PATH)
client = vision.ImageAnnotatorClient(credentials=credentials)

# 🔹 8개 카테고리 로드 (파일명은 그대로 full_category_hierarchy.json)
with open("full_category_hierarchy.json", "r", encoding="utf-8") as f:
    category_dict = json.load(f)

# 🔹 딱 8개 중 하나만 리턴하는 함수
def get_final_category(label_names, category_dict):
    for label in label_names:
        for final_cat, keywords in category_dict.items():
            if label in keywords:
                return final_cat
    return "기타"

# 🔹 메인 API 엔드포인트
@app.route("/analyze", methods=["POST"])
def analyze_image():
    file = request.files.get("image")
    if not file:
        return jsonify({"error": "No image uploaded"}), 400

    content = file.read()
    image = vision.Image(content=content)
    response = client.label_detection(image=image)
    labels = response.label_annotations

    label_names = [label.description.lower() for label in labels]
    category = get_final_category(label_names, category_dict)

    return jsonify({
        "top_label": max(labels, key=lambda x: x.score).description,
        "predicted_category": category
    })

if __name__ == "__main__":
    app.run(debug=True)
