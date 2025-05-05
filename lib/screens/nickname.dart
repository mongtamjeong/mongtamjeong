import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';          // 인증용
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile.dart';

class Nickname extends StatefulWidget {
  const Nickname({super.key});

  @override
  State<Nickname> createState() => _NicknameState();
}

class _NicknameState extends State<Nickname> {
  final TextEditingController _nicknameController = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(_validateNickname);
  }

  void _validateNickname() {
    final nickname = _nicknameController.text;
    final isKoreanOrEnglish = RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(nickname);
    setState(() {
      _isValid = nickname.length <= 5 && isKoreanOrEnglish;
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '닉네임 설정',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Color(0xFFDDDDDD)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '이름을 설정해 주시오.',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                fontFamily: 'Pretendard Variable',
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _isValid ? const Color(0xFFB5FFFF) : Colors.red,
                ),
              ),
              child: TextField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  hintText: '닉네임 입력',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (!_isValid && _nicknameController.text.isNotEmpty)
              const Text(
                '한글, 영문만을 사용해 총 5자 이내로 입력해주세요.',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontFamily: 'Pretendard Variable',
                ),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isValid
                    ? () async {
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.reload();  // 사용자 정보 최신화
                  if (user != null && user.emailVerified) {
                    // Firestore에 닉네임 저장
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .set({
                      'nickname': _nicknameController.text.trim(),
                      'email': user.email,
                      'createdAt': FieldValue.serverTimestamp(),
                    }, SetOptions(merge: true));

                    // 프로필 화면으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile(nickname: _nicknameController.text)),
                    );
                  } else {
                    // 이메일 인증 안된 경우
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('이메일 인증 필요'),
                        content: const Text('이메일 인증을 완료해 주세요.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('확인'),
                          ),
                        ],
                      ),
                    );
                  }
                }
                    : null,

                style: ElevatedButton.styleFrom(
                  backgroundColor: _isValid ? const Color(0xFFB5FFFF) : const Color(0xFFDFDFDF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  '다음',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Pretendard Variable',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
