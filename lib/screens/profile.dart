import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'complete.dart';

class Profile extends StatefulWidget {
  final String nickname;
  const Profile({super.key, required this.nickname});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _selectedImage;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _saveProfileAndProceed() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('사용자 없음');
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      String? imageUrl;

      // 이미지가 선택된 경우 업로드
      if (_selectedImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/${user.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        imageUrl = await storageRef.getDownloadURL();
      }

      // Firestore에 닉네임과 이미지 URL 저장
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'nickname': widget.nickname,
        'profileImage': imageUrl ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Complete(nickname: widget.nickname),
        ),
      );
    } catch (e) {
      print('프로필 저장 실패: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
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
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
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
            Center(
              child: GestureDetector(
                onTap: _saveProfileAndProceed,
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
            onPressed: _isUploading ? null : _saveProfileAndProceed,
            child: _isUploading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
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
