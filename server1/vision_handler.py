from flask import Blueprint, request, jsonify
import json
from google.cloud import vision
from google.oauth2 import service_account
import os

vision_bp = Blueprint("vision", __name__)

KEY_PATH = os.environ["GOOGLE_CREDENTIALS_PATH"]
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

@vision_bp.route("/analyze", methods=["POST"])
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
