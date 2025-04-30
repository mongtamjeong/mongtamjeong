import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Complete extends StatelessWidget {
  const Complete({super.key});

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
          Positioned(
            left: 16,
            top: 814,
            child: SizedBox(
              width: 380,
              height: 28,
              child: Text(
                '확인',
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
          Positioned(
            left: 16,
            top: 493,
            child: SizedBox(
              width: 380,
              height: 28,
              child: Text(
                '햄수, 반갑소!',
                textAlign: TextAlign.center,
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
            top: 541,
            child: SizedBox(
              width: 380,
              height: 40,
              child: Text(
                '지금부터 나와 함께 꿈에서도 보고픈\n그 금도끼를 찾으러 떠나보시게',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            left: 133,
            top: 275,
            child: Container(
              width: 145,
              height: 198,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: SvgPicture.asset(
                'assets/images/Layer_3.svg',  // svg 경로 정확히!
                fit: BoxFit.contain,
              ),
          ),
          )],
      ),
    );
  }
}
