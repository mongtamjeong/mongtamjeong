from flask import Blueprint, request, jsonify,Flask
import torch
import torch.nn.functional as F
from PIL import Image
import torchvision.transforms as T
from torchvision.transforms.functional import InterpolationMode
import requests
from io import BytesIO
import firebase_admin
import os
from firebase_admin import credentials, firestore, initialize_app 
import json

FIREBASE_KEY_PATH = os.environ["FIREBASE_CREDENTIALS_PATH"]
firebase_cred_dict = json.loads(FIREBASE_KEY_PATH)

cred = credentials.Certificate(firebase_cred_dict)
initialize_app(cred)
fs_db = firestore.client()

match_bp = Blueprint("match", __name__)

transform = T.Compose([
    T.Resize(224, interpolation=InterpolationMode.BICUBIC),
    T.CenterCrop(224),
    T.ToTensor(),
    T.Normalize([0.5]*3, [0.5]*3),
])
dinov2 = torch.hub.load('facebookresearch/dinov2', 'dinov2_vits14')
dinov2.eval()

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

@match_bp.route("/match-from-db", methods=["POST"])
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

app = Flask(__name__)
app.register_blueprint(match_bp) 

if __name__ == "__main__":
    import os
    port = int(os.environ.get("PORT", 5000))  # ← 꼭 이렇게
    app.run(host="0.0.0.0", port=port)
