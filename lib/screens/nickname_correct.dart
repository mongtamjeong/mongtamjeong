import 'package:flutter/material.dart';
import 'profile.dart';

class NicknameCorrect extends StatelessWidget {
  const NicknameCorrect({super.key});

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
            top: 195,
            child: Container(
              width: 380,
              height: 61,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: const Color(0xFFB5FFFF),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
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
              height: 28,
              child: Text(
                '이름을 설정해 주시오.',
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
                '닉네임 설정',
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
          Positioned(
            left: 16,
            top: 814,
            child: SizedBox(
              width: 380,
              height: 28,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
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
            top: 218,
            child: SizedBox(
              width: 380,
              height: 16,
              child: Text(
                '   햄수',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(             //이름 입력 칸
            left: 16,
            top: 218,
            child: SizedBox(
              width: 366,
              height: 16,
              child: Text(
                '2/5',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xFFB2B2B2),
                  fontSize: 19,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
