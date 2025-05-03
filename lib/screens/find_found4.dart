import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';



class FindFound4 extends StatefulWidget {
  @override
  State<FindFound4> createState() => _FindFound3State();
}

class _FindFound3State extends State<FindFound4> {
  File? _selectedImage; // 선택된 이미지 저장용

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile_found = await picker.pickImage(
        source: ImageSource.gallery); // 갤러리 호출

    if (pickedFile_found != null) {
      setState(() {
        _selectedImage = File(pickedFile_found.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '찾았어요',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFDDDDDD),
          ),
        ),
      ),

      //게시물 올리기
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 섹션 제목
            const Text(
              '상품정보',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // 2. 사진 등록 박스
            GestureDetector(
              onTap: _pickImage, // 클릭 시 갤러리 열기
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                  image: _selectedImage != null
                      ? DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: _selectedImage == null
                    ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 24, color: Colors.white),
                      SizedBox(height: 4),
                      Text(
                        '사진/동영상',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                )
                    : null,
              ),
            ),


            const SizedBox(height: 24),

            // 3. 제목
            const TextField(
              decoration: InputDecoration(
                hintText: '제목',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // 4. 카테고리
            const TextField(
              decoration: InputDecoration(
                hintText: '카테고리',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // 5. 설명
            const Text(
              '설명',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const TextField(
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFEDEDED),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),

            // 6. 추천문구
            const Text(
              '추천문구',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                Chip(label: Text('색깔은?')),
                Chip(label: Text('케이스 유/무')),
                Chip(label: Text('일련번호')),
                Chip(label: Text('눈에 띄는 특징')),
              ],
            ),
            const SizedBox(height: 20),

            // 7. 현상금
            const Text(
              '현상금',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                hintText: '가격',
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 120), // 하단 버튼 공간 확보
          ],
        ),
      ),



      //플로팅 액션 버튼
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12), // 버튼 하단 여백
        child: SizedBox(
          width: 379, // 너비를 넓게
          height: 59, // 높이 지정
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFB5FFFF), // 하늘색
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              // TODO: 글 등록 기능 연결
            },
            child: const Text(
              '글 올리기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
