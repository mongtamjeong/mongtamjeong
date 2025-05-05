import 'package:flutter/material.dart';
import 'nickname.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  final _pwController = TextEditingController();
  final _pwCheckController = TextEditingController();

  bool _isEmailValid = false;
  bool _emailSent = false;
  bool _isPasswordMatch = true;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _idController.addListener(_validateForm);
    _pwController.addListener(_validateForm);
    _pwCheckController.addListener(() {
      _validateForm();
      setState(() {
        _isPasswordMatch = _pwController.text == _pwCheckController.text;
      });
    });
  }

  void _validateForm() {
    final email = _emailController.text.trim();
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

    setState(() {
      _isEmailValid = emailRegex.hasMatch(email);
      _isFormValid = _isEmailValid &&
          _idController.text.trim().isNotEmpty &&
          _pwController.text.trim().isNotEmpty &&
          _pwCheckController.text.trim().isNotEmpty &&
          (_pwController.text == _pwCheckController.text) &&
          _emailSent;
    });
  }

  InputDecoration _inputDecoration({bool error = false}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: error ? Colors.red : const Color(0xFFB5FFFF),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: error ? Colors.red : const Color(0xFFB5FFFF),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _idController.dispose();
    _pwController.dispose();
    _pwCheckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontSize: 19,
            fontFamily: 'Pretendard Variable',
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Color(0xFFDDDDDD)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '이메일을 입력해 주세요.',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, fontFamily: 'Pretendard Variable'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _isEmailValid
                        ? () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _pwController.text.trim().isEmpty
                              ? "temporaryPassword123!" // 안전하게 기본 비밀번호 제공
                              : _pwController.text.trim(),
                        );

                        await credential.user?.sendEmailVerification();

                        setState(() {
                          _emailSent = true;
                          _validateForm();
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("인증 메일이 전송되었습니다.")),
                        );
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("이메일 인증 오류: ${e.message}")),
                        );
                      }
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB5FFFF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text(
                      '인증메일 보내기',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              if (_emailSent)
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    '이메일을 확인해 주세요.',
                    style: TextStyle(color: Colors.green, fontSize: 13, fontFamily: 'Pretendard Variable'),
                  ),
                ),
              const SizedBox(height: 24),
              const Text(
                '아이디를 입력해 주세요.',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, fontFamily: 'Pretendard Variable'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _idController,
                decoration: _inputDecoration(),
              ),
              const SizedBox(height: 24),
              const Text(
                '비밀번호를 입력해 주세요.',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, fontFamily: 'Pretendard Variable'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _pwController,
                obscureText: true,
                decoration: _inputDecoration(),
              ),
              const SizedBox(height: 24),
              const Text(
                '비밀번호를 확인 하겠소.',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, fontFamily: 'Pretendard Variable'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _pwCheckController,
                obscureText: true,
                decoration: _inputDecoration(error: !_isPasswordMatch),
              ),
              if (!_isPasswordMatch && _pwCheckController.text.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    '비밀번호가 다릅니다.',
                    style: TextStyle(color: Colors.red, fontSize: 13, fontFamily: 'Pretendard Variable'),
                  ),
                ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isFormValid
                      ? () async {
                    final user = FirebaseAuth.instance.currentUser;
                    await user?.reload();
                    if (user != null && user.emailVerified) {
                      // Firestore에 사용자 정보 저장
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .set({
                        'email': user.email,
                        'userId': _idController.text.trim(),
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Nickname()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('이메일 인증을 먼저 완료해주세요.')),
                      );
                    }
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid ? const Color(0xFFB5FFFF) : const Color(0xFFDFDFDF),
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
      ),
    );
  }
}
