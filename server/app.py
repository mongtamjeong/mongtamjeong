from flask import Flask, request, jsonify
import json
import os
import torch
import torch.nn.functional as F
from PIL import Image
import torchvision.transforms as T
from torchvision.transforms.functional import InterpolationMode
from openai import OpenAI
from sklearn.pipeline import Pipeline
from sklearn.ensemble import RandomForestClassifier
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from collections import Counter
import pandas as pd
import io
from io import BytesIO
import requests


# ====== Flask 서버 시작 ======
app = Flask(__name__)

# ====== [1] Vision API 기반 이미지 분류 ======
from google.cloud import vision
from google.oauth2 import service_account

#key_info = json.loads(os.environ["GOOGLE_APPLICATION_CREDENTIALS_JSON"])
key_json = os.environ["GOOGLE_APPLICATION_CREDENTIALS_JSON"]
credentials = service_account.Credentials.from_service_account_info(json.loads(key_json))
vision_client = vision.ImageAnnotatorClient(credentials=credentials)

with open("full_category_hierarchy.json", "r", encoding="utf-8") as f:
    category_dict = json.load(f)

def get_final_category(label_names, category_dict):
    for label in label_names:
        for final_cat, keywords in category_dict.items():
            if label in keywords:
                return final_cat
    return "기타"

@app.route("/analyze", methods=["POST"])
def analyze_image():
    file = request.files.get("image")
    if not file:
        return jsonify({"error": "No image uploaded"}), 400
    content = file.read()
    image = vision.Image(content=content)
    response = vision_client.label_detection(image=image)
    labels = response.label_annotations
    label_names = [label.description.lower() for label in labels]
    category = get_final_category(label_names, category_dict)
    return jsonify({
        "top_label": max(labels, key=lambda x: x.score).description,
        "predicted_category": category
    })

# # ====== [2] 이미지 유사도 비교 (DINOv2) ======
# transform = T.Compose([
#     T.Resize(224, interpolation=InterpolationMode.BICUBIC),
#     T.CenterCrop(224),
#     T.ToTensor(),
#     T.Normalize([0.5]*3, [0.5]*3),
# ])
# dinov2 = torch.hub.load('facebookresearch/dinov2', 'dinov2_vitb14')
# dinov2.eval()

# def load_image(file_storage):
#     img = Image.open(file_storage).convert("RGB")
#     return transform(img).unsqueeze(0)

# @app.route("/match", methods=["POST"])
# def compare_images():
#     uploaded = request.files.get("image")  # 사용자 업로드 이미지
#     db_image_url = request.form.get("db_image_url")  # 기존 이미지 URL

#     if not uploaded or not db_image_url:
#         return jsonify({"error": "Image file and db_image_url required"}), 400

#     # 업로드 이미지 처리
#     img1 = load_image(uploaded)

#     # DB 이미지 URL에서 다운로드
#     try:
#         response = requests.get(db_image_url)
#         response.raise_for_status()
#         db_img = Image.open(BytesIO(response.content)).convert("RGB")
#         img2 = transform(db_img).unsqueeze(0)
#     except Exception as e:
#         return jsonify({"error": f"Failed to load db image: {str(e)}"}), 500

#     # 유사도 계산
#     with torch.no_grad():
#         feat1 = F.normalize(dinov2(img1), dim=-1)
#         feat2 = F.normalize(dinov2(img2), dim=-1)
#         sim = F.cosine_similarity(feat1, feat2).item() * 100

#     return jsonify({"similarity": round(sim, 2)})

# ====== [3] 텍스트 기반 질문 생성 (GPT-4 API) ======
client = OpenAI(api_key=os.environ["OPENAI_API_KEY"])

@app.route("/keywords", methods=["POST"])
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


# # ====== [4] 장소 예측 (TF-IDF + Random Forest) ======
# # 데이터 로드 및 모델 학습은 서버 시작 시 1회만
# with open('data.csv', 'rb') as f:
#     raw = f.read()
# text = raw.decode('cp949', errors='replace')
# df = pd.read_csv(io.StringIO(text), sep=',')
# df = df[['수령위치(회사)', '분실물종류', '분실물명', '보관장소']].dropna()
# df.columns = ['company', 'kind', 'name', 'place']

# df['refined_place'] = df.apply(lambda row: row['place'] if row['place'] != '회사내 분실센터' else f"{row['company']} 분실센터", axis=1).str.strip()
# df['input_text'] = df['company'] + ' ' + df['kind'] + ' ' + df['name']

# X_train, X_test, y_train, y_test = train_test_split(
#     df['input_text'], df['refined_place'], test_size=0.2, random_state=42, stratify=df['refined_place'])

# def filter_by_support(X, y, min_count=30):
#     counts = Counter(y)
#     valid = {label for label, count in counts.items() if count >= min_count}
#     idx = [i for i, label in enumerate(y) if label in valid]
#     return X.iloc[idx], y.iloc[idx]

# X_train, y_train = filter_by_support(X_train, y_train)
# X_test, y_test = filter_by_support(X_test, y_test)

# pipeline = Pipeline([
#     ('tfidf', TfidfVectorizer()),
#     ('clf', RandomForestClassifier())
# ])
# pipeline.fit(X_train, y_train)

# @app.route("/predict-location", methods=["POST"])
# def predict_location():
#     input_text = request.json.get("text", "")
#     if not input_text:
#         return jsonify({"error": "No text input"}), 400
#     pred = pipeline.predict([input_text])[0]
#     return jsonify({"predicted_place": pred})


# ====== 실행 ======
if __name__ == "__main__":
    app.run(debug=True)
