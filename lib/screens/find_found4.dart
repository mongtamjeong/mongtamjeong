import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/image_upload_service.dart';
import '../services/post_write_service.dart';

class FindFound4 extends StatefulWidget {
  @override
  State<FindFound4> createState() => _FindFound4State();
}

class _FindFound4State extends State<FindFound4> {
  File? _selectedImage; // 선택된 이미지 저장용
  String? selectedCategory;
  final List<String> categoryOptions = ['가방', '서류봉투', '쇼핑', '옷','지갑', '책','핸드폰', '기타'];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _rewardController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitPost() async {
    if (selectedCategory == null ||
        _titleController.text.isEmpty ||
        _descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('모든 항목을 입력해 주세요.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      String imageUrl = '';
      if (_selectedImage != null) {
        imageUrl = await ImageUploadService().uploadImage(_selectedImage!);
      }

      await PostWriteService().uploadFoundPost(
        name: _titleController.text,
        kind: selectedCategory!,
        place: '',
        description: _descController.text,
        reward: _rewardController.text,
        imageUrl: imageUrl,
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('글 등록 중 오류가 발생했습니다.')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('찾았어요', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFDDDDDD)),
        ),
      ),

      //게시물 올리기
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('상품정보', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // 2. 사진 등록 박스
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                  image: _selectedImage != null
                      ? DecorationImage(image: FileImage(_selectedImage!), fit: BoxFit.cover)
                      : null,
                ),
                child: _selectedImage == null
                    ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 24, color: Colors.white),
                      SizedBox(height: 4),
                      Text('사진/동영상', style: TextStyle(fontSize: 10, color: Colors.white)),
                    ],
                  ),
                )
                    : null,
              ),
            ),


            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: '제목', border: UnderlineInputBorder()),
            ),
            const SizedBox(height: 16),

            // 4. 카테고리
            DropdownButtonFormField<String>(
              isDense: true,
              value: selectedCategory,
              onChanged: (value) => setState(() => selectedCategory = value),
              decoration: const InputDecoration(hintText: '카테고리', border: UnderlineInputBorder()),
              items: categoryOptions.map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Text('설명', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              maxLines: 5,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFEDEDED),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),
            const Text('추천문구', style: TextStyle(fontWeight: FontWeight.bold)),
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
            const Text('현상금', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _rewardController,
              decoration: const InputDecoration(hintText: '가격', border: UnderlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),



      //플로팅 액션 버튼
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: SizedBox(
          width: 379,
          height: 59,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFB5FFFF),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: _isSubmitting ? null : _submitPost,
            child: _isSubmitting
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
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
