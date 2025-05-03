import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'nickname.dart';

class Start extends StatelessWidget {
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
            left: -142,
            top: -270,
            child: Container(
              width: 720,
              height: 741,
              decoration: ShapeDecoration(
                color: const Color(0xFFDEFFFF),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 105,
            top: 319,
            child: Container(
              width: 204,
              height: 279,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: SvgPicture.asset('assets/images/grandpa.svg'),
            ),
          ),
          Positioned(
            left: 16,
            top: 637,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Nickname()),
                );
              },
              child: Container(
                width: 380,
                height: 61,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFCE64A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 714,
            child: Container(
              width: 380,
              height: 61,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 791,
            child: Container(
              width: 380,
              height: 61,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: const Color(0xFF00A1FF),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 122,
            top: 196,
            child: SizedBox(
              width: 169,
              height: 74,
              child: Text(
                '몽탐정',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 48,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            left: 98,
            top: 262,
            child: SizedBox(
              width: 217,
              height: 23,
              child: Text(
                '꿈에서도 보고싶은 내 금도끼를 찾으러',
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
        ],
      ),
    );
  }
}
