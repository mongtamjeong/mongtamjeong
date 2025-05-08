# 1. Python 3.11.5 slim 이미지 사용
FROM python:3.11.5-slim

# 2. 작업 디렉토리 설정
WORKDIR /app

# 3. 의존성 복사 및 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. 소스 코드 복사
COPY . .

# 5. 환경변수 및 포트 설정 (Cloud Run은 8080 필수)
ENV PORT=8080
EXPOSE 8080

# 6. 실행 명령 (Flask 서버 실행)
CMD ["python", "app.py"]
