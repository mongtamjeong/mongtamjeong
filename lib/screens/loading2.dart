import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'wishList.dart';
import 'chat1.dart';
import 'find_found1_find.dart';
import 'myPage.dart';
import 'home.dart';

class Loading2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이미지로 찾기',
          style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Wishlist()),
          );}, icon: Icon(Icons.favorite)),
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
            SvgPicture.asset(
              'assets/images/cloud.svg',
              width: 207,
              height: 284,
            ),
            SizedBox(height: 23,),
            Text(
              textAlign: TextAlign.center,
              '찾는 중이니 잠시만 기다려주시게...',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                fontFamily: 'Pretendard Variable',
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
              MaterialPageRoute(builder: (context) => FindFound1Find()),
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
