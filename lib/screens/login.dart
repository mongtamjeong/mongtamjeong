import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _idController.addListener(_validateFields);
    _pwController.addListener(_validateFields);
  }

  void _validateFields() {
    setState(() {
      _isButtonEnabled =
          _idController.text.trim().isNotEmpty && _pwController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '로그인',
          style: TextStyle(fontSize: 19,
            fontFamily: 'Pretendard Variable',
            fontWeight: FontWeight.w600,),
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
              '아이디를 입력해 주시오.',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                fontFamily: 'Pretendard Variable',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFB5FFFF)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFB5FFFF)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '비밀번호를 입력해 주시오.',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                fontFamily: 'Pretendard Variable',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFB5FFFF)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFB5FFFF)),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isButtonEnabled ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Home()),
                  );
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  _isButtonEnabled ? const Color(0xFFB5FFFF) : const Color(0xFFDFDFDF),
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
