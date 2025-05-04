import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'complete.dart';

class Profile extends StatefulWidget {
  final String nickname;
  const Profile({super.key, required this.nickname});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('프로필 설정', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, color: Color(0xFFDDDDDD)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              '프로필을 설정해 주시오.',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                fontFamily: 'Pretendard Variable',
              ),
            ),
            const SizedBox(height: 133),

            //  프로필 이미지
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: ClipRect(
                  child: _selectedImage != null
                      ? Image.file(
                    _selectedImage!,
                    width: 182,
                    height: 182,
                    fit: BoxFit.cover,
                  )
                      : SvgPicture.asset(
                    'assets/images/profileImage.svg',
                    width: 182,
                    height: 182,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // '지금은 넘어가기'
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Complete(nickname: widget.nickname),
                    ),
                  );
                },
                child: const Text(
                  '지금은 넘어가기',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Pretendard Variable',
                    color: Color(0xFF7B7B7B),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // 다음 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB5FFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Complete(nickname: widget.nickname),
                ),
              );
            },
            child: const Text(
              '다음',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                fontFamily: 'Pretendard Variable',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
