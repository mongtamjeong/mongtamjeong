import 'package:flutter/material.dart';
import 'nickname.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _phoneController = TextEditingController();
  final _idController = TextEditingController();
  final _pwController = TextEditingController();
  final _pwCheckController = TextEditingController();

  bool _isPasswordMatch = true;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validateForm);
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
    setState(() {
      _isFormValid = _phoneController.text.trim().isNotEmpty &&
          _idController.text.trim().isNotEmpty &&
          _pwController.text.trim().isNotEmpty &&
          _pwCheckController.text.trim().isNotEmpty &&
          (_pwController.text == _pwCheckController.text);
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _idController.dispose();
    _pwController.dispose();
    _pwCheckController.dispose();
    super.dispose();
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
                '전화번호를 입력해 주세요.',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, fontFamily: 'Pretendard Variable'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration(),
              ),
              const SizedBox(height: 24),
              const Text(
                '아이디를 입력해 주세요.',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, fontFamily: 'Pretendard Variable'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _idController,
                      decoration: _inputDecoration(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        // 중복 확인 로직
                      },
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
                        '중복확인',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
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
              const SizedBox(height: 40), // Spacer 대신 여백
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isFormValid
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Nickname()),
                    );
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
