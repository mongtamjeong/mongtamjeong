import 'package:flutter/material.dart';
import 'complete.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatelessWidget {
  final String nickname;
  const Profile({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 412,
      height: 917,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 797,
            child: Container(
              width: 380,
              height: 61,
              decoration: ShapeDecoration(
                color: const Color(0xFFB5FFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned( //다음 버튼
            left: 16,
            top: 814,
            child: SizedBox(
              width: 380,
              height: 28,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Complete(nickname: nickname)),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // 텍스트 위치 유지
                ),
                child: Text(
                  '다음',
                  textAlign: TextAlign.center,
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
          Positioned(
            left: 16,
            top: 745,
            child: SizedBox(
              width: 380,
              height: 30,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Complete(nickname: nickname,)), // 여기에 이동할 위젯 넣기
                  );
                },
                child: const Text(
                  '지금은 넘어가기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF7B7B7B),
                    fontSize: 19,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 115,
            top: 302,
            child: GestureDetector(
              onTap: () {
                // TODO: 프로필 편집 기능 연결 (사진 선택)
              },
              child: SvgPicture.asset(
                'assets/images/profileImage.svg',
                width: 182,
                height: 182,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Positioned(
            left: 430,
            top: 108,
            child: Container(
              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
              width: 446,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: const Color(0xFFDFDFDF),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 141,
            child: SizedBox(
              width: 380,
              height: 35,
              child: Text(
                '프로필을 설정해 주시오.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 69,
            child: SizedBox(
              width: 380,
              height: 28,
              child: Text(
                '프로필 설정',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


