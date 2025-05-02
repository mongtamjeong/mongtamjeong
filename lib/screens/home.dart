import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'wishList.dart';
import 'chat1.dart';
import 'find_found1.dart';
import 'myPage.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('몽탐정 홈',
          style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Wishlist()),
            );
          }, icon: Icon(Icons.favorite)),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
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
              '그래그래...\n무엇을 찾으러 왔느냐?',
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
              'assets/images/grandpa.svg',
              width: 207,
              height: 284,
            ),
            SizedBox(height: 23,),
            PopupMenuButton<String>( // 조건으로 찾기
              onSelected: (value) {
                if (value == 'pet') {
                  // 색상으로 찾기 기능 실행
                } else if (value == 'digital') {
                  // 카테고리로 찾기 기능 실행
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$value 선택됨')));
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'pet', child: Text('반려동물')),
                const PopupMenuItem(value: 'digital', child: Text('디지털')),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                margin: const EdgeInsets.only(bottom: 12),
                width: 214
                ,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '조건으로 찾기',
                      style: TextStyle(color: Colors.white, fontSize: 19,),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
            ),
            // 이미지로 찾기 ▼ 버튼
            PopupMenuButton<String>(
              onSelected: (value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$value 선택됨')));
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: '사진 촬영', child: Text('사진 촬영')),
                const PopupMenuItem(value: '갤러리에서 선택', child: Text('갤러리에서 선택')),
              ],
              child: Container(
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
                      '이미지로 찾기',
                      style: TextStyle(color: Colors.white, fontSize: 19,),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
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
          if(index == 0){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          }
          else if (index == 1){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FindFound1()),
            );
          }
          else if (index == 2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Chat1()),
            );
          }else if (index == 3){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Mypage()),
            );
          }

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
