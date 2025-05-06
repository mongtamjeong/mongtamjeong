import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'nickname.dart';
import 'register.dart';
import 'login.dart';
import 'signin.dart';


class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색
      body: Stack(
        children: [
          // 배경 타원
          Positioned(
            top: -270,
            left: -142,
            child: Container(
              width: 720,
              height: 741,
              decoration: const ShapeDecoration(
                color: Color(0xFFDEFFFF),
                shape: OvalBorder(),
              ),
            ),
          ),

          // 나머지 UI
          Column(
            children: [
              const SizedBox(height: 196),
              const Center(
                child: Text(
                  '몽탐정',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 48,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  '꿈에서도 보고싶은 내 금도끼를 찾으러',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SvgPicture.asset(
                'assets/images/grandpa.svg',
                width: 204,
                height: 279,
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // 흰색 버튼 - 이메일 로그인
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signin()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 61,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            '회원가입 하기',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: SizedBox(
                        width: 380,
                        height: 16,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: '이미 계정이 있으신가요? ',
                                style: TextStyle(
                                  color: Color(0xFF7B7B7B),
                                  fontSize: 13,
                                  fontFamily: 'Pretendard Variable',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => Login()),
                                    );
                                  },
                                  child: Text(
                                    '로그인 하기',
                                    style: TextStyle(
                                      color: Color(0xFF7B7B7B),
                                      fontSize: 13,
                                      fontFamily: 'Pretendard Variable',
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
