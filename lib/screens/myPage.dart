import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'myPost.dart';
import 'chat1.dart';
import 'find_found1.dart';
import 'home.dart';
import 'terms.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Mypage extends StatefulWidget {
  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  File? _profileImage;
  String? _nickname;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _nickname = user.displayName;
        _profileImageUrl = user.photoURL;
      });
    }
  }

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${user.uid}.jpg');
        await ref.putFile(_profileImage!);
        final url = await ref.getDownloadURL();

        await user.updatePhotoURL(url);
        setState(() {
          _profileImageUrl = url;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('마이페이지', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFDDDDDD)),
        ),
      ),
      body: Container(
        color: const Color(0xFFF8FFFF),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _pickProfileImage,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(48.5),
                child: _profileImage != null
                    ? Image.file(_profileImage!, width: 97, height: 97, fit: BoxFit.cover)
                    : _profileImageUrl != null
                    ? Image.network(_profileImageUrl!, width: 97, height: 97, fit: BoxFit.cover)
                    : SvgPicture.asset('assets/images/profileImage.svg', width: 97, height: 97),
              ),
            ),
            const SizedBox(height: 23),
            Text(
              _nickname != null ? '$_nickname 님' : '사용자 님',
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600, fontFamily: 'Pretendard Variable'),
            ),
            const SizedBox(height: 30),
            Container(height: 6, color: Color(0xFFE0FFFF)),
            const SizedBox(height: 30),
            _buildMenuBox(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildMenuBox(BuildContext context) {
    return Center(
      child: Container(
        width: 381,
        height: 260,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFECECEC), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Mypost())),
              child: const Text('내가 쓴 글 보기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _showVersionInfo(context),
              child: const Text('버전정보', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Terms())),
              child: const Text('이용약관', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _showLogoutDialog(context),
              child: const Text('로그아웃', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _showDeleteDialog(context),
              child: const Text('서비스 탈퇴', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('로그아웃'),
        content: Text('정말 로그아웃 하시겠습니까?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('취소')),
          TextButton(onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), child: Text('확인')),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('서비스 탈퇴'),
        content: Text('계정을 완전히 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('취소')),
          TextButton(onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), child: Text('탈퇴하기', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 3,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFFB5FFFF),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FindFound1()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Chat1()));
        } else if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Mypage()));
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: '게시판'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '채팅'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
      ],
    );
  }
}

void _showVersionInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('버전정보'),
      content: const Text(
        '앱 이름: 몽탐정 – 분실물 찾기\n'
            '버전: 1.0.0\n'
            '빌드: 2025.05.09\n'
            '개발팀: Team 몽탐정\n'
            '문의: lostapp@teammong.kr\n\n'
            '© 2025 Team 몽탐정. All rights reserved.',
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('닫기')),
      ],
    ),
  );
}
