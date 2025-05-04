import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'wishList.dart';
import 'chat1.dart';
import 'find_found1.dart';
import 'myPage.dart';
import 'home.dart';
import 'category_auto.dart';
import 'factcheck2.dart';

class ImageFound extends StatefulWidget {
  @override
  State<ImageFound> createState() => _ImageFoundState();
}

class _ImageFoundState extends State<ImageFound> {
  int? selectedIndex; // 어떤 버튼이 선택됐는지
  bool secondTap = false; // 두 번째 탭 여부

  String topText = '찾았다!\n이 도끼가 네 도끼냐?';

  void handleCardTap(int index) {
    if (selectedIndex == index && secondTap) {
      // 같은 버튼을 두 번 누르면 다음 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Factcheck2()),
      );
    } else {
      setState(() {
        selectedIndex = index;
        secondTap = selectedIndex == index; // 한 번 눌렀다고 표시
        topText = '그래... 이게 네 금도끼라는거지? \n이 몽탐정이 검증을 해보마';
      });
    }
  }

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
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Wishlist()),
            );}, icon: Icon(Icons.favorite,color: Color(0xFFAEAEAE))),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Color(0xFFAEAEAE))),
        ],
      ),

      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF8FFFF), // 전체 배경색
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  topText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Pretendard Variable',
                  ),
                ),
                SizedBox(height: 22),
                Container(
                  width: 381,
                  height: 260,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStyledCardButton(
                        context,
                        index: 0,
                        title: '어쩌고 저쩌고',
                        subtitle: '어디어디 10분 전',
                      ),
                      const SizedBox(height: 7),
                      _buildStyledCardButton(
                        context,
                        index: 1,
                        title: '어쩌고 저쩌고',
                        subtitle: '어디어디 10분 전',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 143,
                  height: 37,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CategoryAuto()),
                        );
                      },
                      child: const Text(
                        '여기에 없어요',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 원하는 위치에 이미지나 아이콘 추가
          Positioned(
            left: 287,
            top: 438,
            child: SizedBox(
              width: 109,
              height: 149,
              child: SvgPicture.asset(
                'assets/images/grandpa2.svg',
                width: 207,
                height: 284,
              ),
            ),
          ),
        ],
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


  Widget _buildStyledCardButton(BuildContext context, {
    required int index,
    required String title,
    required String subtitle,
  }) {
    bool isSelected = selectedIndex == index;
    return Container(
      width: 315,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Color(0xFFDEFFFF) : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => handleCardTap(index),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
            SizedBox(height: 4),
            Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}


