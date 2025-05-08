from flask import Blueprint, request, jsonify
import pandas as pd
import io

location_bp = Blueprint("location", __name__)

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

def recommend_place(keyword: str):
    matches = df[df['name'].str.contains(keyword, case=False, na=False)]
    if matches.empty:
        return {"message": f"'{keyword}'와 관련된 분실물 기록이 없소..."}
    counts = matches['refined_place'].value_counts()
    return counts.head(5).to_dict()

@location_bp.route("/recommend-location", methods=["POST"])
def recommend_location():
    keyword = request.json.get("keyword", "").strip()
    if not keyword:
        return jsonify({"error": "No keyword provided"}), 400
    result = recommend_place(keyword)
    return jsonify(result)
