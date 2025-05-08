from flask import Flask, request, jsonify
import os
import torch
import torch.nn.functional as F
from PIL import Image
import torchvision.transforms as T
from torchvision.transforms.functional import InterpolationMode
from openai import OpenAI
import pandas as pd
import io
from io import BytesIO
import requests
import json


# ====== Flask 서버 시작 ======
app = Flask(__name__)

# ====== [1] Vision API 기반 이미지 분류 ======
from google.cloud import vision
from google.oauth2 import service_account

#key_info = json.loads(os.environ["GOOGLE_APPLICATION_CREDENTIALS_JSON"])
KEY_PATH = "vision-key.json"

credentials = service_account.Credentials.from_service_account_file(KEY_PATH)
client = vision.ImageAnnotatorClient(credentials=credentials)


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
    response = client.label_detection(image=image)
    labels = response.label_annotations
    label_names = [label.description.lower() for label in labels]
    category = get_final_category(label_names, category_dict)
    return jsonify({
        "top_label": max(labels, key=lambda x: x.score).description,
        "predicted_category": category
    })

# ====== [2] 이미지 유사도 비교 (DINOv2) ======
transform = T.Compose([
    T.Resize(224, interpolation=InterpolationMode.BICUBIC),
    T.CenterCrop(224),
    T.ToTensor(),
    T.Normalize([0.5]*3, [0.5]*3),
])
dinov2 = torch.hub.load('facebookresearch/dinov2', 'dinov2_vits14')
dinov2.eval()

import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate("mongtamjeong-firebase.json")
firebase_admin.initialize_app(cred)
fs_db = firestore.client()

def get_image_urls_from_firestore():
    docs = fs_db.collection("items").stream()
    return [doc.to_dict().get("imageUrl") for doc in docs if doc.to_dict().get("imageUrl")]

def load_image(file_storage):
    img = Image.open(file_storage).convert("RGB")
    return transform(img).unsqueeze(0)

def load_image_from_url(url):
    response = requests.get(url)
    response.raise_for_status()
    img = Image.open(BytesIO(response.content)).convert("RGB")
    return transform(img).unsqueeze(0)

@app.route("/match-from-db", methods=["POST"])
def match_from_firestore():
    uploaded = request.files.get("image")
    if not uploaded:
        return jsonify({"error": "No image uploaded"}), 400

    try:
        img1 = load_image(uploaded)
    except Exception as e:
        return jsonify({"error": f"Failed to process uploaded image: {str(e)}"}), 500

    results = []
    image_urls = get_image_urls_from_firestore()

    with torch.no_grad():
        feat1 = F.normalize(dinov2(img1), dim=-1)

        for url in image_urls:
            try:
                img2 = load_image_from_url(url)
                feat2 = F.normalize(dinov2(img2), dim=-1)
                sim = F.cosine_similarity(feat1, feat2).item() * 100

                if sim >= 50:
                    results.append({
                        "imageUrl": url,
                        "similarity": round(sim, 2)
                    })

            except Exception as e:
                results.append({
                    "imageUrl": url,
                    "error": str(e)
                })

    results = sorted(results, key=lambda x: x.get("similarity", 0), reverse=True)
    return jsonify(results[:5])

#     return jsonify({"similarity": round(sim, 2)})

#====== [3] 텍스트 기반 질문 생성 (GPT-4 API) ======

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

#===============================================================
with open('data.csv', 'rb') as f:
    raw = f.read()
text = raw.decode('cp949', errors='replace')
df = pd.read_csv(io.StringIO(text), sep=',')

df = df[['수령위치(회사)', '분실물종류', '분실물명', '보관장소']].dropna()
df.columns = ['company', 'kind', 'name', 'place']

def refine_place(row):
    if row['place'] == '회사내 분실센터':
        return f"{row['company']} 분실센터"
    else:
        return row['place']

df['refined_place'] = df.apply(refine_place, axis=1).str.strip()

# 🔹 추천 함수
def recommend_place(keyword: str):
    matches = df[df['name'].str.contains(keyword, case=False, na=False)]
    if matches.empty:
        return {"message": f"'{keyword}'와 관련된 분실물 기록이 없소..."}
    counts = matches['refined_place'].value_counts()
    return counts.head(5).to_dict()

# 🔹 API 엔드포인트
@app.route("/recommend-location", methods=["POST"])
def recommend_location():
    keyword = request.json.get("keyword", "").strip()
    if not keyword:
        return jsonify({"error": "No keyword provided"}), 400
    result = recommend_place(keyword)
    return jsonify(result)

if __name__ == "__main__":
    import os
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)