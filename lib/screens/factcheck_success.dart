import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FactcheckSuccess extends StatefulWidget {
  @override
  State<FactcheckSuccess> createState() => _FactcheckSuccessState();
}

class _FactcheckSuccessState extends State<FactcheckSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '이미지로 찾기',
          style: TextStyle(
            color: const Color(0xFF212121),
            fontSize: 24,
            fontFamily: 'Pretendard Variable',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: Color(0xFFAEAEAE))),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Color(0xFFAEAEAE))),
        ],
      ),
      body: Container(
        color: const Color(0xFFF8FFFF), // 전체 배경색
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
          children: [
            Text(
              textAlign: TextAlign.center,
              '축하하네!\n자네의 금도끼를 찾은듯하군',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pretendard Variable',
              ),
            ),
            SizedBox(
              height: 23,
            ),
            SvgPicture.asset(
              'assets/images/grandpa2.svg',
              width: 207,
              height: 284,
            ),
            SizedBox(height: 23,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              width: 214,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '습득자에게 채팅하기',
                    style: TextStyle(color: Colors.white, fontSize: 19,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // 선택된 탭 인덱스 (0 = 홈)
        type: BottomNavigationBarType.fixed, // 4개 이상일 땐 fixed 필요
        selectedItemColor: Color(0xFFB5FFFF), // 선택된 아이템 색상
        unselectedItemColor: Colors.grey, // 비선택 아이템 색상
        onTap: (index) {
          // 탭 선택 시 실행 (페이지 전환 등)
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
      ),

    );
  }
}
